# SIR-GPT Deployment Guide

This guide walks you through deploying the Security Impact Report toolkit as a **Custom GPT** in OpenAI ChatGPT. It covers both **consumer Plus** and **Team / Enterprise** workspaces, since the steps differ in distribution and admin controls but the build process is the same.

## Prerequisites

- A ChatGPT subscription that supports Custom GPTs:
  - **ChatGPT Plus** (consumer) — Custom GPTs are available; sharing is via link to anyone with a ChatGPT account.
  - **ChatGPT Team** — Custom GPTs are scoped to your workspace; shareable to workspace members.
  - **ChatGPT Enterprise** — Custom GPTs are admin-controlled; can be deployed at the workspace, group, or organization level. SSO and no-training guarantees apply.
- A copy of this folder (`OSAR v1 - ChatGPT/`) downloaded locally.
- A logo file for your cover page — replace `Cover_Logo_Base64.txt` if you want your own.
- A draft Session Config block — easiest if you've already run the configurator once in a scratch thread to produce one.

## Choosing the right tier

| Tier | Use this tier if... | Watch out for |
|---|---|---|
| ChatGPT Plus | You're piloting the toolkit personally or sharing with a small group of trusted reviewers. | Conversations may be used to improve OpenAI's models unless you opt out (Settings → Data Controls → Improve the model for everyone → Off). Memory is on by default. |
| ChatGPT Team | A small org/team wants a shared GPT with no-training guarantees. | Memory may still be on per-user — confirm with your team. |
| ChatGPT Enterprise | A regulated or public-sector org. SSO, audit logs, no-training, admin Memory controls. | Custom GPT publishing is admin-gated; you may need to coordinate with your workspace admin to publish org-wide. |

For any organization that may handle regulated data (PII, PHI, PCI, FTI, SSA, CJIS), use Team or Enterprise. The Step 0 gate behaves identically across tiers, but the underlying contractual data-handling differs significantly. See `ChatGPT_Data_Handling_Notes.md` for the full breakdown.

## Step 1 — Create the Custom GPT

