# ChatGPT Data Handling Notes

This document is a tier-by-tier reference for how the Security Impact Report (SIR) Custom GPT behaves with respect to OpenAI's data-handling policies, and where the Step 0 attestation gate should be paired with platform-level controls. Read this before publishing the GPT to anyone outside your immediate trusted group.

> **Important:** OpenAI's data-handling policies and product capabilities change. The summaries below were accurate as of 2026-05-02. Verify against the current OpenAI Trust Portal (`https://trust.openai.com`) and the ChatGPT documentation (`https://help.openai.com`) before making governance decisions. If the GPT has Web Browsing enabled, you can ask it to fetch the current policy text directly.

---

## Tier comparison

| Concern | ChatGPT Free | ChatGPT Plus | ChatGPT Team | ChatGPT Enterprise |
|---|---|---|---|---|
| Custom GPTs available | No | Yes | Yes | Yes |
| Inputs used to train OpenAI's models | Yes, by default | Yes, by default (opt-out via Settings → Data Controls) | **No** (contractual) | **No** (contractual) |
| Memory feature | Limited | Yes (on by default) | Yes (admin can disable) | Yes (admin-controlled) |
| SSO | No | No | No (workspace login only) | **Yes** (SAML / OIDC) |
| Audit logs | No | No | Limited | **Yes** |
| Admin GPT controls | No | No | Limited | **Yes** (publish, restrict, disable per group) |
| Data residency commitments | No | No | Limited | **Yes** (contracted) |
| Suitable for SIR with no regulated data | Acceptable with attention | Acceptable | **Recommended** | **Recommended** |
| Suitable for SIR with regulated data (PII, PHI, PCI, FTI, SSA, CJIS) | **No** | **No** | Cautiously, with org governance | **Yes**, with org governance |

The verdict in the bottom row matters most. The Step 0 gate is *procedural*, not *technical*. Your contractual relationship with OpenAI is the technical control. If your contract does not permit the data category, no in-prompt gate will save you from a policy violation.

---

## What changes per tier

### ChatGPT Free

- Do not deploy the SIR-GPT here for any non-trivial assessment.
- Inputs may be used to train OpenAI's models.
- Custom GPTs are not available — Free users can only use other people's published GPTs.

### ChatGPT Plus (consumer)

- Custom GPTs available. Inputs may be used for model training **unless** the user opts out at *Settings → Data Controls → Improve the model for everyone → Off*.
- Memory is on by default. **Disable Memory** before any session that may touch regulated data: *Settings → Personalization → Memory → Off*.
- Best for: solo CISOs, individual analysts piloting the toolkit, contributors to the open-source repo.
- Not recommended for: organizational deployments touching anything more sensitive than `Public//Internal` data.

### ChatGPT Team

- Inputs are not used to train models — this is contractual.
- Custom GPTs are scoped to the workspace and shareable to workspace members.
- Memory is per-user; an admin can disable it at the workspace level if your tenancy supports that toggle.
- Best for: small to mid-size organizations that want a shared GPT and a no-training guarantee.
- Watch out for: per-user Memory. Even with Team-level no-training, a regulated-data fragment captured into one user's Memory can persist across their personal threads.

### ChatGPT Enterprise

- Inputs are not used to train models — contractual.
- SSO, audit logging, admin-controlled GPT publishing, and admin-controlled Memory.
- Best for: regulated industries, public-sector organizations, and any org with a formal AI Acceptable Use Policy.
- Watch out for: even with all the platform controls, **submitting regulated data to a Custom GPT that has not been formally authorized by your governance body is almost certainly a policy violation regardless of tier.** The Step 0 gate's hard-stop logic for FTI / SSA / CJIS at 99%+ confidence is correct on Enterprise too.

---

## Mapping the Step 0 gate to each tier

The Step 0 gate runs identically regardless of tier. Its **outputs** should be interpreted differently based on the tier:

| Step 0 Outcome | On Plus | On Team / Enterprise |
|---|---|---|
| Confidence < 60%: proceed | OK if the user has opted out of training and disabled Memory | OK |
| Confidence 60–98%: attestation challenge | Attestation logged in session log; user accepts personal accountability | Attestation logged; pair with org's AI Acceptable Use Policy (AUP) |
| Confidence ≥ 99% on FTI/SSA/CJIS: hard stop | Hard stop is the right answer — Plus is not a permitted environment for these categories | Hard stop is *still* the right answer unless your org has formally authorized the Custom GPT to receive that category, AND the contractual data-handling boundary has been verified |

The gate is a friction point — it slows down accidental misuse and creates an evidentiary record. It is not a substitute for tier-appropriate tenancy.

---

## Practical guidance for adopters

### If you are running this GPT on Plus

- Opt out of training: *Settings → Data Controls → Improve the model for everyone → Off*.
- Disable Memory: *Settings → Personalization → Memory → Off*.
- Treat any regulated-data hard stop as final. Do not rephrase or re-attest your way past it.
- Use the GPT only for assessments of `Public//Internal` and `Private` data.

### If you are running this GPT on Team

- Confirm with your workspace admin whether Memory is disabled at the workspace level.
- Document in your AUP that regulated-data sessions require Memory off and a fresh thread.
- Pair the GPT with a documented governance review process — who can publish the GPT, who can update its knowledge files, and how Session Config blocks are vetted.

### If you are running this GPT on Enterprise

- Coordinate publishing with your admin team. Restrict the GPT to relevant groups (Cybersecurity, GRC, Risk).
- Confirm that your Enterprise contract covers any data category the GPT might encounter. If FTI / SSA / CJIS are out of scope contractually, leave the Step 0 hard stop in place — do not weaken it.
- Use the audit log to spot-check Step 0 attestation events and Session Review file uploads.
- Update your AI Acceptable Use Policy to name the GPT explicitly and reference the Step 0 gate as a procedural control.

---

## Things the gate cannot do

The Step 0 gate is documented in the spec as a *procedural* control. It cannot:

- Cryptographically verify a Session Review Markdown file's authenticity
- Confirm that the named approver actually signed the document
- Detect a fabricated authorization block that uses the right field names
- Survive a determined bad-faith user
- Prevent ChatGPT Memory from capturing a fragment of regulated content if Memory is enabled
- Substitute for tier-appropriate tenancy

These are platform-, governance-, and process-layer concerns, not prompt-layer concerns. The gate is one layer in a defense-in-depth posture. Your AI Acceptable Use Policy, your contractual tier, your admin controls, and your audit cadence are the others.

---

## Where to verify

- **OpenAI Trust Portal:** `https://trust.openai.com`
- **ChatGPT Help Center:** `https://help.openai.com`
- **ChatGPT pricing:** `https://openai.com/chatgpt/pricing/`
- **ChatGPT Enterprise overview:** `https://openai.com/chatgpt/enterprise/`

If the GPT has Web Browsing enabled, you can ask it to pull current policy text from any of these directly. Ask for citations with retrieval dates so the answer is auditable.

---

*ChatGPT Data Handling Notes — SIR-GPT Toolkit | v1.0 | 2026-05-02*
