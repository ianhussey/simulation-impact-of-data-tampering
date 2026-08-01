# Little big lies: how much data tampering does it take to manufacture a significant result?

Simulation studies quantifying the **effort** — the number of altered, deleted, or invented data points — required to push a dataset generated under the null hypothesis across the *p* < .05 threshold.

Author: Ian Hussey  
License: [CC-BY 4.0](LICENSE)

## The question

Start from data where the true effect is exactly zero. A dishonest analyst tampers with it a few data points at a time, each time choosing the single most helpful change, and re-runs the test after every change. How many data points must they touch before the test returns *p* < .05?

The answer is the primary estimand of every simulation here. It is deliberately expressed as a **count** (and as a **proportion of the sample**) rather than as a bias or a false-positive rate, because the count is what makes the point concrete: manufacturing a false positive is cheap, it does not get proportionally harder in large samples, and the strategies that are hardest to detect are among the cheapest.

The motivating context is the continuum between questionable research practices and outright fabrication. Unprincipled exclusion of inconvenient cases is usually filed under *p*-hacking; typing the *other* condition's label into those same rows is fabrication and a firing offence. The simulations show that these differ by keystrokes, not by effort or by damage done to the evidence.

## Repository contents

```
code/
  compendium_iterative_ttest.qmd        # two-group mean difference (Student's t-test)
  compendium_iterative_correlation.qmd  # Pearson correlation
  compendium_iterative_chisquare.qmd    # 2x2 association (chi-square)
  *.html                                # rendered reports (self-contained; open directly)
communications/plots/                   # publication figures written by the reports (.png/.pdf)
nick browns simulation/                 # Nick Brown's (2020) condition-swapping thread, reproduced
data/                                   # simulation result caches (.rds) — NOT in git, see below
old/, dev/                              # superseded work — NOT in git
```

Each `.qmd` is a **self-contained research compendium**: introduction structured by ADEMP, all simulation code, per-strategy tables and figures, combined cross-strategy comparisons, discussion, and session info. The three files share the same design, helper functions, and summarising/plotting conventions, so they can be read in any order.

The rendered `.html` files are the fastest way in — start with [compendium_iterative_ttest.html](code/compendium_iterative_ttest.html).

## Design (ADEMP)

The introduction of each report follows the ADEMP framework of Morris, White, and Crowther (2019) as operationalised for psychology by Siepe et al. (2024). Summary across the three settings:

|  | *t*-test | Correlation | Chi-square |
|---|---|---|---|
| **Aims** | Characterise a tampering procedure: tamper count to reach *p* < .05, proportion of datasets exceeding post hoc tampering budgets (10%/25%/50% of the sample) or never attaining significance at all, effect-size bias, and comparison across strategies | as *t*-test | as *t*-test, minus the bias measure; adds prevalence as a factor |
| **DGP** | Two groups of `n_per_condition`, `rnorm()`, μ = 0 in both, σ = 1 | Bivariate normal, `MASS::mvrnorm()`, ρ = 0, unit variances | Two groups of `n_per_condition`, `rbinom()`, equal prevalence in both |
| **Factors** | strategy × `n_per_condition` ∈ {10, 25, 50, …, 200} | strategy × total `n` ∈ {20, 50, 100, …, 400} (matching the *t*-test total Ns) | strategy × `n_per_condition` ∈ {10, 25, …, 200} × prevalence ∈ {0.20, 0.05} |
| **Conditions** | 5 × 9 = **45** | 5 × 9 = **45** | 3 × 9 × 2 = **54** |
| **Estimands** | `tampers_needed` (median, IQR, 95% PI, and as a proportion of N); post hoc budget-exceedance proportions (> 10%, > 25%, > 50% of N) and the proportion never attaining significance; final-dataset Hedges' *g* — which, since the truth is 0, **is** the bias | as *t*-test, with Pearson *r* (and Fisher's *z*) as the bias | `tampers_needed` only (no standardised effect-size bias in the binary setting) |
| **Methods** | Equal-variance two-sample *t*-test, two-sided, α = .05 | Pearson correlation test (computed algebraically in the inner loop; identical to `cor.test`) | `chisq.test(correct = FALSE)`, α = .05 |
| **Performance** | Median tamper count with IQR and 95% PI (mean/SD also tabulated to expose the skew), proportion of sample, detection rate / proportion never significant, signed median bias | as *t*-test | median tamper count, proportion of sample, detection rate / proportion never significant |

