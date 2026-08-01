# Ranstam et al. (2000) — Fraud in medical research: an international survey of biostatisticians (ISCB Subcommittee on Fraud)

**Citekey:** `ranstam_fraud_2000` · *Controlled Clinical Trials* 21(5):415–427 · doi:10.1016/s0197-2456(00)00069-6 · **PDF:** `files/38836/`

Survey of International Society for Clinical Biostatistics members, April–July 1998. 163 of 442 responded (37%) — the authors publish despite the low rate because the findings were striking. The ancestor of the Wang et al. (2018, 2019) biostatistician surveys.

## Key findings (Table 3)

| | n (%) |
|---|---|
| Know of ≥1 fraudulent project in the proximity in the last 10 years | **81 (51%)** |
| Have been engaged in a project in which fraud took place or was about to | 49 (31%) |
| Have been **requested to support fraud** themselves | **20 (13%)** |
| Consider the main motive career/power rather than financial | 126 (76%) |
| Believe fraud's impact on medical science important or a major problem | 104 (65%) |
| Do not know whether their organization has a system for handling suspected fraud, or know it does not | 103 (63%) |

Of the fraud types known about: fabrication/falsification of data and **suppression or selective deletion of data (31 cases)** were reported in "fairly similar numbers", alongside deceptive design/analysis (16) and deceptive reporting (32). Among the 20 who had been asked to support fraud personally: **3 cases fabrication/falsification, 11 cases suppression or selective deletion of data**, 7 deceptive design/analysis, 12 deceptive reporting.

## Why this matters for the manuscript

**Two things, one of them unusually good.**

**1. The survey's own operational definition of fabrication is written in the mechanism our simulations implement** (Section II preamble, p. ~24 of the PDF):

> Fabrication of data should be considered fraud if the purpose is to change the apparent outcome of a study (e.g., **by increasing the sample size or effect, or by decreasing the variance**).

That is a list of our tampering strategies: fabrication and duplication increase the sample size; fabrication, replacement and switching increase the effect; replacement with low-SD invented values decreases the variance. A 1998 survey of clinical biostatisticians defined fraud by exactly the levers our greedy algorithms pull. Excellent for the Methods or Discussion — it establishes that the strategies we simulate are not our invention but the field's own working definition of what fraud does.

The same preamble also states the continuum explicitly: "A grey area rather than a clear line often separates acceptable practices from unacceptable ones."

**2. Selective deletion outnumbers fabrication in requests received, 11 to 3.** Small numbers, but the same ordering as every other source in this collection: when someone asks a statistician to help commit fraud, they are ~3–4× more likely to ask for data to be *deleted* than *invented*.

## Suggested use

- **Methods or Discussion**: quote the "increasing the sample size or effect, or by decreasing the variance" definition when introducing or justifying the strategy set. It is the best available evidence that the simulated strategies correspond to what practitioners recognize as fraud.
- **Introduction**: the 51% / 31% / 13% figures as the earliest of the biostatistician-survey findings, showing this concern is 25 years old.
- Historical framing: cite as the predecessor to Wang et al. (2018, 2019), which found very similar patterns two decades later.

## Caution

37% response rate, 1998, ISCB membership only, and the authors are appropriately cautious — they note response rates were *lower* in countries with higher reported fraud participation (r_s = −0.41), which suggests non-response is not ignorable. The counts of fraud types are small and non-independent (respondents could report multiple). Use for the definition and the ordering, not for prevalence estimates.
