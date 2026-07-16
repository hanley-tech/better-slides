---
version: alpha
name: Cupertino
description: A photo-forward personal-keynote system on the Obsidian monochrome base — true-black stage, near-white SF Pro, full-bleed photography under a directional scrim. Built for the "N things I learned from a chapter of my life" talk: a personal story arc, then a counted list of numbered lessons that reveal one at a time, a recap of all of them, and a QR close that hands the room your world. Where Obsidian is an abstract void of restraint, Cupertino fills that black with your own images and one warm blue "one more thing."

colors:
  stage:    "#000000"   # true black — the base and the letterbox
  depth-a:  "#151515"   # subtle radial highlight for text-only slides (from Obsidian)
  depth-b:  "#080808"   # radial midtone
  ink:      "#F5F5F7"   # near-white primary type (never pure #FFF — softer on a projector)
  muted:    "#8E8E93"   # secondary / supporting type, eyebrows, foot lines
  scrim:    "rgba(0,0,0,0.55)"  # directional photo scrim so type stays legible over any image
  accent:   "#2997FF"   # Apple blue on dark — used ONCE, on the "one more thing" word (and optionally the close)

typography:
  display:  { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "11.8cqmin", weight: 600, line: 0.98, tracking: "-0.024em" }
  mega:     { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "20cqmin",   weight: 600, line: 0.92, tracking: "-0.03em" }
  count:    { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "58cqmin",   weight: 800, line: 0.80, tracking: "-0.05em", note: "the one giant counting numeral" }
  lnum:     { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "9cqmin",    weight: 800, line: 0.9,  tracking: "-0.02em", note: "the lesson chapter number" }
  h2:       { family: "SF Pro Display, -apple-system, Inter Tight, sans-serif", size: "8cqmin",    weight: 600, line: 1.05, tracking: "-0.018em" }
  kicker:   { family: "SF Pro Text, -apple-system, sans-serif",                 size: "1.85cqmin", weight: 600, line: 1.2,  tracking: "0.22em", transform: "uppercase" }
  sub:      { family: "SF Pro Text, -apple-system, sans-serif",                 size: "3.3cqmin",  weight: 400, line: 1.34 }
---

## Stage policy (better-slides)

Generate the deck as a fixed 1920×1080 stage scaled uniformly to the viewport (see
`engine/stage.css`). Preserve 16:9 on every screen; letterbox/pillarbox, never reflow. All
sizes below use `cqmin` so they scale with the stage.

## Overview

Cupertino is **the personal photo-keynote** — the reflective "here are the N things a chapter
of my life taught me" talk, rendered on the same premium monochrome base as Obsidian but
*filled with your own photography instead of black space*. It is the choice when you have a
story to tell (a job, a company, a place, a decade), a set of images from it, and a numbered
list of takeaways you want to count down for the audience.

It shares Obsidian's spine — true-black stage, near-white SF Pro, weight 600, no glass, no
gradient text — so it reads as expensive and considered. What makes it its own style is
**structure and imagery**, not palette:

1. **Photography carries the emotion.** Nearly every slide is a full-bleed image under a
   directional scrim, not an abstract void. Obsidian's discipline is *removing* everything;
   Cupertino's is *composing* your real photos so the black around them still feels intentional.
2. **A counted list is the backbone.** The deck is a countdown: an opening story arc → a giant
   "N" reveal → lessons `1…N` that each punch in one at a time → a recap of all of them → a
   personal QR close. The numbers are the choreography.
3. **One warm accent, once.** Cupertino permits a single Apple-blue word — on the "one more
   thing" line, and optionally the close CTA. Everywhere else stays monochrome. The lesson: the
   blue only means something because it happens exactly once.

Reach for Cupertino over Obsidian when you have images and a personal narrative; reach for
Obsidian when the talk is abstract, imageless, and about restraint itself.

## Colors

- **Stage / letterbox**: true `#000`. Text-only slides (title, OMT) use Obsidian's faint depth
  radial — `radial-gradient(120% 100% at 50% 28%, #151515 0%, #080808 58%, #000 100%)` — so the
  black has dimension and never bands.
- **Ink** (`#F5F5F7`): all primary type. Never pure white.
- **Muted** (`#8E8E93`): eyebrows, subheads, the title foot line, recap numerals at reduced opacity.
- **Scrim**: photo slides carry a *directional* gradient scrim, not a flat wash — dark on the
  side the text sits, transparent where the photo should stay bright. Left-text layout:
  `linear-gradient(90deg, rgba(0,0,0,.35) 0%, rgba(0,0,0,.18) 24%, transparent 46%)`. Full-bleed
  caption: dark from the caption edge, clear across the subject. Tune per image; keep the subject lit.
