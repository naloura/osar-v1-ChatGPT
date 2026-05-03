# Changelog

All notable changes to this toolkit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0-chatgpt] — 2026-05-02

### Added

- **ChatGPT Edition fork** of the model-agnostic v1 toolkit, tailored for deployment as an OpenAI Custom GPT (Plus, Team, Enterprise).
- `Custom_GPT_Instructions.txt` — distilled orchestration prompt sized to fit the 8,000-character Custom GPT Instructions field; references the spec and seven modules by exact filename.
- `Deployment_Guide.md` — step-by-step deployment for Plus, Team, and Enterprise admins; covers GPT creation, capability enablement, knowledge-file upload order, conversation starters, validation, and tier-specific sharing.
- `ChatGPT_Data_Handling_Notes.md` — tier-by-tier reference mapping the Step 0 attestation gate to consumer Plus, Team, and Enterprise behavior; includes ChatGPT Memory protocol guidance.
- In-chat configurator workflow that runs on first invocation when no Session Config block is present — a four-group questionnaire (Identity, Vendor Stack, Jurisdiction, Brand) that emits a reusable `## SIR Session Config` block.
- Code Interpreter affordance callouts in Source Code Analysis (gzip + LOC measurements), WCAG (contrast-ratio checks), POA&M (XLSX export), and Cost Analysis (approximate token estimation).
- Web Browsing affordance callouts in Vendor Compliance (FedRAMP marketplace verification), NIST Controls (revision currency check), WCAG (version check), and Cost Analysis (subscription pricing).
- Code Interpreter–driven cover-page PDF rendering pathway (replaces the inline `<img>` base64 approach that does not render reliably in chat surfaces).
- ChatGPT Memory protocol (Step 0.7) — Memory must be off for any session that may touch regulated data.

### Changed

- `Security_Impact_Report_AI_Instructions.md` rewritten for ChatGPT (v12.0): module loading reframed as "consultation by relevance" rather than literal file loading; flat-namespace filename references (no `modules/` prefix) to match ChatGPT's knowledge-file presentation; added Step −1 (Session Config Bootstrap) and Step 0.7 (ChatGPT Memory Protocol).
- `Module_Cost_Analysis.md` — pivoted from Claude Code JSONL parsing and Anthropic per-token rates to a wall-clock + analyst-hour primary model, with optional Code Interpreter–based token estimation as a secondary refinement. Added subscription cost allocation table for ChatGPT Plus / Team / Enterprise.
- All seven module files updated to reference the parent spec by exact filename and to flag relevant Code Interpreter / Web Browsing affordances inline.
- `README.md` rewritten to lead with the ChatGPT deployment as the primary path; sibling model-agnostic folders (`OSAR v1/`, `security-impact-report/`) called out for adopters who prefer the model-agnostic baseline.

### Security

- Step 0 attestation gate language updated to call out ChatGPT Memory as an additional disclosure surface; even with Memory off, the gate is documented as procedural, not authentication.
- Tier-aware data-handling guidance added: Plus is unsuitable for regulated data even with the gate; Team and Enterprise are suitable only when paired with org governance and (for Enterprise) admin-controlled GPT publishing.

## [1.0.0] — 2026-05-02

### Added

- Initial open-source release.
- Main AI Instructions file (`Security_Impact_Report_AI_Instructions.md`) — orchestrates a hub-and-spoke prompt system that produces a decision-grade security and impact report.
- Six analysis modules under `modules/`:
  - Cost Analysis
  - Infrastructure Impact
  - NIST 800-53 Controls (with control inheritance worked example)
  - Plan of Action and Milestones (POA&M)
  - Source Code Analysis
  - Vendor Compliance
  - WCAG Accessibility
- Configuration token system (`config.example.yaml`) so adopters can localize organization name, policy library, vendor stack, applicable laws, and brand assets without editing source files.
- Helper script (`configure.sh`) that applies a `config.yaml` to a working copy of the source files.
- Neutral placeholder cover-page logo (`assets/Cover_Logo_Base64.txt`).
- Fully-rendered example report (`examples/Example_Report_AcmeStateCyber.md`) against a fictional organization, plus a styled PDF rendering (`examples/Example_Report_AcmeStateCyber.pdf`) so adopters can see the finished output without configuring the toolkit.
- OSS hygiene files: `LICENSE` (Apache-2.0), `SECURITY.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`.

### Security

- Step 0 attestation gate documented as a *procedural* control, not authentication. Adopters are explicitly warned that the model cannot cryptographically verify the attestation block and that the gate must be paired with their own governance.
- Default behavior on disputed regulated-data findings is **refuse-and-escalate**, not proceed.
