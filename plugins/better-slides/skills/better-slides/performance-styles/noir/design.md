---
version: alpha
name: Noir
description: A black-stage, white-light performance system in the spirit of an Apple keynote — a darkened auditorium where a few enormous words carry all the weight. One restrained accent, one idea per slide, theatrical pacing, and a "one more thing" finale. The screen is mostly black on purpose; the lit type is the spotlight.

colors:
  stage:    "#0B0C12"   # the black stage — deepest base
  black:    "#000000"   # true black for gradient ends and the void around hero type
  ink:      "#F5F5F7"   # near-white primary type (never pure #FFF — softer on a projector)
  muted:    "#8A8A8E"   # secondary / supporting type
  hint:     "#48484C"   # tertiary, captions, chrome
  accent:   "#2997FF"   # the single accent (electric blue). Swappable per brand.
  accent-2: "#5AC8FA"   # a lighter tint of accent for glow only
  line:     "#1C1C22"   # hairline dividers on the stage

typography:
  display:  { family: "Inter Tight, Helvetica Neue, -apple-system, sans-serif", size: "11cqmin",  weight: 900, line: 0.95, tracking: "-0.03em" }
  mega:     { family: "Inter Tight, Helvetica Neue, sans-serif",                size: "22cqmin",  weight: 900, line: 0.82, tracking: "-0.05em" }
  h2:       { family: "Inter Tight, Helvetica Neue, sans-serif",                size: "8.4cqmin", weight: 900, line: 1.0,  tracking: "-0.03em" }
  kicker:   { family: "SF Mono, ui-monospace, monospace",                       size: "2.4cqmin", weight: 700, line: 1.2,  tracking: "0.16em", transform: "uppercase" }
  sub:      { family: "Inter, -apple-system, sans-serif",                       size: "3.7cqmin", weight: 500, line: 1.42 }
  stat:     { family: "Inter Tight, Helvetica Neue, sans-serif",                size: "20cqmin",  weight: 900, line: 0.85, tracking: "-0.04em" }
---

## Stage policy (better-slides)

Generate the deck as a fixed 1920×1080 stage scaled uniformly to the viewport (see
`engine/stage.css`). Preserve 16:9 on every screen; letterbox/pillarbox, never reflow.
All sizes below use `cqmin` so they scale with the stage.

## Overview

Noir is the **default better-slides look** and the one to reach for when a talk
should feel like a *stage*. The visual premise is a darkened auditorium: the screen is
~90% black, and the few words that are lit read as a spotlight. Because there is so little
on screen, every word is enormous and every entrance is an event.

The system is built on three commitments:

1. **One idea per slide.** Never two. If a slide has two thoughts, it is two slides. The
   black space is not empty — it is the pause around the idea.
2. **One accent, used three times at most per slide.** Electric blue by default (swap to a
   brand color in the theme block). It marks the kicker, one hero word, and rules — nothing
   else. Body text is never accent-colored.
3. **Theatrical time.** Slides do not dump their content on entry. The headline arrives on
   a *beat* — a held pause, then the line. This is the system's heartbeat (see Motion).

## Colors

- **Stage** (`#0B0C12`) and **black** (`#000`): the base. Use `stage` as the slide
  background; reserve true black for the radial void behind `mega`/`stat` hero type and for
  gradient ends.
- **Ink** (`#F5F5F7`): all primary type. Never pure white — on a bright projector pure white
  blooms and fatigues; the warm-cool off-white reads cleaner.
- **Muted** (`#8A8A8E`): subheads and supporting lines. **Hint** (`#48484C`): captions,
  chrome, slide counter.
- **Accent** (`#2997FF`): the kicker text, exactly one emphasized word in a headline, the
  short rule under a kicker, the hero stat. A faint `accent-2` glow (`text-shadow` /
  `box-shadow`) may halo the hero word. Never fill a region with accent.
- **Line** (`#1C1C22`): 1px hairline dividers when a slide needs structure. Sparingly.

## Typography

A single tight grotesque carries everything (Inter Tight, falling back to Helvetica Neue —
the keynote face). Mono only for the kicker and chrome. The ladder:

| Token | Size | Use |
| --- | --- | --- |
| `mega` | 22cqmin | the hero word/number — one per deck, the money moment |
| `display` | 11cqmin | title-slide headline |
| `h2` | 8.4cqmin | the per-slide statement (the workhorse) |
| `stat` | 20cqmin | a big number on a stat slide |
| `sub` | 3.7cqmin | one supporting sentence, ≤24ch, in `muted` |
| `kicker` | 2.4cqmin | mono uppercase eyebrow in `accent`, 0.16em tracking |