Held constant everywhere: the true null; α = .05; and the greedy *most-helpful-first* rule — each step alters the single data point that moves the test statistic furthest toward significance, then the test is re-run. **No tampering budget is imposed**: each strategy runs until significance is reached or a structural limit is hit (data exhausted; no improving move left), with a loop guard at 10× the sample size as a termination backstop only. Tampering budgets (10%, 25%, 50% of the sample) are applied post hoc at summary time — because the full, unbudgeted counts are recorded, results under any budget are recoverable without re-running.

**Monte Carlo uncertainty.** Every reported summary carries an MCSE: binomial SE for the detection rate / never-significant proportion, SE of the mean for mean counts, and a nonparametric bootstrap (Morris et al., 2019) for medians (counts and bias), since the median has no clean closed form under skew. The RNG state is saved and restored around the bootstrap so that summarising never perturbs the simulation seeds.

**How results are reported.** Tables print each estimate with its MCSE in parentheses and each interval in square brackets, following the reporting conventions of `simulation_template_lego.qmd`. Decimal places are set from the MCSE rather than fixed per table — the MCSE is shown to two significant figures and the estimate to the same number of places (Morris et al., 2019) — because the headline quantity, the proportion of the sample that must be tampered with, lies between .02 and .04 at the larger sample sizes and a fixed 2 dp collapsed distinct values onto the same printed number.

Two quantities in every table and plot must not be confused. The value in parentheses is **±1 MCSE**: how precisely the simulation has pinned down that summary. The bracketed interval is the **spread of the simulated studies themselves** — either the interquartile range (`iqr_lower`/`iqr_upper`) or the **95% prediction interval** (`pi_lower`/`pi_upper`, the 2.5th and 97.5th percentiles), i.e. the range within which a single new study's result would fall 95% of the time. Plots show the 95% PI; an interval bar is omitted where its upper percentile falls among the never-significant datasets. The 0th and 100th percentiles (`min`/`max`) are computed and kept in the summary objects but are never tabled or plotted: the maximum of *K* draws drifts upward as *K* grows, so it is not a stable quantity.

**Censoring, and why the median is the headline statistic.** Even without a budget, an iteration can end without significance: dropping exhausts the data, re-pairing runs out of improving swaps, a 2×2 donor cell empties, or (rarely) the loop guard fires on a pathological greedy stall. Those iterations have no finite tamper count — significance was never attained — so `tampers_needed` is right-censored. The median, IQR and prediction interval are computed over **all** iterations with the never-significant ones ranked above every finite count, so any percentile falling among the finite counts is estimated exactly and any percentile falling among the censored cases is reported as `never` rather than being silently replaced by the survivors' percentile. Summarising only the iterations that attained significance answers a different question — "*given* that tampering worked, how many edits?" — and biases the answer downwards. The clearest example: chi-square dropping at N = 20 with prevalence .05, where a majority of datasets are structurally impossible to push to significance, so the honest median is `never`.

The **mean cannot be computed that way at all**, since the censored counts are unbounded above. The `mean_reached` / `sd_reached` columns are therefore conditional on attaining significance, are downward-biased for the unconditional mean by construction, and are reported as a within-condition skew diagnostic against the median rather than as a headline summary — they must not be compared across conditions with different censoring fractions. The one respect in which the mean is better behaved: its MCSE is smooth and always positive, whereas the bootstrap MCSE of a median of integer counts is frequently exactly 0 at *K* = 10,000 (the median is pinned) and is `NA` when the median itself is censored.

**Replications.** `n_iterations` = **10,000** per condition for a full run; **100** for a fast local smoke test.

**Non-convergence.** All three tests are closed-form, so the realistic failure modes are degenerate intermediate datasets (a group falling below two cases, fewer than three remaining pairs, zero within-group variance, an empty 2×2 margin). These return a missing *p*-value and are classified as never-significant via the explicit `reached_sig` flag — tracked rather than inferred, so no replication is silently dropped from both the central-tendency statistics and the never-significant proportion.

## Tampering strategies

