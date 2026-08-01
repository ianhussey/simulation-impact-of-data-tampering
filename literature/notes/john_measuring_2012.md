# John, Loewenstein & Prelec (2012) — Measuring the Prevalence of Questionable Research Practices With Incentives for Truth Telling

**Citekey:** `john_measuring_2012` · *Psychological Science* 23(5):524–532 · doi:10.1177/0956797611430953 · **PDF:** `files/38829/`

Survey of 5,964 academic psychologists (2,155 respondents), with a Bayesian truth serum (BTS) incentive manipulation intended to raise honest admission. Ten QRPs, each with a self-admission rate and — crucially — a **defensibility rating** from those who admitted it (0 = no, 1 = possibly, 2 = yes).

## Table 1, the whole argument in one table

| # | Practice | Admit (control) | Admit (BTS) | Defensibility |
|---|---|---|---|---|
| 1 | Failing to report all of a study's DVs | 63.4% | 66.5% | 1.84 |
| 2 | Deciding whether to collect more data after looking at significance | 55.9% | 58.0% | 1.79 |
| 3 | Failing to report all of a study's conditions | 27.7% | 27.4% | 1.77 |
| 4 | Stopping data collection early because the result was found | 15.6% | 22.5% | 1.76 |
| 5 | "Rounding off" a *p* value (.054 → "< .05") | 22.0% | 23.3% | 1.68 |
| 6 | Selectively reporting studies that "worked" | 45.8% | 50.0% | 1.66 |
| **7** | **Deciding whether to exclude data after looking at the impact on the results** | **38.2%** | **43.4%** | **1.61** |
| 8 | Reporting an unexpected finding as predicted | 27.0% | 35.0% | 1.50 |
| 9 | Claiming results unaffected by demographics when unsure | 3.0% | 4.5% | 1.32 |
| **10** | **Falsifying data** | **0.6%** | **1.7%** | **0.16** |

## Why this matters for the manuscript

**Items 7 and 10 are the manuscript's thesis, measured in the same respondents on the same instrument.**

- *Post hoc* data exclusion: admitted by **38–43%**, rated **1.61/2** for defensibility (i.e. between "possibly" and "yes").
- Falsifying data: admitted by **0.6–1.7%**, rated **0.16/2** (i.e. emphatically "no").

That is a **~25–70× gap in admission** and a **10× gap in perceived defensibility** between two acts which our simulations show require a comparable number of tampered data points to manufacture the same significant result. Item 7 *is* our dropping strategy, described in the respondents' own words. Item 10 is our fabrication and replacement strategies.

This is the single best citation in the collection for the manuscript's core claim, because the comparison is internal: same sample, same survey, same response scale, so neither the admission gap nor the defensibility gap can be attributed to instrument or sample differences.

Note the BTS effect: the odds ratio for admission under truth-telling incentives was **highest for falsifying data (2.75)**, and the correlation between BTS impact and baseline admission rate was −.62. Behaviours people think are indefensible are exactly the ones they under-report — so the 0.6% for falsification is the softest number in the table, and the true gap between items 7 and 10 is narrower than it appears.

## Suggested use

- **Introduction**, the paragraph establishing that exclusion is treated as venial and fabrication as unthinkable. Quote the two rates and the two defensibility ratings directly; they do more work than any paraphrase.
- **Discussion / ethics**, as the target of the argument: our results say the effort is comparable, John et al. say the perceived defensibility differs tenfold. That mismatch is the finding.
- The BTS/under-reporting point supports reading the fabrication figure as a floor — useful if a reviewer objects that fabrication really is much rarer.

## Caution

Psychology-specific, single-country, 2012, and response rates to such surveys are modest. Item 7 asks about *deciding whether* to exclude after looking, which is broader than our greedy dropping algorithm (it includes one-off decisions and defensible exclusions). Do not claim the 38–43% are all doing what our simulation does; the claim is about how the two categories are *regarded*, and there the comparison is exact.