- **Accent** (`#2997FF`): exactly one blue word, on the OMT "one more thing" line. Optionally the
  close CTA/URL. Nowhere else — no colored headline word, no colored kicker.

## Typography

Same face as Obsidian — **SF Pro Display** for headlines (falls back to `-apple-system`, then
`Inter Tight`), **SF Pro Text** for kicker/body, all weight **600** (Apple's semibold, never
900). Over photography, type carries a soft shadow for legibility: `text-shadow:0 .2cqmin 3cqmin
rgba(0,0,0,.7)` — enough to hold contrast on a busy image, never a glow.

| Token | Size | Use |
| --- | --- | --- |
| `count` | 58cqmin | the ONE giant counting numeral (the "10" reveal over the hero photo) |
| `mega` | 20cqmin | a rare single hero word/number |
| `lnum` | 9cqmin | the lesson chapter number (`1`…`N`), weight 800, above each lesson headline |
| `display` | 11.8cqmin | title-slide headline |
| `h2` | 8cqmin | the per-lesson / per-slide statement (the workhorse) |
| `sub` | 3.3cqmin | one supporting sentence, ≤26ch, in `muted`, weight 400 |
| `kicker` | 1.85cqmin | tiny uppercase eyebrow in `muted` (no topper rule — flat caps) |

Rules: headlines are `ink`, one weight, one color — emphasis from the line itself, never a
colored span. Numerals use `font-variant-numeric:tabular-nums`. Prefer curly quotes/apostrophes.

## Layout

The deck is a sequence, and the sequence is the style. A canonical Cupertino run:

- **Title:** centered lockup — a spaced-caps brand/venue line up top, the `display` headline
  centered in near-white, a muted foot line (talk context or your name). Black or a faint depth
  radial behind it; no photo needed here.
- **Story arc (a handful of slides):** full-bleed photos from the chapter, each with a short
  `h2` statement and optional `sub`, set left or bottom under a directional scrim. This is the
  personal setup before the count begins.
- **The count reveal:** one slide, a **giant `count` numeral** ("10") over a bright hero photo
  (e.g. the place), with a one-line `h2` naming what's about to happen. Ken-Burns the photo.
- **Lessons `1…N`:** the workhorse. Each is a full-bleed photo + a big `lnum` chapter number +
  an `h2` lesson headline + optional `sub`. The number and headline reveal dramatically (below).
  Keep one lesson per slide; let the image do half the talking.
- **Recap:** a single slide listing all N lessons as a numbered column beside one anchoring image
  (a logo on stone, a portrait, the place) — the numerals stagger in, a hairline rule draws under
  the head. This is the "here's everything, together" beat.
- **One more thing (optional):** a black text-only slide, `kicker` → an `h2`/`mega` line with a
  single **blue** word. The one accent in the deck.
- **Close:** `h2` thanks → a **QR block** (white-rounded QR + a `qrurl` and a soft `qrcta`
  line) pointing at your personal site. Optionally an Apple-style white pill + muted text link.

Separation is black space, the scrim, and photography — no cards, no rounded panels, no shadows
except what a photo/scrim naturally casts and the type shadow.

## Motion

Calm and cinematic — Apple, not a hype reel. Motion is where the "count" gets its drama.

