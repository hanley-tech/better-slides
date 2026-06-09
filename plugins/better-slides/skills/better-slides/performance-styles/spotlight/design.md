---
version: alpha
name: Spotlight
description: A high-energy, friendly performance system — the LunaTechs stage voice. Deep navy stage with an animated electric-blue glow, big bold-but-rounded Poppins type, a gold pop accent for the moments that matter, tinted highlight pills, and a confetti finish. Warmer and louder than Noir; a party with a point.

colors:
  stage:   "#0B1B30"   # deep navy base
  black:   "#14161C"   # darkest shade / gradient ends
  ink:     "#FFFFFF"   # primary type
  muted:   "#B8C6D8"   # secondary type
  blue:    "#1090E0"   # brand primary — bars, brandmark, structure
  bright:  "#00B0F0"   # brand bright — highlights, chart line, badges
  deep:    "#0050B0"   # brand deep — dark end of gradients
  gold:    "#FCD830"   # the pop accent — hero numbers, deltas, confetti
  amber:   "#F2960B"   # gold's warm partner

typography:
  display: { family: "Poppins, -apple-system, sans-serif", size: "11cqmin",  weight: 900, line: 0.95, tracking: "-0.03em" }
  mega:    { family: "Poppins, sans-serif",                size: "22cqmin",  weight: 900, line: 0.82, tracking: "-0.05em" }
  h2:      { family: "Poppins, sans-serif",                size: "8.4cqmin", weight: 900, line: 1.0,  tracking: "-0.03em" }
  kicker:  { family: "Poppins, sans-serif",                size: "3.5cqmin", weight: 700, line: 1.2,  tracking: "0.14em", transform: "uppercase" }
  sub:     { family: "Poppins, sans-serif",                size: "3.7cqmin", weight: 600, line: 1.42 }
---

## Stage policy (better-slides)

Fixed 1920×1080 stage scaled uniformly to the viewport (see `engine/stage.css`). Preserve
16:9 on every screen; letterbox/pillarbox, never reflow. Sizes use `cqmin`.

## Overview

Spotlight is the **Speaker Playbook's native voice** — the look the "Be Unforgettable" talk
wears. Where Noir is a darkened auditorium, Spotlight is a lit, friendly stage: deep
navy with a living electric-blue glow, type that is bold but rounded (Poppins), and a single
gold pop for the punchlines. It is loud and human on purpose. The energy *is* the message
(playbook §11: turn it up).

Commitments:

1. **Warm, not corporate.** Conversational copy, emoji as punctuation where it fits, big
   friendly type. Never a wall of bullets.
2. **Blue is the system, gold is the moment.** The blue family carries structure and
   highlights; gold appears only on the thing you want photographed (the hero number, a
   delta, the confetti). One gold element per slide, max.
3. **Movement is joy.** Bouncy staggered builds, a hero word that can wiggle, confetti at the
   close. Motion here is allowed to be a little playful — but still one beat per click.

## Colors

- **Stage** `#0B1B30` with an animated radial **blue→deep** glow behind content (the engine's
  ambient gradient, tuned to the blue family). **Black** `#14161C` for gradient ends.
- **Ink** `#FFFFFF` primary; **muted** `#B8C6D8` for subs and support.
- **Blue family** (`blue`/`bright`/`deep`): structure, bars, chart lines, badges, the `.hl`
  and `.wink` highlight pills behind key words.
- **Gold** `#FCD830`: the rare pop — hero `mega`/`stat` numbers, a `.plus` delta, confetti.
  Never body text, never a full background. Its scarcity is its power.

## Typography

Poppins throughout (geometric, friendly, ships every weight). Ladder mirrors Noir's
sizes (`mega` 22 / `display` 11 / `h2` 8.4 / `sub` 3.7 / `kicker` 3.5 cqmin) but at heavier,
rounder weights. Headlines are `ink`; emphasize key words with a `.hl` blue pill or `.wink`
tilt rather than a color change; the hero number is gold.

## Layout

Use the full `layouts.md` kit freely — Spotlight is the style those recipes were tuned for:
`title-hero` with the glow + brand lockup, `bca` before/after mockups, `herochart` for the
money slide, `cards`/`chips` for sets, `bars` for comparisons, `funnel3` for "many→one",
`actcard` for the CTA close, `qrwrap` for don't-vanish, `photo` full-bleed closer (auto
confetti). Rounded corners and soft shadows are welcome here (the opposite of Noir's flat).

## Motion

See `reference/motion.md`. Spotlight's flavor:

- **Bouncy staggered builds** — `.pop` children stagger in with a springy ease; lists reveal
  per beat with `[data-beat]`.
- **`.slam`** on the hero word/number; **`.jit`** (gentle wiggle) on one alive word per deck.
- **Hero number** lands with a gold `.slam` + (if sound) a power-up hit.
- **Finale:** confetti on the last slide (engine auto-fires it) under an applause bed. An
  `omt` is optional here and lands playful rather than solemn.
- Mirror all entrances in `prefers-reduced-motion` and `@media print`.

## Sound (if enabled — see `reference/audio.md`)

Playful and warm: quiet `tick`/blip on beat reveals, a power-up + `chime` on the hero number,
an applause bed and an optional upbeat music pad under the title and close (ducked, looped,
faded). Default music off, cues on-but-quiet, mute toggle always present.

## Theme block

```css
:root{
  --ink:#fff; --bg:#0B1B30; --black:#14161C;
  --blue:#1090E0; --cyan:#00B0F0; --deep:#0050B0;
  --gold:#FCD830; --amber:#F2960B;
  --mono:"Poppins","Helvetica Neue",Arial,sans-serif;
  --p0:#0e3b66; --p1:#0a5a86; --p2:#0050B0; --p3:#0a2f52; --p4:#0e3b66; --p5:#0a5a86;
}
```

Font: `Poppins` (400–900) via Google Fonts. (This is the worked LunaTechs theme from
`reference/theming.md`.)

## Do / Don't

**Do:** keep copy conversational; one gold pop per slide; use highlight pills not color
swaps; let one word wiggle; end in confetti; lean into the energy.

**Don't:** scatter gold everywhere (it stops being special); write paragraphs; use more than
one featured motion per slide; go corporate-flat — Spotlight is meant to feel alive.
