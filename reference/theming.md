# Theming

The deck is brand-neutral by default (indigo/violet, Inter font). All brand-specific
styling lives in **one place**: the `<style id="theme">` block in `<head>`, plus the
font `<link>` above it. Reskinning is a single-block edit — nothing else references
brand colors directly.

## The three things to change

1. **Font** — swap the Google Fonts `<link>` and set `--mono` to the new family.
2. **Color tokens** — the `:root` variables below.
3. **Logos (optional)** — the title slide `.brandlock` and corner `.brandmark` are
   text wordmarks by default; drop in `<img>`s to use real logo art.

## The tokens

```css
:root{
  --ink:#fff;     /* primary text — keep light on the dark stage */
  --bg:#10121C;   /* stage base color */
  --black:#0B0C12;/* deepest shade (gradients, mock.good) */
  --blue:#6D5EF6; /* BRAND PRIMARY — bars, brandmark accent, finder */
  --cyan:#8B7CFF; /* BRAND ACCENT — highlights, .wink, chart line, badges */
  --deep:#4B3FC4; /* BRAND DEEP — the dark end of every gradient */
  --gold:#FFC857; /* POP accent — deltas, gd numbers, confetti */
  --amber:#F2960B;
  --mono:"Inter","Helvetica Neue",Arial,sans-serif;
  /* background swirl palette — 6 tones the animated gradient cycles through */
  --p0:#2a2360; --p1:#1f2a66; --p2:#4B3FC4; --p3:#241c52; --p4:#2a2360; --p5:#1f2a66;
}
```

Rules of thumb:
- `--cyan` is the *bright* brand color (highlights, accents); `--blue` the *primary*;
  `--deep` the *dark* gradient end. They should read as one family, light→dark.
- `--gold` is the one contrasting pop — use sparingly.
- The `--p0…--p5` swirl palette should be muted, desaturated versions of the brand so
  the background never competes with the content. The title-hero glow and a few
  `rgba(…)` shadow/glow values are hard-coded to match the default theme — if you
  shift hue dramatically, grep the `<style>` for `rgba(139,124,255` (cyan glow) and
  `rgba(109,94,246` (blue glow) and nudge them, or leave them (they read as ambient).

## Worked example — LunaTechs theme

This reproduces the original Speaker Playbook palette (electric blue + gold, Poppins):

```html
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style id="theme">
  :root{
    --ink:#fff; --bg:#0B1B30; --black:#14161C;
    --blue:#1090E0; --cyan:#00B0F0; --deep:#0050B0;
    --gold:#FCD830; --amber:#F2960B;
    --mono:"Poppins","Helvetica Neue",Arial,sans-serif;
    --p0:#0e3b66; --p1:#0a5a86; --p2:#0050B0; --p3:#0a2f52; --p4:#0e3b66; --p5:#0a5a86;
  }
</style>
```

For full LunaTechs fidelity also:
- Title slide: replace `.brandlock`'s `<span class="lockwm">` with
  `<img src="assets/logo-mascot.png" class="title-mascot"><img src="assets/wordmark-2tone.png" class="title-wm">`.
- Corner: replace `.brandmark`'s `<span class="wm">` with
  `<img src="assets/head.png" alt=""><span class="wm">luna<b>techs</b></span>`.
- Copy the logo assets next to the deck under `assets/`.
- LunaTechs glow values in the original are `rgba(0,176,240,…)` (cyan) and
  `rgba(16,144,224,…)` (blue) — optional fidelity tweak.

## Light theme?
The deck assumes light text on a dark stage. A light deck is possible but means
flipping `--ink` to a dark color and re-tuning every `rgba(255,255,255,…)` surface
fill — a bigger job than a token swap. Prefer staying dark.