- **Base reveal (`arise`):** each slide fades its lines up once, with a gentle blur-in:
  `@keyframes arise{from{opacity:0;transform:translateY(20px);filter:blur(12px)} to{opacity:1;
  transform:none;filter:blur(0)}}`, ~1s, `cubic-bezier(.22,.61,.18,1)`. Apply to both `.pop` and
  `.slam` (override the engine's bouncy slam — Cupertino never scale-punches).
- **Lesson reveal (signature):** the `lnum` **punches in big and blurred** then settles, and the
  headline **clip-wipes in beneath it** a beat later:
  `@keyframes lessonNum{0%{opacity:0;transform:translateY(.12em) scale(1.75);filter:blur(18px)}
  58%{opacity:1;filter:blur(0)}80%{transform:scale(.94)}100%{transform:scale(1)}}` and
  `@keyframes lessonTitle{0%{opacity:0;transform:translateY(.34em);clip-path:inset(0 100% -12% 0)}
  100%{opacity:1;transform:none;clip-path:inset(0 -3% -12% 0)}}` (~.26s later). This is the beat
  the audience feels each time the count advances.
- **Photography:** hero/count/lesson photos drift with a slow **Ken Burns**
  (`@keyframes kenburns` scale ~1.04 over 40s alternate). The image is the only ambient motion.
- **Recap:** the head fades in, a hairline rule draws left-to-right under it, and the N items
  stagger up one per ~75ms (numeral clip-wipes like the lesson title).
- All entrances mirrored in `prefers-reduced-motion` (instant final state, no blur/clip) and
  `@media print` (static, one slide per page, scrims flattened).

## Sound (if enabled — see `reference/audio.md`)

Sparing and warm. A soft cue as each lesson number lands (a low tick or chime — one per count,
so the sound *is* the countdown), an optional soft swoosh on the story→count transition, and one
gentle cue under the "one more thing." **No applause bed, no music** by default — the images and
the counted reveals carry the room. Always a mute toggle; the deck must read fully muted.

## Theme block

Cupertino inherits Obsidian's monochrome theme block — the palette is the same; what differs is
structure and imagery, which live in the deck's own `<style>`, not the `:root` vars. Drop this
`<style id="theme">` in, then add the photo/scrim/count/lesson CSS in the deck.

```css
:root{
  --ink:#F5F5F7; --bg:#000000; --black:#000000;
  --deep:#0A0A0A;
  --blue:#2997FF; --cyan:#2997FF;      /* the single permitted accent — used once (OMT/close) */
  --gold:#F5F5F7; --amber:#F5F5F7;     /* fold unused accents to white — stay monochrome */
  --mono:"SF Pro Display","SF Pro Text",-apple-system,"Inter Tight",Arial,sans-serif;
  --p0:#000; --p1:#0a0a0a; --p2:#000; --p3:#0a0a0a; --p4:#000; --p5:#0a0a0a;
}
```

Then in the deck's `<style>`: hide the animated swirl (`#bg`), motes, and confetti; set text-only
slides to the black depth radial; give photo slides a full-bleed `background-size:cover` layer
with a **directional** scrim `::after`; add the `.lnum`/`.slam` lesson-reveal keyframes; add the
`.tencount .bignum` giant numeral (font ~58cqmin, tabular-nums) over a Ken-Burns hero; build the
`.recap` two-column (image + numbered list) slide; and build the `.close` QR block. Restyle the
glass chrome dark to match. (See the worked deck: a "Ten things I learned working at Apple"
keynote — story arc, a giant "10" over Apple Park, ten photo lessons, a recap, and a QR to a
personal site.)

Fonts: SF Pro is a system face on Apple platforms (`-apple-system`); stack `Inter Tight` after it
as a cross-platform fallback. No web-font request is strictly required.

## Photography notes (Cupertino-specific)

- **Every image earns its place.** Use real photos from the actual chapter — the more personal,
  the better the talk lands. Placeholder gradients read as unfinished here (unlike Obsidian, where
  black *is* the design).
- **Compose for the text side.** Shoot/crop so the subject sits opposite the caption; the
  directional scrim darkens only the text side and leaves the subject bright.
- **One anchoring image** (a logo on stone, the building, a portrait) works well on the count
  reveal and the recap, tying the arc together.
- Optimize for web (see the publish checklist): compressed JP/WebP, and if there's a video lesson,
  gate it behind the preloader and control playback per active slide.

## CJK note

SF Pro / Inter Tight have no CJK glyphs — stack `Noto Sans SC` after them in every font role.
Drop the negative display tracking to 0 on CJK runs, skip uppercase transforms on the kicker,
keep numerals Latin (the count and lesson numbers stay Arabic), and open body line-height to
~1.7. The photography, the counted structure, and the single blue accent are glyph-agnostic and
carry unchanged.

## Do / Don't

**Do:** fill the black with real, personal photography under a directional scrim; make the deck a
literal countdown (giant N → lessons 1…N → recap); give each lesson the blur-in number + clip-wipe
headline; keep everything monochrome SF Pro 600; spend your one blue word on the "one more thing";
close on a QR to your world; prefer curly quotes.

**Don't:** use placeholder/stock gradients where a real photo belongs; color more than one word;
alternate light slides; add glass, cards, or gradient text; bounce/scale-punch the reveals; skip
the recap (the "all of it, together" beat is what makes a lessons talk land). The instant it stops
being a personal photo countdown, it's just Obsidian — reach for Obsidian directly instead.
