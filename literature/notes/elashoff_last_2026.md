# Elashoff (2026) — The last line of defense

**Citekey:** `elashoff_last_2026` · BlackCat Bio, opinion piece · https://blackcatbio.ai/statistician-integrity · **PDF:** `files/38830/`, HTML snapshot `files/38823/`

Short opinion piece by Barbara Elashoff (CEO/co-founder, BlackCat Bio; former FDA statistical reviewer) on the avacopan/TAVNEOS case, written from the perspective of the consulting statistician under commercial pressure.

## Content

Summarizes the FDA case (see `us_fda_proposal_2026`): nine patients selected for re-adjudication after unblinding turned *p* = 0.1025 into *p* = 0.0132. Her framing of the crux:

> But the committee did not choose the nine patients. Unblinded sponsor personnel did. And the selection ran in only one direction: the cases that could push the result toward significance were sent back for review, while the cases that could only move it the other way were left untouched.

Cites Wang et al. (2018) for the demand-side rates — 24% asked to remove or alter observations, 7% asked to change data, 3% asked to falsify statistical significance — and reports her own experience of being called "rigid" for refusing to change analyses after results were known, particularly in Phase 2 trials where data go to investors rather than to FDA.

Closes with a line that is essentially this manuscript's motivation from the practitioner's side: "A statistician's job is not to find the analysis that produces *p* < 0.05. Our job is to protect the integrity of the analysis when everyone else desperately wants *p* < 0.05."

## Why this matters for the manuscript

**Mainly as an argument for the pedagogical use of exactly this kind of simulation.** Her stated method for resisting pressure is:

> Now I use simulations and graphs to show how random variation works, how easily a *p*-value can move, and how quickly the false-positive rate climbs once we start changing the rules after seeing the answer.

That is a working statistician independently arriving at the use-case our compendia serve. Worth one sentence in the Discussion when arguing that quantifying the effort has practical value beyond meta-science: the numbers give a consulting statistician something concrete to put in front of a researcher who wants "just a few" cases re-examined.

Secondary use: her one-directional-selection framing is a crisper lay statement of the greedy most-helpful-first rule than anything in the methodological literature, and could be quoted when introducing the rule.

## Suggested use

- **Discussion**, one clause on practical utility, citing her simulation-as-persuasion approach.
- Possibly as a pointer to the FDA case in the Introduction, though the FDA letter itself is the citable primary source and should be cited alongside or instead.

## Caution

**This is a company blog post by an interested party, not peer-reviewed work.** Cite sparingly and only for the practitioner perspective and the framing, never for facts about the avacopan case — for those, cite the FDA letter directly. The bibliography entry's author field is mangled (it has parsed "CEO", "Co-founder" and "Former FDA statistical reviewer" as co-authors); **fix the `.bib` entry before citing**, to `Elashoff, Barbara`.
