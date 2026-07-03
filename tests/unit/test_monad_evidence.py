from blockchain.evidence import build_alert_evidence
from blockchain.monad_client import MonadEvidenceClient
from storage.event_store import EventStore


def test_evidence_payload_is_canonical_for_same_alert():
    first = build_alert_evidence(
        frame_id=7,
        timestamp="2026-07-04T10:30:00+05:30",
        location="perimeter",
        rule_id="RULE-05",
        severity="HIGH",
        message="Activity detected at perimeter at night",
        description="a person near the fence",
        objects=["vehicle", "person"],
        bbox=(10, 20, 30, 40),
        track_id="track_001",
    )
    second = build_alert_evidence(
        frame_id=7,
        timestamp="2026-07-04T10:30:00+05:30",
        location="perimeter",
        rule_id="RULE-05",
        severity="high",
        message="Activity detected at perimeter at night",
        description="a person near the fence",
        objects=["person", "vehicle"],
        bbox=(10, 20, 30, 40),
        track_id="track_001",
    )

    assert first.canonical_json() == second.canonical_json()
    assert first.evidence_hash() == second.evidence_hash()
    assert first.severity_value() == 2


def test_monad_client_skips_when_not_configured():
    evidence = build_alert_evidence(
        frame_id=1,
        timestamp="2026-07-04T10:30:00+05:30",
        location="main_gate",
        rule_id="RULE-01",
        severity="high",
        message="Person detected at night at main_gate",
        description="a person at the gate",
        objects=["person"],
    )
    client = MonadEvidenceClient(
        rpc_url="",
        chain_id=0,
        private_key="",
        contract_address="",
    )

    result = client.anchor(evidence)

    assert result.status == "not_configured"
    assert result.tx_hash is None
    assert result.evidence_hash.startswith("0x")


def test_event_store_records_evidence_anchor(tmp_path):
    store = EventStore(db_path=str(tmp_path / "events.db"))

    anchor_id = store.log_evidence_anchor(
        frame_id=3,
        evidence_hash="0xabc",
        tx_hash="0xdef",
        status="anchored",
        message="Evidence anchored on Monad.",
    )
    anchors = store.get_evidence_anchors()

    assert anchor_id.startswith("anch_")
    assert len(anchors) == 1
    assert anchors[0]["evidence_hash"] == "0xabc"
    assert anchors[0]["tx_hash"] == "0xdef"
    assert anchors[0]["status"] == "anchored"