1. Open ChatGPT and go to **Explore GPTs → Create**, or visit `https://chatgpt.com/gpts/editor` directly.
2. In the **Configure** tab, set:
   - **Name:** `SIR-GPT — Security Impact Report` (or your org's preferred label)
   - **Description:** `Generates decision-grade Security and Impact Reports for applications, vendor SaaS, and source-code releases.`
   - **Profile picture:** upload your org's icon, or use the auto-generated one.

## Step 2 — Paste the Instructions

1. Open `Custom_GPT_Instructions.txt` from this folder.
2. Copy its **entire contents** (it is sized to fit under the 8,000-character limit).
3. Paste into the GPT editor's **Instructions** field.

Do not edit the Instructions further at this point. The instructions reference the knowledge files by exact filename — changing them risks breaking the orchestration.

## Step 3 — Set conversation starters

In the **Conversation starters** section, add these four (already named in the Instructions file):

1. `Run a Security Impact Report on a vendor SaaS solution`
2. `Run a Security Impact Report on an internally-developed application`
3. `Run a Security Impact Report on a source-code release I'll upload`
4. `Help me build a Session Config block for my organization`

## Step 4 — Enable capabilities

In the **Capabilities** section, **enable**:

- ✅ **Web Browsing** — for verifying vendor FedRAMP / SOC 2 status, NIST revision currency, WCAG version, and OpenAI pricing
- ✅ **Code Interpreter & Data Analysis** — for cover-page PDF rendering, file-size and gzip measurements, contrast-ratio checks, POA&M XLSX export, and approximate token estimation

**Disable:**

- ❌ **DALL·E Image Generation** — not needed; the cover page logo is rendered via Code Interpreter from a base64 file
- ❌ **Custom Actions** — out of scope for v1. Future extensions could wire Actions into Qualys, CrowdStrike, ServiceNow APIs.

## Step 5 — Upload knowledge files

In the **Knowledge** section, upload the following files in this order. The order does not technically matter for retrieval, but uploading the spec first keeps the file list logical when you revisit the GPT later.

1. `Security_Impact_Report_AI_Instructions.md`
2. `modules/Module_NIST_800-53_Controls.md`
3. `modules/Module_Cost_Analysis.md`
4. `modules/Module_Infrastructure_Impact.md`
5. `modules/Module_Vendor_Compliance.md`
6. `modules/Module_WCAG_Accessibility.md`
7. `modules/Module_POAM.md`
8. `modules/Module_Source_Code_Analysis.md`
9. `assets/Cover_Logo_Base64.txt` *(swap with your own logo if desired)*
10. `config.example.yaml`
11. `examples/Example_Report_AcmeStateCyber.md`

That's 11 files. The Custom GPT knowledge limit is 20 files, so you have headroom for any custom modules your org adds (e.g., a privacy impact module, a threat-modeling module, jurisdictional law mappings).

> **Filename note:** ChatGPT presents knowledge files by their bare filename, not their folder path. The Custom GPT Instructions and the modules reference each other by bare filename precisely for this reason. If you rename a file, update every cross-reference.

## Step 6 — Validate against the example report

Before sharing the GPT with anyone, run a smoke test:

1. Open a new chat with the GPT.
2. When it asks "First-time setup, or do you have a saved Session Config block to paste?" — paste the Session Config from `examples/Example_Report_AcmeStateCyber.md` (or build a quick fictional one).
3. Ask: `Run a Security Impact Report on a fictional internal training app called PhishTrainer 2. It uses Entra ID SSO, runs in our Azure Gov subscription, and is internal-only.`
4. Verify the GPT:
   - Acknowledges the Session Config and your specified org name on the cover page
   - Executes Step 0 (no regulated data → no challenge required, but the session log entry is generated)
   - Produces all required sections in the right order with the frozen names
   - References modules by exact filename in cross-references
   - Offers the six follow-up actions in Step 6 (PDF render, exec brief, NIST checklist, POA&M XLSX, cost-comparison summary, re-run with different Session Config)

If any of those fail, double-check (a) that all 11 knowledge files uploaded successfully and (b) that the Instructions field contains the full text of `Custom_GPT_Instructions.txt`.

## Step 7 — Share and govern

### ChatGPT Plus

- Click **Save → Anyone with the link** (or **Only me**, then share manually).
- The GPT URL looks like `https://chatgpt.com/g/g-XXXXXX-sir-gpt`.
- Anyone with a ChatGPT account can use it. Note that their conversations follow *their* tier's data-handling rules, not yours.

### ChatGPT Team

- Click **Save → Anyone in [Workspace]**.
- The GPT shows up in your workspace's GPT picker.
- Workspace members inherit Team data-handling guarantees (no training on inputs by default).

### ChatGPT Enterprise

- Coordinate with your workspace admin. Enterprise GPTs can be:
  - Restricted to specific groups (e.g., `Cybersecurity` / `GRC` groups)
  - Published to the entire workspace
  - Disabled until reviewed by your admin team
- Admins can also pin the GPT to the workspace's GPT picker for visibility.
- For any GPT that may handle regulated data, get explicit governance approval before publishing.

### Distribution checklist

Before sharing the GPT URL with anyone, confirm:

- [ ] The Custom GPT smoke test passed against the example asset
- [ ] The Session Config block for your organization is documented somewhere users can copy it (e.g., your internal wiki or a pinned chat message in your team channel) — users will paste this into every new thread
- [ ] Users have been pointed at `ChatGPT_Data_Handling_Notes.md` (or its content has been merged into your AI Acceptable Use Policy)
- [ ] If your org handles regulated data, an admin has confirmed Memory is disabled at the workspace level, OR users have been instructed to disable Memory before any regulated-data session
- [ ] An owner has been designated for the GPT — someone who will update the knowledge files when the spec or modules change

## Updating the GPT

When you change the spec or any module:

1. Edit the file locally.
2. In the Custom GPT editor, **delete** the old version of that file from Knowledge.
3. **Upload** the new version.
4. Save the GPT. Existing threads continue with the prior content cached in their context, but new threads will retrieve the updated file.

For non-trivial changes (new module, frozen-section rename, new compliance rule), bump the version number in `Security_Impact_Report_AI_Instructions.md` and add a CHANGELOG entry.

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| GPT ignores the Session Config block | The block heading is wrong | Confirm it starts with `## SIR Session Config` exactly (markdown H2, no leading spaces) |
| GPT asks for a module that isn't loaded | Knowledge file missing or named differently | Re-upload the module under its exact expected filename |
| Cover page renders without the logo | This is correct in chat — base64 inline `<img>` does not render reliably | Ask the GPT to render a styled PDF via Code Interpreter |
| GPT produces a control outside the 27 in the NIST module | Spec violation — Rule 6 ignored | Tell the GPT to re-read `Module_NIST_800-53_Controls.md` and revise |
| Step 0 gate skipped | Likely a content-classifier false negative on a small upload | Re-upload the file and explicitly ask the GPT to run the Step 0 gate |
| Web Browsing returns no result | Browsing capability disabled, or the cited URL is gated/blocked | Re-enable Browsing in the GPT config; or instruct the user to provide the source manually |

## Where to go from here

- Add custom modules for your org (e.g., privacy impact, threat modeling). Follow the same hub-and-spoke pattern: each module begins with `# Module — [Name]`, references the parent spec, and has a stable `SIR-MOD-*-001` reference ID.
- Pre-bake a localized version of the toolkit using `configure.sh` (still works for power users who want to ship a pre-substituted variant). The script lives in this folder and is unchanged from the model-agnostic v1 baseline.
- Contribute back: see `CONTRIBUTING.md`. Vendor stack examples beyond Microsoft + CrowdStrike + Qualys, jurisdictional law mappings beyond U.S. states, and additional fully-rendered example reports are especially welcome.

---

*SIR-GPT Deployment Guide — ChatGPT Edition | v1.0 | 2026-05-02*
