# Module — Plan of Action and Milestones (POA&M) (ChatGPT Edition)
**Module Type:** Conditional — Overall Risk Rating is MEDIUM, HIGH, or CRITICAL (not LOW)
**Trigger:** The Overall Cybersecurity Risk Rating determined in Section 1.2 is anything other than LOW
**Parent Document:** `Security_Impact_Report_AI_Instructions.md`
**Module Reference:** SIR-MOD-POAM-001

> **Code Interpreter affordance:** if Code Interpreter is enabled, after generating Section 8.6 in chat you may offer the user a downloadable XLSX tracking spreadsheet with one row per POA&M entry. Use `openpyxl` or `pandas.to_excel`. Columns must match the entry table below; add a header row, freeze the top row, and apply column widths sized for readability. Save the file with a name like `POAM_Tracking_<asset>_<YYYYMMDD>.xlsx` and present it as a download link.

---

## When to Generate This Section

This module activates **automatically** when the Overall Cybersecurity Risk Rating (the rating on the cover page and in Section 1.2) is **MEDIUM**, **HIGH**, or **CRITICAL**. If the rating is **LOW**, this entire section is omitted from the report.

The POA&M captures every finding that contributed to the elevated risk rating and creates actionable remediation entries. Each entry maps back to a specific NIST 800-53 control deviation, risk, or configuration gap identified during the assessment.

---

## Report Section 8.6 — Plan of Action and Milestones (POA&M) [CONDITIONAL — non-LOW risk only]

> **Note:** This section number (8.6) is used when Section 8 (WCAG) is present (since WCAG uses subsections 8.1–8.5). If Section 8 is omitted (internal-only asset), this section becomes **Section 8 — Plan of Action and Milestones (POA&M)** instead.

### 8.6.1 POA&M Overview

[One paragraph: summarize how many POA&M entries were generated, the overall risk posture, and the general remediation timeline. Reference the Overall Risk Rating from Section 1.2.]

> **POA&M Generated:** This report identified **[N]** findings requiring remediation. The following Plan of Action and Milestones entries document each finding, the associated risk, and the recommended path to resolution. All entries should be tracked to closure before the asset transitions from its current deployment status.

### 8.6.2 POA&M Entry Table

Generate one row per finding. Sources for entries include:
- NIST controls assessed as **Process Dependent** or **Configuration Required** in Section 7
- Data security findings from Section 6 that elevate risk
- Infrastructure impact concerns from Section 5 rated as HIGH
- WCAG findings rated Critical or Major from Section 8 (if applicable)
- Any other finding that directly contributed to the non-LOW risk rating

| POA&M ID | Control Deviation | Risk Statement | Risk Rating | Recommendation | Expected Fix (Days) | Investment Required | Owner |
|---|---|---|---|---|---|---|---|
| POAM-001 | [Control ID and Name — e.g., "CM-6 Configuration Settings"] | [1–2 sentence description of the specific risk this creates for {ORG_SHORT} — what could happen if unresolved] | [Low / Medium / High / Critical] | [Specific, actionable remediation step — what to do, not just what's wrong] | [Estimated calendar days to resolve: 7 / 14 / 30 / 60 / 90] | [Yes / No — whether budget, procurement, or contract action is needed beyond existing staff effort] | [Responsible party: {ORG_SHORT} team, vendor, agency, developer] |
| POAM-002 | [Control ID and Name] | [Risk statement] | [Rating] | [Recommendation] | [Days] | [Yes / No] | [Owner] |
| POAM-[N] | [Control ID and Name] | [Risk statement] | [Rating] | [Recommendation] | [Days] | [Yes / No] | [Owner] |

**Column guidance:**

- **POA&M ID:** Sequential identifier starting at POAM-001. These IDs are referenced in the POA&M summary.
- **Control Deviation:** The NIST 800-53 Rev 5 control ID and name from Section 7 that the finding maps to. If the finding does not map to a specific control (e.g., a vendor compliance gap), cite the most relevant {ORG_SHORT} policy instead (e.g., "{VENDOR_SECURITY_ADDENDUM} — Vendor MFA").
- **Risk Statement:** A concrete description of the risk to {ORG_SHORT}, not a restatement of the control. Example: "Without HTTP security headers, the application is vulnerable to clickjacking and MIME-type attacks on end-user browsers." Not: "CM-6 is not implemented."
- **Risk Rating:** Rate the individual entry, not the overall report. Use the same scale: Low, Medium, High, Critical. A report with an overall MEDIUM rating may have individual entries ranging from Low to High.
- **Recommendation:** Specific and actionable. "Configure Content-Security-Policy, X-Frame-Options, and HSTS headers on the hosting server" — not "Fix security headers."
- **Expected Fix (Days):** Realistic calendar days from report acceptance. Factor in procurement, change management, and testing cycles. Common ranges: Configuration changes (7–14), process documentation (14–30), vendor engagement (30–60), architectural changes (60–90).
- **Investment Required:** "Yes" means the fix requires budget, procurement, new licensing, or contractor engagement beyond what existing staff can do in normal operations. "No" means staff can resolve within existing capacity and tools.
- **Owner:** The party responsible for executing the fix. Use role/team names, not individuals, unless the responsible individual is already identified in the assessment.

### 8.6.3 POA&M Summary

| Metric | Value |
|---|---|
| Total POA&M Entries | [N] |
| Critical | [N] |
| High | [N] |
| Medium | [N] |
| Low | [N] |
| Entries Requiring Investment | [N] of [N] |
| Estimated Total Remediation Timeline | [N] days (longest single entry) |
| Recommended Review Date | [DATE — 30 days from report date for HIGH/CRITICAL, 60 days for MEDIUM] |

### 8.6.4 Tracking and Accountability

[One paragraph: state that the POA&M should be reviewed by the {DIVISION} on the recommended review date, that entries should be tracked in the {ORG_SHORT} risk register or equivalent, and that closure of all HIGH and CRITICAL entries is required before the asset can be reclassified to a lower risk rating. Reference {POLICY_REF:program_management} and {POLICY_REF:risk_assessment} for ongoing assessment authority.]

---

*Module — Plan of Action and Milestones (POA&M) (ChatGPT Edition) | Parent: Security_Impact_Report_AI_Instructions.md*
