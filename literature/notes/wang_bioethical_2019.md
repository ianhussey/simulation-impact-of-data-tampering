# Wang, Fan & Katz (2019) — Bioethical Issues in Biostatistical Consulting Study: Additional Findings and Concerns

**Citekey:** `wang_bioethical_2019` · *JDR Clinical & Translational Research* 4(3):271–275 · doi:10.1177/2380084419837294 · **PDF:** `files/38833/`

Companion paper to Wang et al. (2018), same 390 respondents and same instrument, reporting the **17 indirectly experienced** requests — things biostatisticians heard about or observed being asked of *other* biostatisticians. Indirect reports run much higher than direct ones, as they do throughout this literature.

## The items that matter here (Table, tiers A and B)

| Request | Asked 0× | 1–9× | ≥10× | High severity |
|---|---|---|---|---|
| Proposing a study with a flawed design, incl. low power | 36 | 53 | 11 | 51% |
| **If the outcome turns on a few outlying values, investigators set outlying values aside** | **45** | **50** | **5** | **62%** |
| **Report results of data analysis on only a subset of data** | **49** | **47** | **4** | **55%** |
| Overstate the statistical findings beyond what the data support | 50 | 46 | 4 | 68% |
| Modify the stated null hypothesis when the original is not supported | 57 | 40 | 3 | 61% |
| Investigator dislikes how the randomization worked out, so changes it | 78 | 21 | 1 | 73% |
| **Alter raw data to support the research hypothesis** | **83** | **16** | **1** | **86%** |
| **Analyze data that were fabricated or partially fabricated, intended for publication** | **86** | **8** | **6** | **85%** |

## Why this matters for the manuscript

**The gradient here is the manuscript's argument, laid out as a single ordered column.** Reading down the frequency column:

- *Setting aside a few outlying values* — **55%** have seen it asked. This is precisely our dropping strategy: the greedy removal of the most hostile observations. It is the second most frequently observed request in the whole survey.
- *Reporting on only a subset of the data* — **51%**.
- *Altering raw data to support the hypothesis* — **17%**.
- *Analysing fabricated data* — **14%**.

So the frequency falls by roughly 3–4× as the description moves from "set aside outliers" to "alter raw data", while the severity rating climbs from 62% to 86%. Our simulations say the two ends of that gradient cost a comparable number of edits and produce a comparable false positive. The gradient tracks *how the act is described*, not what it achieves.

The outlier item is especially valuable because "if the outcome turns on a few outlying values, investigators set outlying values aside" is a near-verbatim description of a greedy, most-helpful-first exclusion rule — and it is reported as common. Our contribution is to say how few such values it takes: a small percentage of the sample, and no more proportionally in a large study than a small one.

## Suggested use

- **Introduction or Discussion**, paired with Wang et al. (2018). The 2018 paper gives the direct-request rates; this one gives the observed-request rates and, more usefully, the explicit *outlier-setting-aside* item that matches our dropping strategy most closely.
- Useful single line: over half of consulting biostatisticians have seen researchers asked to set aside the few outlying values on which the outcome turns — the exact manipulation our dropping simulations quantify.

## Caution

Indirect reports ("heard about or observed") are inflated relative to direct experience and may double-count the same incidents across respondents; the authors are careful about this and so should we. Same limitations as the 2018 paper: biomedical consulting only, no data on whether requests were granted. The two papers share a sample, so cite them as one body of evidence, not two independent findings.
