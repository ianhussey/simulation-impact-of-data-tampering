# FDA/CDER (2026) — Proposal to Withdraw Marketing Approval; Notice of Opportunity for a Hearing: TAVNEOS (avacopan), NDA 214487

**Citekey:** `us_food_and_drug_administration_center_for_drug_evaluation_and_research_proposal_2026` · Docket FDA-2026-N-1321, April 2026, signed by Tracy Beth Høeg, Acting Director, CDER · **PDF:** `files/38824/` (24 pp)

FDA's letter to Amgen proposing withdrawal of approval for avacopan, on the grounds that the pivotal ADVOCATE trial's primary endpoint data were manipulated after unblinding. Contested by the sponsor; the drug remains on the market pending a hearing.

## The documented sequence

- ADVOCATE randomized **331** subjects with ANCA-associated vasculitis. Primary endpoint: sustained remission at week 52 — a **binary outcome in two groups**.
- Database locked and unblinded 5 November 2019. The prespecified primary analysis was **not significant: two-sided *p* = 0.1025**.
- On seeing this, **unblinded sponsor personnel** selected **nine** subjects for re-adjudication, including five avacopan patients whose status would change from "not in sustained remission" to "sustained remission."
- Per the Walton Report, personnel **confirmed in advance** that changing those five would flip the study to significance.
- The five were re-adjudicated as instructed; the database was re-locked on 20 November 2019; the analysis was re-run and returned **two-sided *p* = 0.0132**. This was the only primary analysis submitted in the NDA.
- FDA's findings: the AC Charter prohibited re-adjudication after unblinding; the adjudication committee did not choose which patients to review; the selection ran in one direction only; none of the nine re-adjudications was permitted; the re-run *p*-value was not Type-I-error controlled and is "meaningless and uninterpretable."

## Why this matters for the manuscript

**This is our 2×2 condition-switching simulation, executed on a real registrational trial, and the numbers match.**

- The design is a two-group binary outcome — the chi-square setting.
- The operation is **relabelling outcome status for selected cases**, chosen greedily as those that move the result toward significance. That is our condition-switching strategy almost exactly: no data were invented and none deleted; labels were changed.
- **Five outcome changes out of 331 subjects = 1.5% of the sample**, moving *p* from .1025 to .0132.

Our simulations estimate that a median of a few per cent of the sample must be tampered with to manufacture significance, and that the required proportion does not grow with sample size. A documented regulatory case at N = 331 required 1.5%. That is a striking external validation of a simulation result, and it is exactly the kind of grounding a reviewer will want.

It also validates two secondary claims:
1. **Effort does not scale with N.** This was a 331-patient registrational trial, not a small study, and it still took five edits.
2. **The greedy, one-direction rule is realistic.** FDA's core objection is precisely that the selection "ran in only one direction" — the cases that could push toward significance were reviewed, the ones that could only move it the other way were left untouched. That is the most-helpful-first rule, described by a regulator.

## Suggested use

- **Introduction**, as the motivating real-world case: a 2026 FDA withdrawal proposal in which five relabelled outcomes out of 331 patients turned a failed trial into a positive one. It converts the paper's premise from hypothetical to documented in two sentences.
- **Discussion**, to anchor the headline finding: our median effort estimates are of the same order as the only well-documented case in the collection where the exact number of altered records is on the public record.
- Note it is also the perfect illustration of the fabrication/falsification boundary problem (see `steneck_introduction_2007`): nothing was invented and nothing deleted — records were *changed* — so this is falsification, and it produced a result that did not exist before.

## Caution

**This is a contested regulatory allegation, not an adjudicated finding of misconduct.** Amgen disputes it; a hearing is pending. Write it as "FDA has proposed withdrawal on the grounds that…" and attribute the factual sequence to the FDA letter and the Walton Report rather than asserting it. Do not name individuals. The re-adjudications may each have been individually defensible; FDA's objection is to the post-unblinding, one-directional selection process, and that is the point worth making — the mechanism, not the motive.
