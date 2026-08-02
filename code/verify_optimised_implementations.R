# Verify the optimised compendia against the reference implementations
# ---------------------------------------------------------------------------------
# The three `*_optimised.qmd` compendia rewrite the tampering inner loops on plain
# vectors (or, for the 2x2 setting, on four counts) and compute the test statistics in
# closed form. They are intended to be pure optimisations: same design, same estimands,
# same results. Because every random number call is made in the same order and with the
# same arguments as in the reference implementation, that claim is checkable exactly
# rather than only distributionally -- given the same seed, both implementations must
# return identical tamper counts, identical reached_sig flags, and identical effect sizes.
#
# This script checks that for all sixteen (setting x strategy x prevalence) combinations
# and reports the speedup. Run it from the code/ directory:
#
#   Rscript verify_optimised_implementations.R
#
# It exits with a non-zero status if any comparison is not exact, so it can be used as a
# regression test after editing either implementation.

suppressMessages({
  library(dplyr); library(tidyr); library(tibble); library(purrr)
  library(effectsize); library(MASS)
})

reps <- as.integer(Sys.getenv("VERIFY_REPS", "500"))
seed <- 11L

# Load only the function definitions from a compendium, into their own environment, so
# the two implementations can coexist in one session without their identically named
# functions colliding.
load_functions <- function(file, env = new.env(parent = globalenv())) {
  out <- tempfile(fileext = ".R")
  suppressMessages(knitr::purl(file, output = out, quiet = TRUE))
  for (e in parse(out)) {
    is_fn <- is.call(e) && length(e) >= 3 &&
      identical(as.character(e[[1]]), "<-") &&
      is.call(e[[3]]) && identical(as.character(e[[3]][[1]]), "function")
    if (is_fn) eval(e, env)
  }
  env
}

compare <- function(ref_env, opt_env, fname, args) {
  f_ref <- get(fname, envir = ref_env)
  f_opt <- get(fname, envir = opt_env)

  set.seed(seed); t0 <- Sys.time()
  a <- map_dfr(seq_len(reps), function(i) do.call(f_ref, args))
  t_ref <- as.numeric(difftime(Sys.time(), t0, units = "secs"))

  set.seed(seed); t0 <- Sys.time()
  b <- map_dfr(seq_len(reps), function(i) do.call(f_opt, args))
  t_opt <- as.numeric(difftime(Sys.time(), t0, units = "secs"))

  cols <- intersect(names(a), names(b))
  exact <- all(vapply(cols, function(cc) isTRUE(all.equal(a[[cc]], b[[cc]], tolerance = 1e-10)),
                      logical(1)))
  label <- sub("_study$", "", sub("^run_iterative_", "", fname))
  cat(sprintf("  %-40s ref %7.2fs  opt %6.2fs  %4.0fx  exact: %s\n",
              label, t_ref, t_opt, t_ref / t_opt, exact))
  tibble(strategy = label, t_ref = t_ref, t_opt = t_opt, exact = exact)
}

results <- list()

cat(sprintf("Verifying optimised implementations (%d iterations per comparison)\n\n", reps))

cat("Mean difference (n per group = 50)\n")
R <- load_functions("compendium_iterative_ttest.qmd")
O <- load_functions("compendium_iterative_ttest_optimised.qmd")
base <- list(n_per_condition = 50, mean_control = 0, mean_intervention = 0,
             sd_control = 1, sd_intervention = 1)
fab <- c(base, list(fabricated_control_mean = 0, fabricated_control_sd = 0.2,
                    fabricated_intervention_mean = 5, fabricated_intervention_sd = 0.2))
results <- c(results, list(
  compare(R, O, "run_iterative_dropping_study",       base),
  compare(R, O, "run_iterative_condition_swap_study", base),
  compare(R, O, "run_iterative_duplication_study",    c(base, list(proportion = 0.1))),
  compare(R, O, "run_iterative_fabrication_study",    fab),
  compare(R, O, "run_iterative_replacement_study",    fab)))

cat("\nCorrelation (n = 100)\n")
R <- load_functions("compendium_iterative_correlation.qmd")
O <- load_functions("compendium_iterative_correlation_optimised.qmd")
hi <- list(fabricated_magnitude = 3, fabricated_sd = 0.5)
results <- c(results, list(
  compare(R, O, "run_iterative_correlation_dropping_study",    list(n = 100)),
  compare(R, O, "run_iterative_correlation_repairing_study",   list(n = 100)),
  compare(R, O, "run_iterative_correlation_duplication_study", list(n = 100, proportion = 0.1)),
  compare(R, O, "run_iterative_correlation_fabrication_study", c(list(n = 100), hi)),
  compare(R, O, "run_iterative_correlation_replacement_study", c(list(n = 100), hi))))

cat("\n2x2 association (n per group = 100)\n")
R <- load_functions("compendium_iterative_chisquare.qmd")
O <- load_functions("compendium_iterative_chisquare_optimised.qmd")
for (prev in c(0.20, 0.05)) {
  cat(sprintf(" prevalence = %.2f\n", prev))
  args <- list(n_per_condition = 100, prevalence = prev)
  results <- c(results, list(
    compare(R, O, "run_iterative_fabrication_2x2", args),
    compare(R, O, "run_iterative_dropping_2x2",    args),
    compare(R, O, "run_iterative_switching_2x2",   args)))
}

res <- bind_rows(results)
cat(sprintf("\n%d of %d comparisons exact. Overall speedup %.0fx (%.1fs -> %.1fs).\n",
            sum(res$exact), nrow(res), sum(res$t_ref) / sum(res$t_opt),
            sum(res$t_ref), sum(res$t_opt)))

if (!all(res$exact)) {
  cat("\nNOT EXACT:\n"); print(res |> filter(!exact))
  quit(status = 1)
}
