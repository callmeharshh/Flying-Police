// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title EvidenceRegistry
/// @notice Tamper-proof anchoring of Air-Secure drone security evidence on Monad.
///         Each alert/event is hashed off-chain (keccak256 over a canonical JSON
///         representation) and the hash is anchored here with minimal metadata.
///         The chain provides an immutable, timestamped, independently-verifiable
///         record — anyone holding the original evidence can prove it existed at a
///         given time and has not been altered.
/// @dev    Writes are owner-gated (only the drone operator's signer key can anchor).
///         Reads are public. Monad's high throughput + low fees make anchoring
///         high-frequency drone events economically practical, unlike Ethereum L1.
contract EvidenceRegistry {
    struct Record {
        uint64 anchoredAt; // block.timestamp when anchored (0 => never anchored)
        uint64 frameId;    // source frame id from the perception pipeline
        uint8 severity;    // 0=low, 1=medium, 2=high
        address anchoredBy;
    }

    address public owner;

    /// @dev evidenceHash => Record. First write wins; re-anchoring is rejected so
    ///      the original timestamp is authoritative.
    mapping(bytes32 => Record) private _records;

    uint256 public totalAnchored;

    event EvidenceAnchored(
        bytes32 indexed evidenceHash,
        uint64 indexed frameId,
        uint8 severity,
        uint64 anchoredAt,
        address indexed anchoredBy
    );

    event OwnershipTransferred(address indexed from, address indexed to);

    error NotOwner();
    error AlreadyAnchored(bytes32 evidenceHash);
    error LengthMismatch();
    error ZeroAddress();

    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    /// @notice Anchor a single piece of evidence.
    function anchor(bytes32 evidenceHash, uint64 frameId, uint8 severity) external onlyOwner {
        _anchor(evidenceHash, frameId, severity);
    }

    /// @notice Anchor many pieces of evidence in one transaction.
    /// @dev The Monad-native efficiency path: buffer alerts and flush as a batch.
    function batchAnchor(
        bytes32[] calldata evidenceHashes,
        uint64[] calldata frameIds,
        uint8[] calldata severities
    ) external onlyOwner {
        if (evidenceHashes.length != frameIds.length || frameIds.length != severities.length) {
            revert LengthMismatch();
        }
        for (uint256 i = 0; i < evidenceHashes.length; i++) {
            _anchor(evidenceHashes[i], frameIds[i], severities[i]);
        }
    }

    function _anchor(bytes32 evidenceHash, uint64 frameId, uint8 severity) private {
        if (_records[evidenceHash].anchoredAt != 0) revert AlreadyAnchored(evidenceHash);
        uint64 ts = uint64(block.timestamp);
        _records[evidenceHash] = Record({
            anchoredAt: ts,
            frameId: frameId,
            severity: severity,
            anchoredBy: msg.sender
        });
        unchecked {
            totalAnchored++;
        }
        emit EvidenceAnchored(evidenceHash, frameId, severity, ts, msg.sender);
    }

    /// @notice Verify whether a hash was anchored, and when.
    /// @return exists     true if the hash has been anchored
    /// @return anchoredAt block timestamp of anchoring (0 if never)
    function verify(bytes32 evidenceHash) external view returns (bool exists, uint64 anchoredAt) {
        Record memory r = _records[evidenceHash];
        return (r.anchoredAt != 0, r.anchoredAt);
    }

    /// @notice Full record for a hash (frameId/severity/anchoredBy alongside timestamp).
    function getRecord(bytes32 evidenceHash) external view returns (Record memory) {
        return _records[evidenceHash];
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert ZeroAddress();
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