Rules: headlines are `ink`, never accent (emphasize at most one word in accent via `<span>`).
Tracking is tight and negative on display sizes. One sentence of `sub` maximum — if it needs
two, the second is a new slide. No bold-for-emphasis in body; promote it to a headline.

## Layout

- **Title:** centered or hard-left lockup — mono kicker, `display` headline (one accent
  word), a quiet `sub` or brand line. Maximum black around it.
- **Statement (workhorse):** `kicker` + `h2`. Nothing else. Vertically centered, generous
  9cqmin side padding.
- **Hero / money slide:** `mega` number or `stat`, a one-line `sub` caption beneath in
  `muted`. This is the screenshot. A faint accent glow is allowed here and nowhere else.
- **Before→after:** two stacked lines — the struck "don't" in `muted`, the accent "do"
  below. Or the `bca` mockup recipe from `layouts.md`.
- **`omt` finale:** see Motion. A held black slide → "one more thing" kicker → the payoff
  line slamming in.

Depth is flat. No cards, no shadows except the hero glow, no rounded chrome. Separation is
black space and the occasional hairline.

## Motion

This style lives or dies on **pacing** (see `reference/motion.md`). The grammar:

- **Held entrance.** On slide enter, the stage is black/quiet for ~0.4–0.8s before the
  headline reveals. The pause is the drama. Implement via a GSAP timeline with a leading
  `delay`, or a CSS `animation-delay` on the headline.
- **Single decisive reveal.** Most slides reveal their one line once — no multi-element
  choreography. Kicker fades, then headline rises (`.pop`), done.
- **`.slam` for the hero.** The `mega`/`stat` moment uses the punchy scale-in. Once per deck.
- **The `omt` finale (signature):** a near-empty hold → `omt-kicker` ("one more thing")
  fades up after ~1.2s → `omt-line` slams in (`back.out`) → confetti/applause on the final
  slide. Use the `playOMT()` recipe in `motion.md`.
- **Ambient:** a very slow radial vignette breathing behind the type is allowed; nothing
  else moves between beats.
- All entrances mirrored in `prefers-reduced-motion` (instant final state) and `@media print`.

## Sound (if enabled — see `reference/audio.md`)

Restrained, cinematic. The cue palette:

- **swoosh** — only on section/chapter breaks, never on every slide.
- **chime** — when the hero number lands (pairs with `.slam`).
- **omt** cue — the low two-tone turn as "one more thing" appears.
- **applause bed** — fades up under the finale, peaks on the final slide, then fades.
- Optional: a low music pad under the title and the close, ducked, looping, faded.

Default music off, cues on-but-quiet, always a mute toggle. The deck must read fully muted.

## Theme block

Drop this `<style id="theme">` into the engine template to render Noir. To rebrand,
change `--accent` only — the rest of the system is grayscale by design.

```css
:root{
  --ink:#F5F5F7; --bg:#0B0C12; --black:#000000;
  --blue:#2997FF; --cyan:#5AC8FA; --deep:#0A2540;   /* accent family */
  --gold:#2997FF; --amber:#5AC8FA;                  /* reuse accent; Noir has no gold */
  --mono:"Inter Tight","Helvetica Neue",-apple-system,Arial,sans-serif;
  --p0:#0B0C12; --p1:#0E1018; --p2:#0A2540; --p3:#08080C; --p4:#0B0C12; --p5:#0E1018;
}
```

Fonts: `Inter Tight` (display) via Google Fonts; mono via `SF Mono`/system. Keep the swirl
palette (`--p0…--p5`) near-black so the ambient background never lifts off the stage.

## CJK note

Inter Tight has no CJK glyphs — stack `Noto Sans SC` after it in every font role so
Chinese/Japanese/Korean decks render in one coherent face. Drop the negative display
tracking to 0 on CJK runs (tight tracking breaks CJK rendering), skip uppercase
transforms, keep stats in Latin numerals, and open body line-height to ~1.7. The black
stage, single accent, and held-pause pacing are glyph-agnostic and carry unchanged.

## Do / Don't

**Do:** keep ~90% of the stage black; one idea per slide; one accent word per headline; hold
the beat before a headline; reserve `.slam` and `omt` for the hero and the finale; use a
genuinely huge `mega` for the money number.

**Don't:** put two ideas on a slide; color body text with the accent; add cards/shadows/
rounded chrome; animate every element; introduce a second accent color; fill the screen
edge-to-edge — crowding breaks the auditorium illusion.
