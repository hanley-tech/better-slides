# Layout recipes

Every slide is one `<section class="slide" data-nav="Label">…</section>` inside `#deck`.
The first slide also carries `active`. The menu label comes from `data-nav` (falls
back to the `.badge`, then the heading). Combine classes freely; they're all
content-agnostic and theme-driven.

## Core building blocks (use on almost every slide)

| Class | What it does |
|---|---|
| `.badge` | small uppercase kicker above the headline |
| `h1` / `h2` | giant display headline (`h2` is the slide workhorse) |
| `.sub` | supporting sentence under the headline (capped at ~24ch by default) |
| `.pop` | fades+rises in on slide entry; siblings auto-stagger (1st→5th) |
| `.slam` | scales in with a punch (use for one hero word/headline) |
| `.hl` | gradient highlight pill behind inline text |
| `.wink` | tilted tinted highlight (lighter than `.hl`) |
| `.jit` | gentle infinite wiggle on a word |
| `.strike` | struck-through (for "not this") |
| `.gold` | accent-color text |
| `.wave` | waving-hand animation (wrap an emoji) |

> **Animation order:** direct children with `.pop` stagger by DOM order
> (`:nth-child` 2–5 add 0.08s each). Put the kicker first, headline second, etc.

## Slide layouts

### `title-hero` — the opening showstopper
`<section class="slide active hasbg title-hero">` with a `.bgimg` (pure-CSS glow by
default), a `.brandlock` (logo or wordmark), an `h1` using `.t-sm` + `.t-mega`, and a
`.title-foot`. Use `.glow` on the hero word for the neon halo.

### Statement — the workhorse
Just `.badge` + `h2` + `.sub`. No extra container. Most slides should be this.

### `funnel3` — many → one
A 3-tier narrowing stack (`.tier.t1` widest/faintest → `.t3` narrowest/brightest),
separated by `.fdown` arrows. Each tier has a `.tl` mini-label. For "drop the noise,
keep the signal."

### `funnel` — converge crossed-out options into one
A wrap of struck-through `.many span` chips, a `.fdown` arrow, then a single bright
`.one` pill (optionally with a `.bignum`). Alternative to `funnel3`.

### `split` — text left, tall photo right
`<section class="slide split">`. Body text flows in the left ~54%; a `.photo-wrap >
.photo-card > img` (3:4) sits right. Use `.ph` on the card for an image-free
placeholder. Pairs well with a `.swap` block.

### `swap` — before → after line
Stacked `.bad` (struck) → `.arr` → `.good`. Great inside `split` or alone for
"don't say X, say Y."

### `bca` — before/after mockups (eye candy)
Two 16:9 `.mock` panels side by side: `.mock.bad` (light, a wall of bullets) vs
`.mock.good` (dark, one huge `.big` number + `.cap2`). The single strongest
"show, don't tell" slide.

### `herowrap` / `herochart` — the money slide
An animated SVG line chart (`.hc-line` draws on, `.hc-area` + `.hc-dot` fade in) next
to `.hmeta` copy. Edit the SVG `<path d>`, the `.hc-stat`/`.hc-sub` labels, and the
`.hc-x` axis ends. This is the "they'll photograph it" slide.

### `cards` — infographic grid
`<div class="cards c3 big">` (or `c2`) of `.card`s, each with `.ic` (emoji/icon),
`.ct` (title), `.cd` (detail). `.big` centers them with large icons. Cards
auto-stagger on entry.

### `chips` — a set of tags
A flex wrap of `.chip` pills. Good for "we support: A · B · C". Auto-stagger.

### `bars` — compare two quantities
Horizontal bars: `.barrow > .lab + .track > .fillb`. `.f1`/`.f2` set the width %
(edit inline `width` to your data). `.plus` for a gold delta. Bars grow on entry.

### `clock` — time blocks
`.clock > .c-a` (wide, gradient) + `.c-b` (narrow, outline). Stack two for two rows.
Originally "talk length + Q&A"; reuse for any big-number split.

### `cutwrap` — diverge/cut SVG diagram
An animated SVG: a chaotic `.cut-ramble` path gets cut by a `.cut-line` into a clean
`.cut-answer` arrow. Reuse for any "messy → crisp" idea.

### `actcard` — the call-to-action close
A big `.actbtn` (looks like a play button) + a row of numbered `.actstep`s. End on
"do this one thing," not "thanks."

### `qrwrap` — don't-vanish QR
A `.qr` box (auto-rendered placeholder QR via JS) + `.qmeta` copy. **Replace the
placeholder with a real QR** for production (see SKILL.md). The `#qr` SVG is mock-only.

### `photo` — full-bleed closer
`<section class="slide photo">` with a `.pic` (set `background-image` inline) and a
bottom-left `.cap`. The last slide auto-fires confetti.

## Backgrounds per slide
- Default: animated blurred gradient (`#bg`) whose tones cycle through the theme's
  `--p0…--p5` palette, one triad per slide index.
- `hasbg` + `.bgimg` with an inline `background-image` = full photo background with a
  built-in legibility scrim.

## Adding / removing slides
Just add or delete `<section class="slide">` blocks. The progress bar, counter, menu,
deep-link hashes (`#3` = slide 3), and confetti-on-last all recompute automatically —
no JS edits needed.
