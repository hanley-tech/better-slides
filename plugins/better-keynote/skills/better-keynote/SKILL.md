---
name: better-keynote
description: Build a presentation that performs — a self-contained HTML keynote with big type, timed reveals, sound design, and a "one more thing" finale, plus a built-in methodology for what to say. Use when the user wants a talk, keynote, pitch, or conference deck that should feel like an experience, not a document — or wants to upgrade an existing deck into a performance. Theatrics of Keynote, openness of the web.
---

# better-keynote

Build presentations as ONE portable, self-contained `.html` file that **performs**: fixed
1920×1080 stage scaled to any screen, big type, timed reveals, optional sound design, and a
"one more thing" finale. No build step, no framework, one fonts request.

This skill carries a point of view. It does not just lay out slides — it applies a
**speaking methodology** (find the one idea, build a hero slide, stick the landing) and a
**performance grammar** (motion + sound that serve the message). Design without a thesis is
slop; this skill refuses it.

## Core principles

1. **A deck is a performance.** Optimize for what the room feels, not for completeness.
2. **One idea, one breath.** If the talk's thesis won't fit in a breath, it isn't one idea
   yet. Every deck distills to a single big idea ([playbook](playbook/speaker-playbook.md)).
3. **Huge type, few words, one visual.** If a line wouldn't be readable on a phone at arm's
   length, it's too small.
4. **Build the hero slide.** Every deck needs 1–2 screenshot-worthy visuals that spread the
   idea without the speaker present.
5. **Motion and sound are message, not decoration.** Every reveal and every cue earns its
   place by landing a beat. Never animate for the sake of motion.
6. **Fixed 16:9 stage (NON-NEGOTIABLE).** Author at 1920×1080; scale the whole stage to the
   viewport; letterbox/pillarbox. Never reflow slide content for phones.
7. **Zero dependencies.** Single HTML file (GSAP via one CDN `<script>` is the only allowed
   exception, and the deck degrades gracefully without it). All CSS/JS inline.

## The two layers

better-keynote always builds **both**:

- **The "what to say" layer** — the [Speaker Playbook](playbook/speaker-playbook.md). Read
  it during content work. It governs structure: distill, lead with story, one number,
  hero slide, time discipline, a landing that makes them act tonight.
- **The "how it lands" layer** — the engine + performance style + motion + (optional)
  sound. Read `engine/`, `reference/`, and the chosen `performance-styles/*/design.md`
  during generation.

A deck that nails layout but has no thesis fails. A deck with a thesis and flat delivery
fails. Build both.

---

## Phase 0: Detect mode

- **Mode A — New keynote.** Build from scratch. → Phase 1.
- **Mode B — Upgrade.** Turn an existing deck (HTML, notes, or a flat slide export) into a
  performance. Read it, find the one idea it's burying, then re-author on the engine with
  the motion/sound layer. → Phase 1 (apply the playbook to existing content).
- **Mode C — Enhance.** Add a performance treatment (sound, an `omt` finale, a hero slide)
  to a deck already on this engine. Skip to Phase 3, edit in place.

---

## Phase 1: Content & method

Ask these together (use the structured-question UI if available, else one numbered message):

