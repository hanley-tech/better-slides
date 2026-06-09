---
version: alpha
name: Broadsheet
description: A literary editorial performance system — deep ink stage, warm cream serif, one crimson accent. A long-form magazine feature that learned to hold a room; the deck never raises its voice because the typography already has the floor.

colors:
  ink-bg:  "#14181F"   # the ink stage
  black:   "#0C0E12"   # deepest shade, gradient ends
  cream:   "#EDE6D6"   # primary type — warm paper, never pure white
  muted:   "#9A937F"   # secondary type, captions
  crimson: "#C8553D"   # THE accent — rules, italic emphasis, the hero figure
  rust:    "#8F3A2A"   # darker crimson for gradient ends
  line:    "#2A2F38"   # hairline rules

typography:
  display: { family: "Fraunces, Georgia, serif", size: "10cqmin",  weight: 900, line: 0.98, tracking: "-0.02em" }
  mega:    { family: "Fraunces, Georgia, serif", size: "20cqmin",  weight: 900, line: 0.85, tracking: "-0.03em" }
  h2:      { family: "Fraunces, Georgia, serif", size: "7.6cqmin", weight: 700, line: 1.05, tracking: "-0.015em" }
  kicker:  { family: "Fraunces, Georgia, serif", size: "2.2cqmin", weight: 600, line: 1.2,  tracking: "0.22em", transform: "uppercase" }
  sub:     { family: "Source Serif 4, Georgia, serif", size: "3.4cqmin", weight: 400, line: 1.55 }
  quote:   { family: "Fraunces, Georgia, serif", size: "6cqmin",   weight: 500, line: 1.25, style: "italic" }
---

## Stage policy (better-slides)

Fixed 1920×1080 stage scaled uniformly to the viewport (see `engine/stage.css`).
Letterbox/pillarbox, never reflow. Sizes use `cqmin`.

## Overview

Broadsheet is for talks that are really **essays** — research, strategy, criticism,
policy. Where Noir borrows the launch stage and Terminal borrows the shell, Broadsheet
borrows the serious magazine: a deep ink ground, warm cream serif, hairline rules, and
a single crimson accent spent like an editor spends italics. The audience should feel
they are being *thought at*, not sold to.

Commitments:

1. **The serif has the floor.** Fraunces carries every headline; body is a quieter
   serif. No grotesques anywhere — sans type breaks the register.
2. **Crimson is punctuation, not decoration.** The short rule under a kicker, one
   italic emphasized word per headline (the "essay moment"), the hero figure, the
   oversized quotation mark. Never body text, never a fill.
3. **Margins are the luxury.** Wider side padding than any other style (10cqmin+).
   A crowded Broadsheet slide reads as a broken one.

## Type & voice

- Kickers are letterspaced uppercase serif in `muted` — chapter openers, not labels.
- Headlines are sentences with one italic crimson word: *Make them* ***feel*** *the
  argument.* The italic word is the emphasis system; bold does not exist here.
- Pull-quote slides: an oversized crimson `"` glyph, the quote in `quote` italic,
  attribution in `muted` small caps.
- The hero figure sets in `mega` crimson — a number typeset like a magazine stat.

## Layout

Statement slides with generous margins dominate. Use hairline `line` rules (1px) as
section punctuation; a 40px × 2px crimson rule sits between every kicker and headline.
`split` works for portrait imagery with captions; `bca` becomes "the memo vs the
finding". Cards take 0 radius, 1px `line` borders — plates, not bubbles. The close is
quiet: a single line, the QR, the credit.

## Motion

- Slow and editorial: fades and 600–900ms rises, no bounce, no slam except the hero
  figure (and even that at reduced amplitude).
- The signature reveal is the **rule draw**: the crimson kicker-rule draws in over
  ~500ms, then the headline fades up. Implement with a width transition.
- The `omt` finale lands as a turned page: a held beat, the kicker "one more thing"
  in small caps, the payoff line fading up with its italic crimson word.
- Mirror everything in `prefers-reduced-motion` and `@media print`.

## Sound (if enabled)

Nearly silent: a soft page-turn swoosh on section breaks, one low chime when the hero
figure lands. No music bed, no applause synth — Broadsheet's room claps on its own.

## Theme block

```css
:root{
  --ink:#EDE6D6; --bg:#14181F; --black:#0C0E12;
  --blue:#C8553D; --cyan:#C8553D; --deep:#8F3A2A;   /* crimson carries the accent role */
  --gold:#C8553D; --amber:#8F3A2A;                  /* no second accent in this system */
  --mono:"Fraunces",Georgia,serif;
  --p0:#14181F; --p1:#181D26; --p2:#241A18; --p3:#10131A; --p4:#14181F; --p5:#181D26;
}
```

Fonts: `Fraunces` (500–900, + italics) and `Source Serif 4` (400) via Google Fonts.

## CJK note

Fraunces has no CJK glyphs and CJK has no true italics — stack `Noto Serif SC` after
Fraunces, render the "essay moment" as a crimson color shift *without* italic on CJK
runs, drop letter-spacing to 0, and open body line-height to ~1.8. The hairline rules,
crimson punctuation, and margin discipline carry the register unchanged.

## Do / Don't

**Do:** spend crimson once or twice per slide at most; give every headline one italic
moment; keep margins extravagant; use pull quotes as section beats; let silence and
stillness do the theatrics.

**Don't:** introduce a sans-serif anywhere; bold for emphasis; crowd a slide to fit an
argument (split it); animate with bounce or speed; add a second accent color.
