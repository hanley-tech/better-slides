---
version: alpha
name: Terminal
description: A developer-native performance system — GitHub-dark stage, terminal green, monospace everything. The deck reads like a live session in the tool the audience already trusts; the theatrics come from pacing and a blinking cursor, not color.

colors:
  bg:      "#0D1117"   # GitHub-dark stage
  panel:   "#161B22"   # raised panel / code block surface
  black:   "#010409"   # deepest shade, gradient ends
  ink:     "#E6EDF3"   # primary text
  muted:   "#8B949E"   # secondary text, comments
  green:   "#39D353"   # THE accent — prompts, highlights, the hero number
  green-2: "#26A641"   # darker green for gradient ends
  amber:   "#D29922"   # the one warning beat per deck, nothing else
  line:    "#21262D"   # hairline borders

typography:
  display: { family: "JetBrains Mono, SF Mono, ui-monospace, monospace", size: "9.5cqmin", weight: 800, line: 1.0,  tracking: "-0.02em" }
  mega:    { family: "JetBrains Mono, monospace",                        size: "19cqmin",  weight: 800, line: 0.9,  tracking: "-0.04em" }
  h2:      { family: "JetBrains Mono, monospace",                        size: "7cqmin",   weight: 800, line: 1.05, tracking: "-0.02em" }
  kicker:  { family: "JetBrains Mono, monospace",                        size: "2.6cqmin", weight: 500, line: 1.2,  prefix: "# " }
  sub:     { family: "JetBrains Mono, monospace",                        size: "3cqmin",   weight: 400, line: 1.5 }
---

## Stage policy (better-slides)

Fixed 1920×1080 stage scaled uniformly to the viewport (see `engine/stage.css`).
Letterbox/pillarbox, never reflow. Sizes use `cqmin`.

## Overview

Terminal is for talks where the audience lives in a shell. Instead of borrowing
authority from design, it borrows it from the **medium**: GitHub-dark surfaces,
JetBrains Mono at every size, green as the only voice of emphasis. Headlines read like
commands or output; kickers read like comments. It is quiet, precise, and a little
underground — the opposite of a marketing deck, which for this audience *is* the
marketing.

Commitments:

1. **Monospace everything.** Display, body, chrome. One proportional glyph breaks the
   fiction.
2. **Green is the only accent.** Prompts (`$`, `>`), highlighted words, the hero
   number. **Amber appears at most once per deck** — the warning beat ("here's where
   it bit us") — and lands harder for its scarcity.
3. **The cursor is the heartbeat.** A blinking block cursor (▮) ends the title
   headline and may end the final slide. Nowhere else.

## Type & voice

- Kickers are comments: `# the premise`, `# what broke`. Lowercase, `muted`.
- Headlines are commands or outputs: `make it boring-proof`, `0 deps. 1 file.`
- The hero stat uses `mega` in green — a number that looks like benchmark output.
- Body lines may carry a `$ ` or `> ` prompt prefix in green when the line *is* a
  command; never decorate prose with prompts.

## Layout

Use the standard recipes (`layouts.md`) with the Terminal voice: statement slides
dominate; `bars` for benchmarks; `bca` as "log dump vs one green number"; the close is
a `$ git clone …` actcard plus QR. Panels (`.card`, `.mock`) sit on `panel` with
1px `line` borders, 8px radius max — terminal corners, not bubbles.

## Motion

- Entrances are instant-ish (`.pop` with short durations) — terminals don't ease.
- The signature reveal is **type-on**: the headline appears as if printed, then the
  cursor blinks. Implement with a CSS steps() width animation or a small JS typer for
  the title and `omt` only.
- `.slam` only for the hero number. The `omt` finale works beautifully here: a bare
  `$ ▮` prompt holds, then the payoff line prints.
- Mirror everything in `prefers-reduced-motion` and `@media print`.

## Sound (if enabled)

Mechanical and small: a soft tick per beat reveal (the `tick` cue), one square-wave
chime when the hero number lands, applause bed on the close only if the talk is a
launch. No music pad — silence is more terminal.

## Theme block

```css
:root{
  --ink:#E6EDF3; --bg:#0D1117; --black:#010409;
  --blue:#39D353; --cyan:#39D353; --deep:#26A641;   /* green carries the accent role */
  --gold:#D29922; --amber:#D29922;                  /* the once-per-deck warning */
  --mono:"JetBrains Mono","SF Mono",ui-monospace,monospace;
  --p0:#0D1117; --p1:#10161D; --p2:#0E2417; --p3:#0A0E14; --p4:#0D1117; --p5:#10161D;
}
```

Font: `JetBrains Mono` (400–800) via Google Fonts.

## CJK note

JetBrains Mono has no CJK glyphs — stack `Noto Sans Mono CJK SC` (or `Sarasa Mono SC`)
after it so CJK runs stay monospaced and aligned. Drop letter-spacing to 0 on CJK,
keep prompts/comment markers (`#`, `$`) in ASCII, and prefer Latin numerals for stats.

## Do / Don't

**Do:** keep everything mono; speak in commands and comments; spend amber exactly
once; let the cursor blink only at the title and the end; show real terminal-shaped
artifacts (logs, diffs, benchmarks) as the eye candy.

**Don't:** mix in a proportional font; use green on long prose; add rounded-bubble
chrome or drop shadows; use more than one warning beat; fake terminal output the
audience would know is fake.
