# Stefan & Schönbrodt (2023) — Big little lies: a compendium and simulation of *p*-hacking strategies

**Citekey:** `stefan_big_2023` · *Royal Society Open Science* 10(2):220346 · doi:10.1098/rsos.220346 · CC BY · PDF in the user's Zotero (`storage/7ZWLHN27/`)

**The direct predecessor of this manuscript, and the source of its title.** Compiles 12 *p*-hacking strategies from an extensive literature review, identifies the factors controlling each one's severity, and simulates each one's impact on the false-positive rate. Ships a Shiny app and R package.

## What they do

- **12 strategies**, each with a detailed description from the published literature and a small simulation of "the increase in false-positive findings as a result of applying the *p*-hacking strategy to a commonly used hypothesis test."
- **Severity factors are varied and the FPR is read off.** E.g. for scale-item deletion they vary the number of original items (k ∈ {5, 10}), inter-item correlation (r ∈ {0.3, 0.7}), **the maximum number of items deleted (m ∈ {1, 3, 7})**, and sample size. The design is: *fix the p-hacking budget, measure the false-positive rate.*
- Scope is limited to "measures applied to a single dataset", and they separate *p*-hacking strategies from *reporting* strategies (which of several results gets published).
- A nice technical aside: "ambitious *p*-hacking does not change the false-positive rate of the procedure" — what changes is the selection of the reported *p*-value, since the FPR depends on the hypothetical number of tests that could have been conducted.
- They also evaluate mitigations: larger samples alone do *not* reduce the success rate of *p*-hacking; lowering α does; preregistration/registered reports work only insofar as they eliminate analytic flexibility.

## Where they stop, and why that matters

Their framing (Introduction): questionable research practices "rang[e] in the grey area between good practice and outright scientific misconduct", are "often difficult to detect", and "researchers are often not fully aware of their consequences."

And when discussing *p*-value misreporting they draw the line explicitly:

> if both test statistic and *p*-value are intentionally misreported, it should be questioned if this should still be considered a questionable research practice or if it should be counted as outright fraud.

**That is the boundary this manuscript crosses.** They quantify the consequences of the ambiguous practices; nobody has done the equivalent for the unambiguous ones. Their own diagnosis — that researchers are not fully aware of the consequences — is the motivation for doing it, and it converges with Entradas et al. (2026), who show that perceived seriousness is the dominant predictor of engagement.

## The methodological contrast (the manuscript's second contribution)

| | Stefan & Schönbrodt (2023) | This manuscript |
|---|---|---|
| Scope | 12 *p*-hacking strategies, grey area | 6 tampering strategies, unambiguously past the line |
| Design | **Fix** the budget K (e.g. m ∈ {1, 3, 7} deletions), **measure** the FPR | **Measure** the K required to reach *p* < .05 |
| Outcome | False-positive rate | Effort: tampered data points, absolute and as a proportion of N |
| Sample size finding | Larger N does not reduce *p*-hacking success | Larger N does not reduce the *proportion* that must be tampered |

The inversion is the ecologically valid one for a determined analyst: someone tampering with data does not set a budget in advance and stop, they continue until the result crosses. Asking "what value of K is needed?" answers that question directly and yields effort in interpretable units.

Their finding that larger sample sizes alone do not reduce *p*-hacking success is the direct analogue of our scale-invariance result, and worth citing as convergent evidence from the adjacent literature.

## Suggested use

- **Introduction**, as the central contrast and the acknowledged predecessor. The title debt ("Big little lies" → "Little big lies") should be made explicit — it reads as theft otherwise.
- **Introduction**, for the framing of the gap: they cover the grey area, we cover past it; they fix K and measure FPR, we measure the K required.
- **Discussion**, for the convergent scale-invariance finding and possibly for the mitigation results (lowering α helps; larger N does not).

## Caution

Do not characterize their work as incomplete or as having missed something — the scope restriction is deliberate and stated. The framing is "they filled the grey-area half of the question; this fills the other half." Their strategies are genuinely *p*-hacking (exploiting analytic multiplicity), ours are data tampering (altering the dataset itself); these are different objects and the comparison is between literatures, not between competing estimates of the same quantity.
