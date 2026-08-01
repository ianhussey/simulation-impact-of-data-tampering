# Literature notes

One note per entry in `../literature.bib`, recording what the source contains, which numbers are usable, where it belongs in the manuscript, and what not to claim from it. Written for [manuscript.qmd](../../communications/manuscript/manuscript.qmd).

PDFs live in `../files/<id>/` (gitignored).

## The argument these sources support

The manuscript claims that manufacturing a false positive is cheap, and that the practical distinction between questionable research practices and fabrication is a difference in keystrokes rather than in effort or in damage to the evidence. The literature supplies four independent lines of support:

**1. The taxonomy classifies by mechanism, not by consequence.**
[Steneck (2007)](steneck_introduction_2007.md) — the federal definitions. *Fabrication* is making data up; *falsification* is changing or omitting it. Our adding-strategies are the first, our removing-strategies the second, and our results say the two cost the same and do the same damage.

**2. Researchers treat the two categories as radically different — in admission, in stated willingness, and in perceived defensibility.**

| Source | Design | The asymmetry |
|---|---|---|
| [John et al. (2012)](john_measuring_2012.md) | 2,155 psychologists, with truth-telling incentives | Post hoc exclusion admitted by 38–43%, defensibility 1.61/2; falsifying data 0.6–1.7%, defensibility 0.16/2 |
| [Geggie (2001)](geggie_survey_2001.md) | 194 UK medical consultants, within-subject | Willing/unsure to omit data 20–27; to fabricate 3–4 |
| [Xie et al. (2021)](xie_prevalence_2021.md) | Meta-analysis, 42 articles, 23,228 participants | Fabrication 1.9%, falsification 3.3%, data-management QRPs 17.6% |
| [Fanelli (2009)](fanelli_how_2009.md) | Meta-analysis, 18 surveys | FF 1.97%, other QRPs up to 33.7%; and the canonical statement of the continuum |

**3. The asymmetry is substantially a reporting artefact, and perception drives behaviour.**
[Gopalakrishna et al. (2022)](gopalakrishna_prevalence_2022.md) — under randomized response, fabrication (4.3%) and falsification (4.2%) are admitted at indistinguishable rates. [Entradas et al. (2026)](entradas_shades_2026.md) — perceived seriousness is by far the strongest predictor of engagement (B = −0.35), ahead of every demographic factor.

**4. It happens, the requests are common, and the documented case matches our effort estimates.**
[FDA (2026)](us_fda_proposal_2026.md) — **five relabelled outcomes out of 331 patients (1.5% of the sample) moved a registrational trial from *p* = .1025 to *p* = .0132**; our 2×2 condition-switching strategy, at the proportion our simulations predict. [Wang et al. (2018)](wang_researcher_2018.md) — 24% of consulting biostatisticians asked to remove or alter observations. [Wang et al. (2019)](wang_bioethical_2019.md) — 55% have seen investigators asked to set aside the few outlying values on which the outcome turns. [Ranstam et al. (2000)](ranstam_fraud_2000.md) — the ISCB survey defined fabrication as changing the outcome "by increasing the sample size or effect, or by decreasing the variance", i.e. by the exact levers we simulate. [Gardner et al. (2005)](gardner_authors_2005.md) — the per-article denominator: ~1% of trial reports, ~5% of researchers, 17% know of a case. [Elashoff (2026)](elashoff_last_2026.md) — practitioner perspective; uses simulations of this kind to resist pressure.

## Notes

- **Strongest single citations:** John et al. (2012) Table 1 (the within-survey perception gap) and the FDA letter (the real-world effort figure).
- **Bibliography fix needed:** the `elashoff_last_2026` author field has parsed job titles as co-authors; correct to `Elashoff, Barbara` before citing.
- **Handle with care:** the FDA case is a contested allegation pending a hearing, not an adjudicated finding — attribute, don't assert. Elashoff is a company blog post, not peer-reviewed.
- Prevalence estimates throughout carry severe heterogeneity (I² > 90%) and evidence of publication bias; they are order-of-magnitude figures.
