# Motion — the performance layer

The engine ships a CSS-only entrance system that works with zero JS tuning. This file adds
the **performance grammar**: how to pace reveals to narration, build a slide one beat at a
time, and stage a "one more thing" (`omt`) finale. Read this in Phase 3.

**Rule above all rules:** motion is message. Every reveal lands a beat the speaker is saying
out loud. If a movement doesn't correspond to a spoken point, cut it. Reserve the big moves
(`.slam`, `omt`) for the hero slide and the finale — overuse kills them.

Always mirror every entrance in `@media (prefers-reduced-motion: reduce)` (show the final
state instantly) and in `@media print` (final state, one slide per page).

---

## Tier 1 — CSS entrances (default, no GSAP)

Built into the engine. Use these for ~90% of slides.

| Class | Effect | Use for |
| --- | --- | --- |
| `.pop` | fade + rise on slide entry; **siblings auto-stagger** (1st→5th add 0.08s) | the workhorse — kicker, headline, sub, in DOM order |
| `.slam` | scale-in with a punch | one hero word / the single biggest statement on a slide |
| `.jit` | gentle infinite wiggle | a word you want to feel alive |

Order your DOM the way you'll speak: kicker first (`.pop`), headline second (`.pop` or
`.slam`), supporting line third (`.pop`). The stagger then matches your cadence for free.

## Tier 2 — click-paced builds (optional GSAP)

When a slide has multiple beats you reveal *as you talk* (not all at once on entry), add a
build. Load GSAP once via CDN and guard everything so the deck still works if it fails:

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
```

Mark beats with a data attribute and reveal them on each Right/Space press:

```html
<section class="slide" data-nav="Proof">
  <h2 class="pop">Three things broke.</h2>
  <ul>
    <li data-beat>The cache.</li>
    <li data-beat>The queue.</li>
    <li data-beat>My pager. At 2am.</li>
  </ul>
</section>
```

```js
// Intercept advance: reveal the next [data-beat] on this slide before changing slides.
function nextBeat(slide){
  const beats = slide.querySelectorAll('[data-beat]:not(.shown)');
  if (!beats.length) return false;                 // no beats left → let nav advance
  const el = beats[0]; el.classList.add('shown');
  if (window.gsap && !reducedMotion) {
    gsap.fromTo(el, {autoAlpha:0, y:24}, {autoAlpha:1, y:0, duration:.5, ease:'power3.out'});
  } else { el.style.opacity = 1; el.style.transform = 'none'; }  // graceful fallback
  return true;                                     // consumed the press
}
```

`[data-beat]` starts at `opacity:0` in CSS; `prefers-reduced-motion` and `@media print`
force it visible. Wire `nextBeat(currentSlide)` into the deck's existing advance handler so
a press reveals the next beat first, then advances when none remain.

## Tier 3 — the `omt` ("one more thing") finale

The signature move. After the audience thinks the talk is over, one more beat lands the
idea for good. This is the most expensive moment in the deck — earn it, use it once.

Anatomy:

1. **A held pause** — a near-empty slide ("That's the talk." / a logo), 1–2 seconds of
   stillness. Silence is part of the choreography.
2. **The turn** — a kicker fades up: `one more thing`.
3. **The payoff** — the single line that recontextualizes everything, `.slam` scale-in,
   optionally with a sound cue (see `audio.md`: `omt`/`chime`) and the live waveform.
4. **The release** — confetti / applause bed on the final slide (the engine fires confetti
   on the last slide automatically).

```js
// Fire on entering the omt slide. Sequenced, not simultaneous — the pause is the point.
function playOMT(slide){
  if (!window.gsap || reducedMotion){ slide.querySelectorAll('[data-omt]').forEach(e=>e.style.opacity=1); return; }
  const tl = gsap.timeline();
  tl.to(slide.querySelector('.omt-kicker'), {autoAlpha:1, duration:.6, delay:1.2})
    .fromTo(slide.querySelector('.omt-line'), {autoAlpha:0, scale:.92}, {autoAlpha:1, scale:1, duration:.7, ease:'back.out(1.6)'}, '+=0.4')
    .add(()=> window.beat && window.beat('omt'), '<');   // optional sync'd sound cue
}
```

Keep the `omt` line to one breath. If it needs a second sentence, it isn't the `omt`.

## Pacing checklist

- One beat per click. Never reveal the punchline before you say it.
- The hero slide gets the strongest single entrance in the deck.
- Background motion (the engine's ambient gradient/motes) is ambient — never competes with
  a reveal.
- Total motion budget per slide: one *featured* move + quiet supporting `.pop`s. More than
  that reads as a screensaver.
- Test the whole deck with `prefers-reduced-motion: reduce` — it must still tell the story.
