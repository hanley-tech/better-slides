# better-slides vs frontend-slides — competitive comparison

> Audited 2026-06-10 against [`zarazhangrui/frontend-slides`](https://github.com/zarazhangrui/frontend-slides)
> (the category leader: ~21,000★, created 2026-01-28). Maintained as gaps close or open.

## Why this document exists

frontend-slides is the most-starred agent skill for HTML presentations and the structural
benchmark for this repo. better-slides deliberately competes on a *different axis*
(performance — motion, sound, methodology — vs. her axis of design breadth for
non-designers), but matches her on every structural and tooling aspect so the comparison
never costs us a user.

## Star-growth context (sampled from the GitHub stargazers API)

| Date | Her stars | Rate |
| --- | --- | --- |
| 2026-01-28 (launch) | 0 → ~100 in hours | launch spike |
| 2026-02-26 | ~5,000 | ~172/day |
| 2026-03-18 | ~10,000 | ~250/day (peak) |
| 2026-04-20 | ~15,000 | ~152/day |
| 2026-06-09 | ~21,000 | ~100–120/day (long tail, still alive) |

Lessons: launch timing + her distribution flywheel (she ships a new skill every few weeks:
follow-builders 5k★, codebase-to-course 4.6k★, beautiful-html-templates 2.7k★) drove the
curve. Star count is mostly distribution; repo *quality* determines conversion once
someone lands.

## Aspect-by-aspect

| Aspect | frontend-slides | better-slides | Status |
| --- | --- | --- | --- |
| Skill workflow (phased, progressive disclosure) | 7 phases; index → preview cards → one design.md | Phases 0–4 + same tiered loading | **par** |
| Anti-AI-slop design rules | explicit (fonts/colors/layout bans) | same, in hard invariants | **par** |
| Fixed 16:9 stage | viewport-base.css, non-negotiable | engine/stage.css + documented event-proof rationale (projector/ratio survival) | **ours deeper** |
| Density / register modes | reading vs speaking table | register question in Phase 1 | **par** |
| Style systems | 12 presets + 34 bold templates (each a full design.md) | 4 styles (Noir, Spotlight, Terminal, Broadsheet) — each adds **motion grammar + sound palette** she doesn't have | **fewer, richer** |
| Deploy script | 219-line guided Vercel deploy: CLI auto-install, interactive login, asset bundling, project-name sanitization | matched: same capabilities, same UX register | **par** |
| PDF export script | per-slide Playwright screenshots → assembled PDF, --compact, font-ready waits, nav fallbacks | matched, adapted to our engine's `show()` nav + forces `.pop/.slam/[data-beat]/omt` final states; **tested: noir demo → 8-page PDF** | **par** |
| PPTX extraction | JSON with titles, image dims, notes | markdown (for the agent) + JSON (titles, dims, notes) | **par+** |
| PPTX conversion flow | Phase 4 of skill | Mode D of skill (extract → playbook re-author, not 1:1 port) | **par, different philosophy** |
| Inline editing | E key, click-to-edit, Ctrl+S save | same (e / ✎, Esc, Ctrl/Cmd+S downloads cleaned file); browser-verified in all 3 decks | **par** |
| CJK support | deep per-template sections | concise CJK note in each of the 4 design.md files | **par for current scale** |
| Plugin packaging | marketplace.json + plugin.json + manual + other-agents path | same, 3 install paths | **par** |
| README | video demo, 14-template screenshot gallery, philosophy | animated GIF, 4-shot gallery, style table, **live hosted demos** (she has none), philosophy | **par; live demos are ours alone** |
| Repo metadata | topics, homepage | 10 topics + Pages homepage | **par** |
| Live hosted demos | ✗ (video only) | ✓ GitHub Pages, both demos | **ours alone** |
| Sound design / timed reveals / omt finale | ✗ | ✓ Web Audio cue palette, GSAP omt, per-style sound | **ours alone** |
| Speaking methodology | ✗ | ✓ Speaker Playbook as Phase-1 input | **ours alone** |
| Community traction | 21k★, 1.7k forks, 45 issues | new | **hers; time + launch** |

## What her scripts actually do (reference)

- **deploy.sh** — bundles a single HTML file's referenced assets (src/href/url() parse +
  `assets/` convention) into a temp dir, auto-installs the Vercel CLI, attempts
  interactive `vercel login` with guided signup, sanitizes the deck name into the Vercel
  project name, deploys `--yes --prod`, prints the URL + teardown tip. Re-deploy = same URL.
- **export-pdf.sh** — installs Playwright in a temp dir, serves the deck over its own
  Node static server (MIME map, URL-decode for spaces), waits `document.fonts.ready`,
  steps every `.slide` with three navigation fallback strategies, forces `.reveal`
  elements visible, screenshots each at 1920×1080 (or 1280×720 with `--compact`),
  assembles base64 images into a print page → single PDF, reports size, auto-opens.
- **extract-pptx.py** — python-pptx; emits `extracted-slides.json` with per-slide title
  (via `slide.shapes.title`), text blocks, image files + dimensions, speaker notes.

Ours now match these feature-for-feature (see `scripts/`), with engine-specific
adaptations: PDF export drives our deck's own `show()` navigation and forces our
animation classes (`.pop`, `.slam`, `[data-beat]`, omt elements) to final state.

## Remaining deltas (known, accepted)

1. **Style count** — 4 vs 46. Hers accreted from a companion repo over months. Plan:
   grow to 8–10 over time; each new style must carry the performance dimension
   (motion grammar + sound palette), not just a palette.
2. **Traction** — hers is launch + flywheel. Ours requires: a demo *video with sound*
   (a GIF can't sell the applause), an end-to-end `/plugin install` test from a clean
   machine, then an actual launch (Show HN / X / Claude Code community).
3. **Field-testing of scripts** — export-pdf.sh is tested end-to-end (8-slide noir demo →
   8-page PDF). deploy.sh is syntax-checked and code-reviewed but not run against a real
   Vercel account; extract-pptx.py is syntax-checked but needs a real .pptx fixture.

## Where we deliberately diverge

Her thesis: *you don't need to be a designer* → breadth of curated styles, frictionless
output. Our thesis: *a deck is a performance, not a document* → sound, pacing, theatrics,
and a methodology for what to say. Same structural discipline, different product. Don't
chase her template count; deepen the performance moat she can't follow into without
rebuilding her engine.
