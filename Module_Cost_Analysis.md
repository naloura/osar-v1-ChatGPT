# Module — Cost Analysis and Comparative Assessment (ChatGPT Edition)
**Module Type:** Required for all assessments
**Parent Document:** `Security_Impact_Report_AI_Instructions.md`
**Module Reference:** SIR-MOD-COST-001

---

## Step 5 — Cost Analysis Methodology

After all analysis and report sections are complete, append Section 9.2 (project resource usage) and Section 9.3 (comparative assessment model). Both are **[REQUIRED]**.

ChatGPT does not surface per-thread token-billing data the way some API consoles do. The cost methodology in this module therefore prefers a **wall-clock + analyst-hour** model. Token-level estimation is supported as an optional refinement when Code Interpreter is enabled.

### 5.1 Primary Method — Wall-Clock and Analyst Hours

For Section 9.2, capture:

- **Active session duration:** From the user's first message in the assessment thread to the final report delivery, in hours and minutes. The user provides this; the GPT cannot directly observe wall-clock time.
- **Analyst review time:** Time the analyst spent providing context, validating output, and making edits, in hours.
- **Total elapsed calendar time:** The wall-clock span from kickoff to delivery, in business days, accounting for review cycles.

This is the canonical cost view for a ChatGPT-driven workflow because the analyst's time dominates the total cost — token cost is rounding error by comparison.

### 5.2 Secondary Method — Optional Token Estimation (Code Interpreter)

If Code Interpreter is enabled and the user wants a token-level cost estimate, run an approximation:

```python
# Approximate token count for a markdown document.
# OpenAI's tokenizers (cl100k_base, o200k_base) are NOT available offline in
# the Code Interpreter sandbox — use a character-ratio heuristic.
def approximate_tokens(text):
    # Rough heuristic: ~4 chars per token for English prose.
    # Code, JSON, and structured data tend to be ~3.5 chars per token.
    return len(text) // 4

# Apply to: instruction file + module files consulted + user-uploaded source +
# the rendered report output. Sum input + output for total session token volume.
```

Document this as **approximate**. Do not represent it as a billing-grade figure.

### 5.3 Subscription Cost Allocation

For ChatGPT users, the relevant cost is typically the seat license, not per-token billing:

- **ChatGPT Plus:** $20/month/user
- **ChatGPT Team:** $30/month/user (annual) or $25 (annual prepay tier where applicable)
- **ChatGPT Enterprise:** Variable by contract — typically negotiated per-seat with admin controls and SSO

A useful framing for Section 9.2 is to allocate a fraction of the analyst's monthly seat cost to each report based on how many reports the seat produces in a typical month. **Verify current subscription pricing** at `https://openai.com/chatgpt/pricing/` if Web Browsing is enabled — pricing changes from time to time.

### 5.4 Required Tables in Section 9.2

- **Wall-Clock and Effort Summary:** Active session duration / Analyst review hours / Calendar elapsed days / Method
- **Optional Token Estimation:** Input tokens (approx) / Output tokens (approx) / Methodology note
- **Subscription Cost Allocation:** Tier / Seat cost / Reports per month / Allocated cost per report

Include a paragraph identifying the largest cost driver (almost always analyst time).

---

## Report Section 9.2 — Project Resource Usage and Cost Analysis [REQUIRED]

This section documents the cost of AI-assisted report generation for transparency and budget accountability. Use the wall-clock + analyst-hour model as the primary view; include optional token estimation only if Code Interpreter was used to produce it.

**Wall-Clock and Effort Summary:**

| Metric | Value | Notes |
|---|---|---|
| Active session duration | [HH:MM] | Wall-clock from kickoff to report delivery, per analyst |
| Analyst review hours | [N hours] | Time spent providing context, validating, and editing AI output |
| Calendar elapsed | [N business days] | Includes review cycles |
| Total analyst effort | [N hours] | Sum of active + review time |
| Method | ChatGPT Custom GPT | Plus / Team / Enterprise tier — see Session Config |

**Optional Token Estimation (if produced via Code Interpreter):**

| Token Type | Approximate Count | Methodology |
|---|---|---|
| Input (instructions + modules + uploads) | [N tokens] | Character-ratio heuristic, ~4 chars/token English |
| Output (generated report content) | [N tokens] | Character-ratio heuristic |
| **Total approximate** | **[N tokens]** | Approximation — not billing-grade |

> Token figures are approximations produced via a character-ratio heuristic in Code Interpreter. ChatGPT does not surface per-thread token billing to end users. For organizations that require billing-grade cost data, Enterprise admins can pull aggregate usage from the ChatGPT admin console.

**Subscription Cost Allocation:**

| Metric | Value | Notes |
|---|---|---|
| ChatGPT tier | [Plus / Team / Enterprise] | Per Session Config / user attestation |
| Seat cost (monthly) | $[X] | Verify at openai.com/chatgpt/pricing |
| Reports per month per seat | [N] | Adopter estimate |
| Allocated cost per report | $[X.XX] | Seat cost / reports per month |
| Pricing reference date | [YYYY-MM-DD] | Date pricing was confirmed |

