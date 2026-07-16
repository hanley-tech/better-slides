---
version: alpha
name: Obsidian
description: An all-black, fully monochrome performance system in the spirit of apple.com on a black background — every slide is true black with subtle radial depth, type is SF Pro and near-white, and there is no color at all except, optionally, a single white-pill CTA at the very end. Where Noir keeps one electric accent, Obsidian removes color entirely: the luxury is restraint, space, and craft. The screen is black; the few lit words and the air around them carry everything.

colors:
  stage:    "#000000"   # true black — the base of every slide
  depth-a:  "#151515"   # subtle radial highlight (slide center, ~28% down)
  depth-b:  "#080808"   # radial midtone
  ink:      "#F5F5F7"   # near-white primary type (never pure #FFF — softer on a projector)
  muted:    "#8E8E93"   # secondary / supporting type, eyebrows
  hairline: "rgba(255,255,255,0.22)"  # 1px editorial rules
  cta:      "#F5F5F7"   # the optional close CTA pill is WHITE on black (not blue)
  accent:   "none"      # Obsidian has no accent color by default — monochrome is the look

typography:
  display:  { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "11.8cqmin", weight: 600, line: 0.98, tracking: "-0.024em" }
  mega:     { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "20cqmin",   weight: 600, line: 0.92, tracking: "-0.03em" }
  h2:       { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "8cqmin",    weight: 600, line: 1.05, tracking: "-0.018em" }
  kicker:   { family: "SF Pro Text, -apple-system, sans-serif",                 size: "1.85cqmin", weight: 600, line: 1.2,  tracking: "0.22em", transform: "uppercase" }
  sub:      { family: "SF Pro Text, -apple-system, sans-serif",                 size: "3.3cqmin",  weight: 400, line: 1.34 }
---

## Stage policy (better-slides)

Generate the deck as a fixed 1920×1080 stage scaled uniformly to the viewport (see
`engine/stage.css`). Preserve 16:9 on every screen; letterbox/pillarbox, never reflow.
All sizes below use `cqmin` so they scale with the stage.

## Overview

Obsidian is **apple.com after dark** — the clean, spacious, SF-Pro product-page aesthetic
rendered on an all-black stage and stripped of color. It is the high-end choice when a deck
should feel *expensive and restrained* rather than theatrical (Noir) or energetic
(Spotlight). The premise: on black, a single near-white line with a lot of air around it
reads as luxury. Color is not the accent — **space and craft are**.

Three commitments:

1. **Every slide is true black.** No white sections, no gray sections, no alternation. The
   only variation is a *subtle radial depth* (a near-black center glow) so the screen has
   dimension and never reads as a flat void. Consistency is the luxury.
2. **Fully monochrome.** Near-white type, muted-gray support, white hairlines. **No accent
   color anywhere.** The one permitted spot of contrast is a single *white-pill* CTA on the
   closing slide — and even that is optional. If a brand demands one accent, allow it on the
   close CTA only, nowhere else.
3. **Restraint over effect.** No glassmorphism, no cards, no shadows beyond the depth glow,
   no gradient text, no glow on type. High-end here means *less*: huge type is actually a
   touch smaller than Noir, with more margin. Space sells.

## Colors

- **Stage**: true `#000`. Each slide paints a subtle radial — `radial-gradient(120% 100% at
  50% 28%, #151515 0%, #080808 58%, #000 100%)` — so black has depth. Keep it faint; it
  should be felt, not seen.
- **Ink** (`#F5F5F7`): all primary type. Never pure white (it blooms on a projector).
- **Muted** (`#8E8E93`): subheads, eyebrows, the secondary CTA link. One muted tone for all
  support — do not introduce a second gray.
- **Hairline** (`rgba(255,255,255,.22)`): 1px rules — above the eyebrow, and any divider.
  Used sparingly; the hairline is the only "decoration" in the system.
- **No accent.** Do not color a headline word. Do not color the kicker. The discipline of
  zero color is the entire point — reintroducing blue breaks the look.

## Typography

A single humanist sans carries everything: **SF Pro Display** for headlines (falls back to
`-apple-system`, then `Inter Tight`), **SF Pro Text** for kicker and body. Weights are
Apple's: **600 (semibold)** for display — never 900. The negative tracking is gentler than
Noir's; SF Pro is already tight.

| Token | Size | Use |
| --- | --- | --- |
| `mega` | 20cqmin | one hero word/number — the rare money moment |
| `display` | 11.8cqmin | title-slide headline |
| `h2` | 8cqmin | the per-slide statement (the workhorse) — semibold, monochrome |
| `sub` | 3.3cqmin | one supporting sentence, ≤26ch, in `muted`, weight 400 |
| `kicker` | 1.85cqmin | tiny uppercase eyebrow in `muted`, 0.22em tracking, **with a 1px hairline rule centered above it** |

