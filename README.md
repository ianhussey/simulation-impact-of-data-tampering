# Very little data tampering is needed to produce statistically significant results: A Monte Carlo simulation



## Repository contents

```
code/
  compendium_iterative_ttest_optimised.qmd        # two-group mean difference (Student's t-test)
  compendium_iterative_correlation_optimised.qmd  # Pearson correlation
  compendium_iterative_chisquare_optimised.qmd    # 2x2 association (chi-square)
  compendium_iterative_*.qmd                      # reference implementations (no suffix), see below
  verify_optimised_implementations.R              # equivalence + speed test for the above pairs
  *_optimised.html                                # rendered reports (self-contained; open directly)
communications/
  manuscript/manuscript.qmd                       # the article; every number computed at render time
  manuscript/manuscript.pdf                       # rendered article
  manuscript/bibliography.bib, apa.csl            # references and citation style
  manuscript/_extensions/                         # Quarto elsevier journal template
  plots/                                          # figures written by the compendia (.png/.pdf)
data/                                             # simulation result caches (.rds) — tracked, see below
literature/                                       # bibliography (literature/files/ is NOT in git)
nick browns simulation/                           # Nick Brown's (2020) condition-swapping thread, reproduced
old/, dev/                                        # superseded work — NOT in git
```

Each compendium `.qmd` is a **self-contained research compendium**: introduction structured by ADEMP, all simulation code, per-strategy tables and figures, combined cross-strategy comparisons, discussion, and session info. The three files share the same design, helper functions, and summarising/plotting conventions, so they can be read in any order.

Every simulation exists in **two implementations that produce identical output**. The `_optimised.qmd` files carry the tampered dataset as plain vectors (four integers, for the 2×2 setting) and compute the test statistics in closed form; the unsuffixed files carry it as a data frame and call `t.test()`, `cor.test()`, and `chisq.test()`. The optimised versions are roughly 25× faster overall and are the **definitive** ones: they write the caches in `data/` that the manuscript reads. The reference versions exist so that the fast code can be checked against an obvious, readable implementation rather than trusted. Because both make their random draws in the same order and with the same arguments, the equivalence is exact rather than distributional, and `verify_optimised_implementations.R` asserts it for all sixteen setting × strategy × prevalence combinations.

The rendered `.html` reports are the fastest way into the simulations — start with [compendium_iterative_ttest_optimised.html](code/compendium_iterative_ttest_optimised.html). For the write-up, see [manuscript.pdf](communications/manuscript/manuscript.pdf).



## Reproducibility

**Requirements.** R with Quarto. Packages: `tidyr`, `dplyr`, `readr`, `forcats`, `tibble`, `purrr`, `furrr`, `MASS`, `effectsize`, `ggplot2`, `scales`, `knitr`, `kableExtra`, `ggtext`, `patchwork`, `stringr`, `wesanderson` (chi-square only), plus `parallelly`; optionally `flexiblas` / `RhpcBLASctl` for BLAS thread control. Rendering the manuscript additionally needs a LaTeX installation with LuaLaTeX (the elsevier template loads `unicode-math`).

**Rendering the manuscript.** The caches in `data/` are tracked in git, so the article renders from a fresh clone without re-running any simulation:

```bash
quarto render communications/manuscript/manuscript.qmd
```

Every number, figure, and table in the manuscript is computed at render time from those caches — nothing is transcribed — so a new simulation run propagates through the whole results section automatically. Summarising the caches involves a bootstrap over 144 conditions that takes a little over a minute, so the result is memoised to `communications/manuscript/summary_memo.rds`, keyed on the size and modification time of the inputs. Re-running the simulations invalidates it automatically; editing prose does not. The memo is derived and gitignored, and can be deleted to force recomputation.

**Quick local run of a simulation** (~100 iterations per condition, minutes rather than hours). Set the replication knob near the top of the report, in the *Common functions and global variables* chunk:

```r
run_full <- FALSE   # NULL = auto-detect environment, TRUE = full run, FALSE = smoke test
```

then render:

```bash
quarto render code/compendium_iterative_ttest_optimised.qmd
```

**Full run** (10,000 iterations per condition). The reports ship with `run_full <- TRUE`; this is intended for a cluster. See the *Running on an HPC cluster* section of any report for the full rationale. On a SLURM system, request a node and launch RStudio Server inside the allocation, then render:

```bash
salloc --nodes=1 --cpus-per-task=16 --mem=64G --time=08:00:00
```

**Verifying the two implementations.** From the `code/` directory:

```bash
Rscript verify_optimised_implementations.R
```

This runs every strategy under both implementations from the same seed and asserts that the tamper counts, success flags, and effect sizes are identical, exiting non-zero if any comparison is inexact. Use it as a regression test after editing either implementation. Set `VERIFY_REPS` to change the number of iterations per comparison (default 500).

**Caching.** Each simulation writes its raw per-iteration results to `data/`, tagged with the implementation, run type, and iteration count — e.g. `simulation_iterative_swaps_meandiff_opt_full_k10000.rds`. The `opt_` prefix marks output from the optimised implementation, so it can never overwrite, and can always be compared against, output from the reference implementation; `dev` and `full` runs are likewise kept apart. Re-rendering reads the cache instead of recomputing, so **delete the relevant `.rds` to force a re-run** — otherwise a changed simulation will silently render stale results.

**What is and is not distributed.** The `data/*.rds` caches from the full run *are* tracked, so the manuscript and the compendium tables reproduce without an HPC allocation. `old/`, `dev/`, `literature/files/` (copyrighted PDFs), and Quarto's `_files/` render artefacts are untracked.

**Reproducibility of the parallelism.** The plan is `plan(multisession, workers = parallelly::availableCores())` — `multisession` rather than `multicore` because RStudio Server is not fork-safe, and `availableCores()` because it honours SLURM allocations, cgroup quotas, and affinity masks, so the plan adapts to the cores actually granted to the session (pass an integer to pin a count). `furrr_options(seed = TRUE)` advances an L'Ecuyer-CMRG stream per task, so results are **identical regardless of the number of workers**. BLAS/LAPACK is pinned to one thread *before* workers spawn so that dozens of processes do not oversubscribe the node — the matrices here are tiny, so nothing is lost.

**A deliberate deviation from the usual template:** these simulations parallelise over *replicates* (one task per condition × iteration) rather than over *conditions*, and keep the raw per-iteration results, because the distribution histograms and the bootstrap median MCSEs need the full per-iteration vectors — summarising inside the worker would discard exactly the data the reports rely on. Each parameter grid is shuffled with `slice_sample(prop = 1)` after `set.seed()` (so the shuffle is itself reproducible), which together with `scheduling = 2` keeps the expensive large-N rows from clustering on a single worker.

# License

(c) Ian Hussey (2026)

All text and images are [CC-BY 4.0](LICENSE) licensed.

All code is MIT licensed.

# Suggested citation

Hussey, I. (2026). Very little data tampering is needed to produce statistically significant results: A Monte Carlo simulation. *PsyArXiv*. https://osf.io/preprints/psyarxiv/7jc3t