Every strategy is iterative and greedy: generate null data → test → while non-significant, apply one operation targeting the case(s) most opposed to the desired result → re-test, until significance or a structural limit.

Strategies are listed — and plotted and tabulated in the reports — **in order of impact**, from the strategy needing the smallest proportion of the sample to be tampered with to reach *p* < .05 to the one needing the largest. The order (`method_levels`, defined in the *Common functions* chunk of each report) is fixed across the mean-difference and correlation settings so their figures are directly comparable. Effort is what discriminates the strategies: the effect size at the point significance is reached is near-identical across them, because the greedy procedure stops on first crossing.

**Two-group mean difference** (`compendium_iterative_ttest.qmd`)

| Strategy | Operation | Preserves |
|---|---|---|
| Replacement | Replace hostile cases with invented high-leverage ones | Total N |
| Condition swapping | Move one participant's *label* to the other condition, alternating direction to keep groups balanced | Every univariate distribution — the hardest to detect |
| Fabrication | Add one invented case per group, drawn from N(0, 0.2) and N(5, 0.2) | — (inflates N) |
| Dropping | Remove the single most hostile remaining case (lowest in intervention or highest in control) | — (reduces N; truncates the distribution) |
| Duplication | Duplicate one case sampled from each condition's original top 10% | — (inflates N) |

**Pearson correlation** (`compendium_iterative_correlation.qmd`) — with no condition label, every strategy targets the **joint** distribution via the centred cross-product $c_i = (x_i - \bar{x})(y_i - \bar{y})$, which is negative for discordant cases. Strategies, in the same order: replacement, **re-pairing** (value swapping), fabrication, dropping, duplication. Re-pairing is the correlation analogue of condition swapping and the most forensically interesting: it only permutes the *y*-values, so **both marginals are preserved exactly** and no univariate check can see it.

**2×2 association** (`compendium_iterative_chisquare.qmd`) — with a binary outcome the strategy menu collapses. Duplicating a favourable case, fabricating one, and replacing an unfavourable one are all the same atomic move (*add a 1 to the exposed group or a 0 to the not-exposed group*), so they are treated as one strategy. Three strategies remain, again ordered by impact: **condition switching** (the only one preserving total N), **dropping**, and **duplication/fabrication/replacement**. None preserves the marginal outcome prevalence — which would itself be a giveaway. There is no 2×2 analogue of the continuous sign-change strategy.

Swapping *entire* conditions is handled analytically in the *t*-test report (it merely adds ½α to the false-positive rate) rather than simulated.

## Headline findings

- **Effort is small and roughly scale-invariant in proportional terms.** The absolute tamper count grows with N, but the *proportion* of the sample that must be altered does not — manufacturing a false positive is no harder, proportionally, in a large study than in a small one.
- **The distribution-preserving strategies are both effective and stealthy.** Condition swapping (*t*-test) and re-pairing (correlation) leave the univariate distributions untouched, yet reach significance in few operations. Strategies that inject high-leverage points (fabrication, replacement) are the most efficient per operation but the most visible.
- **The manufactured effect is just big enough.** Because the truth is zero and the greedy procedure stops on first crossing, the median Hedges' *g* / Pearson *r* at the point significance is reached sits near the critical effect size for that N — no larger.
- **Rare outcomes are especially fragile.** In the 2×2 setting, a prevalence of 0.05 is far easier to tip than 0.20: a handful of fabricated cases moves the table disproportionately.

See the *Discussion* section of each report for the full reading against the aims.

## Reproducing

**Requirements.** R with Quarto. Packages: `tidyr`, `dplyr`, `readr`, `forcats`, `tibble`, `purrr`, `furrr`, `MASS`, `effectsize`, `ggplot2`, `scales`, `knitr`, `kableExtra`, `ggtext`, `patchwork`, `wesanderson` (chi-square only), plus `parallelly`; optionally `flexiblas` / `RhpcBLASctl` for BLAS thread control.

**Quick local run** (~100 iterations per condition, minutes rather than hours). Set the replication knob near the top of the report, in the *Common functions and global variables* chunk:

```r
run_full <- FALSE   # NULL = auto-detect environment, TRUE = full run, FALSE = smoke test
```

then render:

```bash
quarto render code/compendium_iterative_ttest.qmd
```

