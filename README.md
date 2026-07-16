# better-slides

**Slides that *perform* — Apple-keynote theatrics in a single HTML file your coding agent writes for you.**

<sup>by <a href="https://github.com/hanley-tech">Hanley Leung</a> · <a href="https://hanley.world">hanley.world</a> · born from the LunaTechs Speaker Playbook</sup>

Most slide tools make a *document*. better-slides makes a *performance*: big type, timed
reveals, sound design, and a "one more thing" finale — the theatrics of an Apple keynote,
the openness of the web, authored by a coding agent, with a built-in methodology that
tells you **what to actually say**.

> Don't be boring. Be unforgettable.

![better-slides — the "Be Unforgettable" flagship deck and the Noir style, performing](demo/demo.gif)

### ▸ [**See it perform → hanley-tech.github.io/better-slides**](https://hanley-tech.github.io/better-slides/)

*(The landing page is itself a better-slides deck. Of course it is.)*

**Six live demos**, one per performance style — arrow keys to advance, `m` for sound, `f` for fullscreen:
[Noir](https://hanley-tech.github.io/better-slides/demo/noir/) ·
[Obsidian](https://hanley-tech.github.io/better-slides/demo/obsidian/) ·
[Cupertino](https://hanley-tech.github.io/better-slides/demo/cupertino/) ·
[Spotlight](https://hanley-tech.github.io/better-slides/demo/) ·
[Terminal](https://hanley-tech.github.io/better-slides/demo/terminal/) ·
[Broadsheet](https://hanley-tech.github.io/better-slides/demo/broadsheet/)

This is an agent skill (works with Claude Code and any coding agent that can read a repo
and run a shell). Point it at your talk; get back one portable `.html` file that opens in
any browser, scales to any screen, and runs entirely offline-ish (one fonts request).

---

## Why this exists

There's a gap nobody fills:

|                     | Theatrics | Open / web | AI-authored | Tells you what to say |
| ------------------- | :-------: | :--------: | :---------: | :-------------------: |
| **Apple Keynote**   |     ✅     |     ❌      |      ❌      |           ❌           |
| **reveal.js**       |     ~     |     ✅      |      ❌      |           ❌           |
| **AI slide tools**  |     ❌     |     ✅      |      ✅      |           ❌           |
| **better-slides**  |     ✅     |     ✅      |      ✅      |           ✅           |

Most AI slide generators optimize for *removing friction* and ship a static, pretty
document. better-slides optimizes for the opposite: a deck that's **felt** — that
applauds, swooshes, lands a reveal, and leaves the room itching to act.

## Built for the podium

Conference screens are a graveyard of mismatched resolutions and aspect ratios. Most decks
were authored for one screen and break on the rest — text reflows, a chart slips off the
edge, the hero number wraps. better-slides sidesteps the whole class of problem: the deck
is a **fixed composition** that scales and letterboxes, so it is pixel-identical on every
projector, every time. Plug in, present, don't think about it.

## What you get

- **Event-proof stage engine** — authored once at a fixed 1920×1080 and scaled as one unit
  to whatever screen the venue hands you: 1080p laptop, 4:3 hall projector, 16:10 panel,
  ultrawide, confidence monitor, phone. It **letterboxes instead of reflowing** — what you
  designed is exactly what shows, on every screen, with zero last-minute surprises at the
  podium. Keyboard / swipe / deep-link nav, glass control menu, progress bar.
- **The performance layer** — GSAP-driven timed reveals, staggered builds, and an
  `omt` ("one more thing") finale recipe. Optional **sound design**: applause beds,
  swooshes, chimes, and a live waveform — wired through the Web Audio API.
- **Performance styles** — six full design systems (not just themes): typography,
  palette, motion grammar, *and sound palette* per style. Loaded progressively.
- **The Speaker Playbook** — a built-in *methodology* for what to put on stage: distill to
  one idea, narrative over data, one huge number, build a hero slide worth screenshotting,
  stick the landing. ([`playbook/speaker-playbook.md`](playbook/speaker-playbook.md))
- **Inline editing** — press `e` in any deck, click any text and type, `Ctrl/Cmd+S`
  downloads the edited file. Fix a typo at the venue with nothing but a browser.
- **PPTX conversion** — point it at a `.pptx`; it extracts every slide, note, and image,
  then re-authors the content as a performance (not a 1:1 port — the playbook applies).
- **Share scripts** — one command to deploy to a live URL
  ([`scripts/deploy.sh`](scripts/deploy.sh)), export a print-faithful PDF
  ([`scripts/export-pdf.sh`](scripts/export-pdf.sh)), or capture the social share
  card straight from the rendered title slide ([`scripts/capture-shots.sh`](scripts/capture-shots.sh)).
- **Zero dependencies** — one HTML file (plus optional audio assets). Works in 10 years.
  No npm, no build step, no framework.

## Performance styles

Six styles, each a full design system — typography, palette, **motion grammar**, and
**sound palette**. Every one has a live demo: press → to advance, `m` for sound.

| Style | Voice | Reach for it when | |
| --- | --- | --- | --- |
| **Noir** | Black stage, white light, one accent — Apple-keynote theatrics | Product launches, vision talks, founder pitches | [live ▸](https://hanley-tech.github.io/better-slides/demo/noir/) |
| **Obsidian** | apple.com after dark — true black, monochrome, zero accent | Brand/vision talks that should feel expensive and considered | [live ▸](https://hanley-tech.github.io/better-slides/demo/obsidian/) |
| **Cupertino** | Photo-forward personal keynote — full-bleed imagery, one blue word | "N things I learned" story talks, career retrospectives | [live ▸](https://hanley-tech.github.io/better-slides/demo/cupertino/) |
| **Spotlight** | Electric blue + gold on navy, friendly and loud | Meetups, teaching, lightning talks, hype moments | [live ▸](https://hanley-tech.github.io/better-slides/demo/) |
| **Terminal** | GitHub-dark, terminal green, all mono | Dev-tool launches, security talks, hackathons | [live ▸](https://hanley-tech.github.io/better-slides/demo/terminal/) |
| **Broadsheet** | Ink-dark editorial serif, one crimson accent | Research, strategy, essays-as-talks, policy | [live ▸](https://hanley-tech.github.io/better-slides/demo/broadsheet/) |

Each is a full `design.md` with motion grammar and sound palette — and the skill always
offers a custom wildcard when none of these fits the brief.

**Click any style to watch it perform.** These are real title slides, captured from the
running decks — not mockups.

<table>
<tr>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/noir/"><img src="demo/noir/preview.jpg" alt="Noir — black stage, white light, one accent" /></a>
  <br /><b>Noir</b><br /><sub>Keynote theatrics</sub>
</td>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/obsidian/"><img src="demo/obsidian/preview.jpg" alt="Obsidian — true black, monochrome, zero accent" /></a>
  <br /><b>Obsidian</b><br /><sub>apple.com after dark</sub>
</td>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/cupertino/"><img src="demo/cupertino/preview.jpg" alt="Cupertino — photo-forward personal keynote" /></a>
  <br /><b>Cupertino</b><br /><sub>The photo-forward story talk</sub>
</td>
</tr>
<tr>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/"><img src="demo/preview.jpg" alt="Spotlight — electric blue and gold on navy" /></a>
  <br /><b>Spotlight</b><br /><sub>Loud, friendly, human</sub>
</td>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/terminal/"><img src="demo/terminal/preview.jpg" alt="Terminal — GitHub-dark, terminal green, all mono" /></a>
  <br /><b>Terminal</b><br /><sub>A shell that learned stagecraft</sub>
</td>
<td width="33%" align="center">
  <a href="https://hanley-tech.github.io/better-slides/demo/broadsheet/"><img src="demo/broadsheet/preview.jpg" alt="Broadsheet — ink-dark editorial serif, one crimson accent" /></a>
  <br /><b>Broadsheet</b><br /><sub>A magazine essay, out loud</sub>
</td>
</tr>
</table>

Each demo is a genuine short talk with its own argument — the styles are shown doing the
job, not posing for a swatch.

<p>
  <img src="demo/cupertino/shots/shot-3.jpg" width="49.5%" alt="Cupertino — the giant counting numeral over a full-bleed photo" />
  <img src="demo/shots/flagship-hero.jpg" width="49.5%" alt="Spotlight — the hero chart money slide" />
</p>
<p>
  <img src="demo/shots/noir-90.jpg" width="49.5%" alt="Noir — the 90% black stage stat" />
  <img src="demo/shots/noir-1file.jpg" width="49.5%" alt="Noir — 1 file, zero dependencies" />
</p>

## The demos

[`demo/`](demo/) is the **"Be Unforgettable" talk** — the Speaker Playbook itself, rebuilt
on the better-slides engine with the full performance treatment (Spotlight style). It's the
worked example *and* the marketing: a talk about being unforgettable that is itself
unforgettable. ([live](https://hanley-tech.github.io/better-slides/demo/))

The other five are short talks, one per style — each with a real thesis, because a style
demo that has nothing to say isn't demonstrating the point:

| Deck | Style | The one idea |
| --- | --- | --- |
| [`demo/noir/`](demo/noir/) | Noir | *This is not a slideshow.* |
| [`demo/obsidian/`](demo/obsidian/) | Obsidian | *Subtraction is the work.* |
| [`demo/cupertino/`](demo/cupertino/) | Cupertino | *You find the work by finishing something badly, tonight.* |
| [`demo/terminal/`](demo/terminal/) | Terminal | *Every dependency is a promise someone else has to keep.* |
| [`demo/broadsheet/`](demo/broadsheet/) | Broadsheet | *Attention is rented. Memory is owned.* |

```bash
open index.html                  # the landing page (Noir) — itself a deck
open demo/index.html             # Be Unforgettable (Spotlight)
open demo/noir/index.html        # This is not a slideshow (Noir)
open demo/obsidian/index.html    # Subtraction is the work (Obsidian)
open demo/cupertino/index.html   # Go make the ugly thing (Cupertino)
open demo/terminal/index.html    # Dependencies are debt (Terminal)
open demo/broadsheet/index.html  # The Half-Life of Attention (Broadsheet)
```

## Install

### Claude Code — marketplace

```text
/plugin marketplace add https://github.com/hanley-tech/better-slides
```

then, as a separate message:

```text
/plugin install better-slides@better-slides
```

Use it with `/better-slides:better-slides`.

### Claude Code — manual skill

```bash
git clone https://github.com/hanley-tech/better-slides.git ~/.claude/skills/better-slides
```

Then use it by typing `/better-slides`.

### Any other coding agent

Send the agent this repo link and ask it to use the better-slides skill. It should start
from [`SKILL.md`](SKILL.md) and load only the referenced support files it needs:

- `playbook/speaker-playbook.md` — the methodology
- `performance-styles/` — style index, preview cards, design systems
- `engine/` — the deck template + stage CSS
- `reference/` — layouts, motion, audio, theming
- `scripts/` — PPTX extraction, deploy, PDF export

## How it works

1. **Brief** — purpose, length, and *register* (speaker-led vs. reading), plus your
   content: a topic, rough notes, finished material, or an existing `.pptx` to convert.
2. **Method pass** — the agent applies the Speaker Playbook: finds your one idea, your
   hero slide, your landing.
3. **Style** — pick a performance style from generated live previews.
4. **Build** — one self-contained HTML deck, themed, with the motion and (optionally)
   sound layer wired in.
5. **Perform / share** — present it (`f` fullscreen, `m` sound), edit inline (`e`, then
   `Ctrl/Cmd+S` to save), deploy to a URL, or export a PDF.

## Architecture (progressive disclosure)

| File | Purpose | Loaded when |
| --- | --- | --- |
| [`SKILL.md`](SKILL.md) | Core workflow + invariants | Always |
| [`playbook/speaker-playbook.md`](playbook/speaker-playbook.md) | What to say — the methodology | Phase 1 (content) |
| [`performance-styles/selection-index.json`](performance-styles/selection-index.json) | Compact style metadata | Phase 2 (style) |
| `performance-styles/*/preview.md` | Title-slide preview cards | Phase 2 (shortlist) |
| `performance-styles/*/design.md` | Full design system for the chosen style | Phase 3 (generate) |
| [`engine/template.html`](engine/template.html) | Base deck (stage + nav + chrome) | Phase 3 |
| [`engine/stage.css`](engine/stage.css) | Mandatory fixed-stage CSS | Phase 3 |
| [`reference/layouts.md`](reference/layouts.md) | Slide recipes | Phase 3 |
| [`reference/motion.md`](reference/motion.md) | Timed-reveal / GSAP / `omt` patterns | Phase 3 |
| [`reference/audio.md`](reference/audio.md) | Sound design + Web Audio wiring | Phase 3 (if sound) |
| [`reference/theming.md`](reference/theming.md) | Token swap | Phase 3 |
| [`scripts/extract-pptx.py`](scripts/extract-pptx.py) | PPTX content extraction | Phase 0 (conversion) |
| [`scripts/deploy.sh`](scripts/deploy.sh) | Deploy to a live URL (Vercel) | Phase 4 (share) |
| [`scripts/export-pdf.sh`](scripts/export-pdf.sh) | Export to PDF | Phase 4 (share) |
| [`scripts/capture-shots.sh`](scripts/capture-shots.sh) | Capture `og.jpg` / slide stills | Phase 4 (publish) |

## Philosophy

1. **A deck is a performance, not a document.** Optimize for what the room *feels*.
2. **One idea, said in one breath.** If it doesn't fit in a breath, it isn't one idea yet.
3. **The hero slide does the spreading.** Build one visual worth photographing.
4. **Dependencies are debt.** One HTML file works forever.
5. **Tell them what to say, not just how it looks.** Design without a point of view is slop.

## Credits

By [Hanley Leung](https://github.com/hanley-tech) ([hanley.world](https://hanley.world)) / [LunaTechs](https://lunatechs.social).
Engine extracted from the LunaTechs Speaker Playbook deck.

## License

MIT — use it, modify it, share it.
