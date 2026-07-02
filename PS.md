# Assignment - AI Engineer

> This is a confidential document. This is not to be shared with anyone other than the candidate who is being evaluated for a role. The candidate must destroy their copy of this document after the intended purpose has been served.

## Overview

We are seeking innovative AI engineers who can solve complex problems across diverse domains with a commitment to excellence, efficient execution, and ownership.

This role emphasizes your ability to:

- Build cutting-edge AI solutions using the latest tools and frameworks
- Innovate with modern AI methodologies
- Collaborate effectively

As part of the AI team, we expect the same level of passion, commitment, and pursuit of excellence from you towards your role.

This assignment focuses on your AI engineering skills and problem-solving abilities, applicable to any context.

We expect you to use AI-assisted tools such as:

- Codex
- Cursor AI
- Windsurf
- Lovable
- Replit

Document how these tools helped expedite your work.

---

# Background

You are tasked with designing and prototyping a **Drone Security Analyst Agent** for a docked drone that monitors a fixed property daily.

The agent processes:

- Live telemetry data (e.g., drone position, altitude)
- Video feed in real time

Its responsibilities include:

- Detecting and analyzing security events
- Identifying objects or activities for future reference
- Generating immediate alerts

### Examples

**Object Tracking**

> "A blue Ford F150 entered twice today"

**Security Alert**

> "Person loitering at midnight near main gate"

Your goal is to build a functional prototype that showcases how this could work, using AI to assist you at every stage.

---

# Problem Statement

Create a prototype for the **Drone Security Analyst Agent**.

The system should:

1. Process simulated drone telemetry data and video frames.
2. Analyze video content to identify objects or events (e.g., vehicles, people) and log them with context.
3. Generate real-time security/safety alerts based on predefined rules.
4. Include a cross-domain element: explore indexing video frame-by-frame (e.g., using a database or search tool), even if this is new to you, and use AI to learn and implement it.

---

# Requirements

## 1. Feature Specification

Write a short feature specification defining the agent's value to property owners.

Example:

> Enhances security with automated monitoring.

Include **2–3 key requirements**.

---

## 2. Design / Architecture

Propose a simple architecture for processing telemetry and video.

Examples:

- Data pipeline
- Storage layer
- Alert system

Use AI to suggest or validate the architecture.

---

## 3. Development

### Implementation

- Implement a prototype in a language of your choice (e.g., Python).

### Simulation

Simulate:

#### Video Frames

```text
Frame 1: Blue truck at gate
```

#### Telemetry

```text
Time: 00:01, Location: Gate
```

### AI Usage

Use AI to generate at least one component, such as:

- Object detection logic
- Alert rules

---

## 4. Cross-Domain (Indexing)

Build a basic frame-by-frame indexing system.

Examples:

- Store frames in a database
- Store timestamps
- Make frames searchable

Use AI to learn this if unfamiliar.

---

## 5. QA

Create test cases to verify functionality.

Examples:

- Truck logged correctly
- Alert triggered at midnight

Use AI to assist with testing.

---

# Expected Sample Output

## Logs

```text
Blue Ford F150 spotted at garage, 12:00.
```

## Alert

```text
Person loitering at main gate, 00:01.
```

## Indexed Frames

Queryable by:

- Time
- Object

Example:

```text
Show all truck events
```

---

# Submission Details

## Code

### GitHub Repository

- Submit code through a private GitHub repository.
- GitHub private repositories are free.
- Upload:
  - VLM scripts
  - LangChain agent code
  - Context management implementation
  - Test scripts

### Repository Access

Add:

```text
assignments@flytbase.com
```

as a contributor.

---

## Comprehensive Documentation

### README

Include:

- Detailed setup instructions
- Running instructions
- Design decisions
- Architectural choices
- AI tools used
- Impact of AI tools on development workflow

### Design Artifacts

Submit:

- Flowcharts
- System architecture diagrams
- Other design artifacts

### Testing Documentation

Explain:

- Validation strategy
- Test cases
- Dynamic input testing
- Emergency response scenarios

---

## Videos

Submit one or more screen recordings demonstrating:

- Video processing
- Context summaries
- Agent recommendations
- Scalability tests
- Innovative features

Examples:

- Frame descriptions
- Agent output
- Generated captions

### Important

Your demo video **must include your voiceover** explaining the solution.

Videos without voiceover may lead to incorrect evaluation.

---

## Report

Submit a PDF report summarizing your approach.

### Include

#### Assumptions

Examples:

- Dataset choice
- VLM selection

#### Tool Selection Justification

Examples:

- Why CLIP instead of BLIP?
- Why this agent architecture?

#### Results

Show examples of:

- Frame descriptions
- Agent recommendations

Reference demo videos.

#### Future Improvements

Examples:

- Video summarization
- More advanced VLM
- Better indexing
- Additional agent capabilities

#### AI Assistance Documentation

Example:

> Codex generated LangChain agent code, but I customized the prompt.

#### Video Links

Attach videos to the email or provide links (e.g., Google Drive) with proper viewing permissions.

---

# Additional Notes

## Environment Setup

You are responsible for setting up:

- Python
- Hugging Face Transformers
- LangChain
- OpenCV

and any required datasets or tools.

Include setup instructions in the README.

---

## For Novices

If you lack experience with:

- LangChain
- VLMs
- Related tools

mention it in your report.

Evaluation will consider:

- Effort
- Learning approach
- Adaptability

---

## Report Weightage

The report carries equal weight in the assessment.

Spend sufficient time explaining:

- Reasoning
- Decisions
- Analysis

---

# Academic Integrity

Any candidate found guilty of plagiarism will:

- Be disqualified from the assignment
- Not be considered for further evaluation

---

# Sharing Requirements

- Ensure proper viewing permissions for repositories and videos.
- Provide clear environment setup instructions in the README.
- Provide clear project execution instructions.

---

# Assessment Metrics

| Category | Weight |
|-----------|---------|
| Correctness & Model Performance | 25% |
| Reasoning & Scalability | 25% |
| Experimentation & Innovation | 30% |
| Documentation & Code Quality | 20% |

## Correctness & Model Performance (25%)

- VLM generates meaningful frame descriptions
- Agent provides relevant recommendations

## Reasoning & Scalability (25%)

- Agent uses context throughout the video

## Experimentation & Innovation (30%)

- Novel problem-solving approaches
- Strong documentation and report quality

## Documentation & Code Quality (20%)

- Clear README
- Well-structured code
- Detailed report

---

# Bonus Enhancements

## Video Summarization

Generate a one-sentence summary of the video.

Example:

```text
Vehicle entered property and exited without incident.
```

## Follow-up Question Answering

Allow the agent to answer questions such as:

```text
What objects were in the video?
```