1. **Purpose** — Conference talk / Pitch / Teaching / Internal / Launch.
2. **Length** — Lightning 5 min / Talk 10 min / Keynote 20–25 min.
3. **Register** — *Speaker-led* (you'll narrate; few words per slide, more slides) vs.
   *Reading* (self-explanatory; denser). When mixed, default speaker-led for live talks.
4. **Sound** — Full sound design (applause/swoosh/chime/`omt`) / Subtle cues only / Silent.
5. **Content** — All ready / Rough notes / Topic only.

**Then read [`playbook/speaker-playbook.md`](playbook/speaker-playbook.md) and apply it to
the content** before touching design:

- Distill everything to **one idea** statable in one breath. Confirm it with the user.
- Pick the 2–3 points that survive. Cut the rest.
- Identify the **hero slide** (the one number / chart / before→after worth photographing).
- Draft the **landing**: the one thing the audience should do tonight.
- Map the arc: hook → story → idea → proof (hero) → land → don't-vanish.

Confirm the outline and the one-idea statement before generating.

### Images
If the user provides images, scan and evaluate each (what it shows, usable or not, dominant
colors), then design the outline *around* the strong ones. Decks work with zero images via
pure-CSS visuals — that is a first-class path, not a fallback.

---

## Phase 2: Style discovery

**Show, don't tell.** Don't ask the user to describe a look. Generate live preview slides
and let them point.

1. Read [`performance-styles/selection-index.json`](performance-styles/selection-index.json)
   (compact metadata only — do not bulk-read `design.md` files).
2. Match the brief's purpose/mood/register against each style's metadata.
3. Read only the shortlisted candidates' `preview.md` cards.
4. Generate **3 live single-slide previews** (real title slide for this talk, in each
   style): typically 1 restrained, 1 expressive, 1 wildcard. Each must look like a genuine
   first slide — never render style names, "Option A", file paths, or brief notes on the
   slide itself.
5. Save to `.better-keynote/previews/` and open them. Ask which they prefer (or "mix").

Only after the user picks does the full `design.md` for that one style get read.

---

## Phase 3: Generate the performance

Before generating, read:

- [`engine/template.html`](engine/template.html) — base deck; **copy it, never edit in
  place**. It carries the stage, nav, glass menu, progress, confetti, and the layout kit.
- [`engine/stage.css`](engine/stage.css) — mandatory fixed-stage CSS (already inlined in the
  template; include in full in any deck built from scratch).
- [`reference/layouts.md`](reference/layouts.md) — slide recipes.
- [`reference/motion.md`](reference/motion.md) — timed reveals, staggered builds, the `omt`
  finale. This is the performance layer.
- [`reference/audio.md`](reference/audio.md) — **only if sound was chosen.** Web Audio
  wiring, cue palette, and graceful-silence fallback.
- The chosen [`performance-styles/*/design.md`](performance-styles/) — the full design
  system. Preserve its fonts, palette, motion grammar, and sound palette.
- [`reference/theming.md`](reference/theming.md) — the single `<style id="theme">` token
  block to reskin.

Build steps:

1. Copy `engine/template.html` to `<dest>/index.html`.
2. Fill the `{{PLACEHOLDERS}}` (title, subtitle, brand, canonical URL, OG image).
3. Apply the chosen style's theme tokens + fonts (one `<style id="theme">` block).
4. Author the slides from the Phase-1 outline using `layouts.md` recipes. First slide stays
   `active`. The menu, progress, deep links, and confetti recompute automatically.
5. **Apply the performance layer** (`motion.md`): pace the reveals to the narration — one
   beat per click. Reserve `.slam`/`omt` for the hero and the finale, not every slide.
6. **If sound was chosen** (`audio.md`): wire the cue palette from the style, gate all audio
   behind the first user gesture (browsers block autoplay), and make every cue optional —
   the deck must be fully usable muted. Never autoplay music without a visible toggle.
7. **Apply the playbook end-state:** ensure there is a hero slide, a real CTA landing (not
   "thanks"), and a don't-vanish slide (QR / contact).

### Hard invariants (every slide, every deck)

- Fixed 1920×1080 stage scaled as one unit. No responsive reflow of slide content.
- Slide visibility via `.active` (opacity/visibility), never `display:none` toggling that a
  later layout rule can override.
- `prefers-reduced-motion` disables motion (mirror every entrance animation there).
- Sound is opt-in, gesture-gated, and never required to follow the talk.
- Never negate CSS functions directly (`-clamp(...)`); use `calc(-1 * clamp(...))`.
- No generic "AI slop": no Inter/Roboto/system display fonts, no purple-gradient-on-white,
  no identical centered card grids. Each style commits to a distinct thesis.

### Verify
Open in a browser (or Playwright): step through with arrow keys; confirm reveals fire one
beat at a time; toggle sound on/off; resize (stays centered + letterboxed); print-preview
for the PDF layout. Check no text overflows and no panels overlap at 1280×720 and one phone
viewport.

---

## Phase 4: Perform & share (optional)

Ask if they want to share. Offer:

- **Present** — `open index.html`; remind them: arrows/space/swipe to advance, `f`
  fullscreen, `p` print-to-PDF, the sound toggle, and that `omt`/confetti fire on cue.
- **Deploy** — a static host (e.g. Vercel free tier); bundle any `assets/` (audio, images)
  alongside the HTML so relative paths resolve.
- **PDF** — screenshot each `.slide` at 1920×1080 and combine. Note that motion and sound
  are not preserved — the PDF is the final visual state.

---

## Supporting files

| File | Purpose | When |
| --- | --- | --- |
| [`playbook/speaker-playbook.md`](playbook/speaker-playbook.md) | The methodology — what to say | Phase 1 |
| [`performance-styles/selection-index.json`](performance-styles/selection-index.json) | Compact style metadata | Phase 2 |
| `performance-styles/*/preview.md` | Title-slide preview cards | Phase 2 (shortlist) |
| `performance-styles/*/design.md` | Full design system (one chosen style) | Phase 3 |
| [`engine/template.html`](engine/template.html) | Base deck — copy, don't edit | Phase 3 |
| [`engine/stage.css`](engine/stage.css) | Mandatory fixed-stage CSS | Phase 3 |
| [`reference/layouts.md`](reference/layouts.md) | Slide recipes | Phase 3 |
| [`reference/motion.md`](reference/motion.md) | Timed reveals / `omt` finale | Phase 3 |
| [`reference/audio.md`](reference/audio.md) | Sound design + Web Audio | Phase 3 (if sound) |
| [`reference/theming.md`](reference/theming.md) | Token swap | Phase 3 |
| [`demo/index.html`](demo/index.html) | Flagship: the "Be Unforgettable" talk | Reference example |