Rules: headlines are `ink`, one weight (600), one color — emphasis comes from the *line
itself*, never a colored span. One sentence of `sub` maximum. No bold-for-emphasis in body.
Prefer curly quotes/apostrophes (’ “ ”) — a small typographic tell of care.

## Layout

- **Title:** centered lockup — a muted brand line up top, the `display` headline centered,
  maximum black around it. No tenure/résumé line; lead with the idea.
- **Statement (workhorse):** hairline → `kicker` → `h2` → optional `sub`. All centered,
  vertically centered, **generous 9–12cqmin padding** (more air than Noir).
- **Hero moment:** a single `mega` line, near-white, no glow. The depth radial is the only
  background event.
- **Close:** `kicker` ("Thank you") → `h2` → muted `sub` (name/handle) → a **white-pill
  CTA** (`background:#F5F5F7; color:#000`) plus an optional muted text link (`›`). This is
  the only filled shape in the entire deck.

Depth is flat-with-a-glow. No cards, no rounded panels, no shadows except the radial.
Separation is black space and the occasional centered hairline.

## Motion

Calm and slow — Apple, not a launch hype reel.

- **Single gentle reveal.** Each slide fades its line up once: `@keyframes arise{from{opacity:0;
  transform:translateY(18px)} to{opacity:1;transform:none}}`, ~0.9s,
  `cubic-bezier(.22,.61,.18,1)`. Apply to both `.pop` and `.slam` (override the engine's
  bouncy `.slam` — Obsidian never scales-punch).
- **No multi-element choreography.** Kicker + headline + sub rise together (light stagger is
  fine via the engine's `.pop` nth-child delays). Nothing else moves between beats.
- **Ambient:** an almost-imperceptible faint grain over the black (`.grain` at opacity ~.045)
  gives a filmic texture and prevents the depth radial from banding. Nothing else animates.
- All entrances mirrored in `prefers-reduced-motion` (instant final state) and `@media print`.

## Sound (if enabled — see `reference/audio.md`)

Minimal. A soft `swoosh` on a true section break at most; one low cue on a hero line if there
is one. **No applause bed, no music** by default — Obsidian's restraint extends to silence.
Always a mute toggle; the deck must read fully muted.

## Theme block

Drop this `<style id="theme">` into the engine template to render Obsidian. It is grayscale
by design — there is nothing to rebrand except, if you must, the single close-CTA color.

```css
:root{
  --ink:#F5F5F7; --bg:#000000; --black:#000000;
  --blue:#F5F5F7; --cyan:#F5F5F7; --deep:#0A0A0A;   /* "accent" family folded to white — monochrome */
  --gold:#F5F5F7; --amber:#F5F5F7;
  --mono:"SF Pro Display","SF Pro Text",-apple-system,"Inter Tight",Arial,sans-serif;
  --p0:#000; --p1:#0a0a0a; --p2:#000; --p3:#0a0a0a; --p4:#000; --p5:#0a0a0a;
}
```

Then, in the deck's own `<style>`, set every slide to the black depth radial, hide the
animated swirl (`#bg`) and motes, keep `.grain` faint, restyle the kicker with a hairline
`::before`, make the close CTA a white pill, and recolor the glass chrome to dark
monochrome. (See the worked deck: an apple.com-after-dark "Ten things Apple taught me"
keynote.)

Fonts: SF Pro is a system face on Apple platforms (`-apple-system`); stack `Inter Tight`
after it as a cross-platform fallback. No web-font request is strictly required.

## CJK note

SF Pro / Inter Tight have no CJK glyphs — stack `Noto Sans SC` after them in every font
role. Drop the negative display tracking to 0 on CJK runs, skip uppercase transforms on the
kicker, keep numerals Latin, and open body line-height to ~1.7. The all-black stage, zero
accent, and calm pacing are glyph-agnostic and carry unchanged.

## Do / Don't

**Do:** keep every slide true black with a faint depth radial; stay fully monochrome; give
each line a hairline-topped eyebrow; use more negative space than feels necessary; keep the
single white-pill CTA as the only filled shape; prefer curly quotes.

**Don't:** add an accent color (not even one word); alternate in white/gray slides; use
glassmorphism, cards, shadows, or gradient text; make the type as huge as Noir — Obsidian is
smaller-and-airier; add applause/music. The instant you add color or a frosted panel, it
stops reading as high-end.