**Full run** (10,000 iterations per condition). The reports ship with `run_full <- TRUE`; this is intended for a cluster. See the *Running on an HPC cluster* section of any report for the full rationale. On a SLURM system, request a node and launch RStudio Server inside the allocation, then render:

```bash
salloc --nodes=1 --cpus-per-task=16 --mem=64G --time=08:00:00
```

**Caching.** Each simulation writes its raw per-iteration results to `data/`, tagged with the run type and iteration count — e.g. `simulation_iterative_swaps_meandiff_full_k10000.rds`. Development and full runs therefore never overwrite each other, and re-rendering reads the cache instead of recomputing. Delete the relevant `.rds` to force a re-run.

**Note that `data/*.rds` is gitignored** and not distributed — the caches are large and are regenerated by running the reports. `old/` and `dev/` are likewise untracked.

**Reproducibility of the parallelism.** The plan is `plan(multisession, workers = parallelly::availableCores())` — `multisession` rather than `multicore` because RStudio Server is not fork-safe, and `availableCores()` because it honours SLURM allocations, cgroup quotas, and affinity masks, so the plan adapts to the cores actually granted to the session (pass an integer to pin a count). `furrr_options(seed = TRUE)` advances an L'Ecuyer-CMRG stream per task, so results are **identical regardless of the number of workers**. BLAS/LAPACK is pinned to one thread *before* workers spawn so that dozens of processes do not oversubscribe the node — the matrices here are tiny, so nothing is lost.

**A deliberate deviation from the usual template:** these simulations parallelise over *replicates* (one task per condition × iteration) rather than over *conditions*, and keep the raw per-iteration results, because the distribution histograms and the bootstrap median MCSEs need the full per-iteration vectors — summarising inside the worker would discard exactly the data the reports rely on. Each parameter grid is shuffled with `slice_sample(prop = 1)` after `set.seed()` (so the shuffle is itself reproducible), which together with `scheduling = 2` keeps the expensive large-N rows from clustering on a single worker.

## Ethics and scope

These reports document weaponisable knowledge, and the framing is deliberate: the simulations exist to make a *continuum* visible, not to provide a recipe. Excluding participants is usually filed under *p*-hacking even when the exclusions are unprincipled and serve only to produce a significant *p*-value; if instead of deleting those rows the analyst types the other condition's label into them, the same act becomes fabrication. Treating one as common-and-merely-iffy and the other as rare-and-clearly-unacceptable risks badly underestimating the prevalence of the latter.

**Limitations.**

- **Proof of principle, not a fraud model.** The strategies are simple and greedy. Real, detection-aware fraud would trade efficiency for plausibility, and the naive versions here leave detectable signatures (truncated distributions, leverage outliers, shifted marginal prevalence).
- **No detectability axis.** The studies measure effort and bias, not how easily each manipulation would be caught. Adding a detectability measure is the most valuable extension.
- **Normal, continuous or binary DGPs only.** Likert-type outcomes, non-Normal marginals, and an "alter existing values" strategy distinct from fabrication are out of scope.
- **Single threshold.** All results are conditioned on α = .05. No tampering budget is imposed in the design; budgets are applied post hoc, so results under any other budget are recoverable from the recorded counts.

## References

Chambers, C. (2017). *The seven deadly sins of psychology: A manifesto for reforming the culture of scientific practice.* Princeton University Press. (The "dirty dozen"; its second tip — condition swapping — is simulated directly here.)

Morris, T. P., White, I. R., & Crowther, M. J. (2019). Using simulation studies to evaluate statistical methods. *Statistics in Medicine, 38*(11), 2074–2102. https://doi.org/10.1002/sim.8086

Siepe, B. S., Bartoš, F., Morris, T. P., Boulesteix, A.-L., Heck, D. W., & Pawel, S. (2024). Simulation studies for methodological research in psychology: A standardized template for planning, preregistration, and reporting. *Psychological Methods.* https://doi.org/10.1037/met0000695

Brown, N. (2020). Tweet thread on simulating condition swapping. [Gist](https://gist.github.com/sTeamTraen/39e2abd53ca280153f4b0926b1aae7f6) — reproduced in `nick browns simulation/`.

Spiess et al. (2024) / the `dfstat`–`dfbeta` influential-observation literature. *[citation to be completed]*