[Include a brief paragraph identifying the largest cost driver — typically analyst time at $[RATE]/hour, which dominates the per-report subscription allocation by 1–2 orders of magnitude. Note that ChatGPT Plus subscription cost is essentially fixed regardless of report volume, so per-report cost falls as utilization rises.]

---

## Report Section 9.3 — Comparative Assessment Model — AI-Assisted vs Alternative Delivery [REQUIRED]

This section compares the cost, timeline, and competency profile of the AI-assisted report generation approach against two alternative delivery models: third-party contractor engagement and in-house FTE execution. This data supports executive decision-making and budget justification for the AI-assisted security review program.

**Assumptions and Methodology:**

The comparison below uses the following baseline assumptions. Adjust rates to reflect current {ORGANIZATION} procurement rates and labor agreements when populating the table.

- **AI-Assisted (current model):** The CISO or designated analyst interacts with this Custom GPT to generate the complete Security and Impact Report. The analyst provides subject matter context, reviews AI output, and validates findings. The GPT handles research, NIST mapping, formatting, and report assembly. Total human effort is review and validation time. Subscription cost is allocated per Section 9.2.
- **Third-Party Contractor:** An external cybersecurity consulting firm is engaged to perform the equivalent security assessment and produce the report. Assumes SOW scoping, vendor selection, kickoff, delivery, and review cycles. Typical rate range: $175–$350/hour depending on firm tier and clearance requirements.
- **In-House FTE:** An existing {ORGANIZATION} staff member performs the assessment. Assumes the FTE is approximately 50% capable for the scope of work (general security knowledge, familiar with the {ORGANIZATION} environment) but would need to engage SME contractors for 25–50% of the specialized analysis (NIST 800-53 mapping, FedRAMP assessment, regulated data framework evaluation, WCAG compliance) depending on the complexity of the asset under review.

**Cost and Effort Comparison:**

| Delivery Model | Estimated Hours | Hourly Rate | Estimated Cost | Timeline | Competency Coverage | Key Assumptions |
|---|---|---|---|---|---|---|
| **AI-Assisted** (analyst + ChatGPT) | [X] hrs analyst review + Custom GPT generation | Analyst: $[RATE]/hr / ChatGPT seat allocated: $[X.XX] (from 9.2) | **$[TOTAL]** | [X hours / X days] | Full scope — GPT covers NIST mapping, data framework scan, WCAG, formatting; analyst validates | Analyst provides context and validates; GPT performs bulk analysis |
| **Third-Party Contractor** | [X–X] hrs | $[175–350]/hr | **$[X,XXX–$X,XXX]** | [X–X weeks] | Full scope with SME depth | Includes SOW, kickoff, analysis, draft, revision, final delivery; assumes contractor has relevant certifications |
| **In-House FTE** | [X–X] hrs FTE + [X–X] hrs SME | FTE: $[RATE]/hr / SME: $[RATE]/hr | **$[X,XXX–$X,XXX]** | [X–X weeks] | FTE: ~50% capable; SME backfill: 25–50% of specialized work | FTE handles general assessment, asset intake, report structure; SMEs engaged for NIST deep-dive, FedRAMP, regulated data frameworks, WCAG |

**Competency Gap Analysis (In-House FTE Model):**

| Assessment Area | FTE Competency | SME Required? | Estimated SME Hours | Notes |
|---|---|---|---|---|
| Asset intake and architecture review | High | No | 0 | FTE familiar with {ORGANIZATION} environment |
| NIST 800-53 Rev 5 control mapping | Medium | Yes — 25–50% | [X–X] hrs | Requires deep familiarity with control applicability and evidence standards |
| Regulated data framework assessment (FTI, SSA, CJIS, HIPAA, PCI) | Low–Medium | Yes — 50% | [X–X] hrs | Requires specialized knowledge of federal data handling agreements and jurisdictional requirements |
| FedRAMP/StateRAMP vendor evaluation | Low | Yes — 50% | [X–X] hrs | Requires familiarity with authorization packages and continuous monitoring |
| WCAG 2.1/2.2 accessibility compliance | Low | Yes — 50% | [X–X] hrs | Requires accessibility testing expertise and WCAG criterion-level knowledge |
| Report formatting and delivery | High | No | 0 | FTE capable with template |
| **Total SME estimate** | — | — | **[X–X] hrs** | Engagement model: hourly contractor or T&M task order |

**Value Summary:**

[One paragraph comparing the three models on cost, speed, consistency, and scalability. Highlight that the AI-assisted model produces reports at a fraction of the cost and timeline while maintaining consistency through the standardized instruction file. Note that the AI-assisted approach also creates a reusable audit trail (session logs, attestation entries) that the other models do not provide by default. Acknowledge limitations: AI output requires human validation, cannot replace professional judgment for novel or ambiguous findings, and the cost comparison is most favorable for standardized assessments rather than bespoke engagements.]

---

*Module — Cost Analysis (ChatGPT Edition) | Parent: Security_Impact_Report_AI_Instructions.md*
