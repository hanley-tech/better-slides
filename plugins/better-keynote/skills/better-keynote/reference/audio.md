# Audio — sound design

Sound is optional, opt-in, gesture-gated, and **never required to follow the talk.** A
muted deck must be fully usable. Read this only if the user chose sound in Phase 1.

Done well, sound is the difference between a slideshow and a keynote: a swoosh on a reveal,
a chime on the hero number, an applause bed under the `omt`, a low pad under the close. Done
badly, it's a website that screams at you. The rules below keep it on the right side.

## Non-negotiables

1. **Autoplay is blocked by browsers.** Initialize/resume the `AudioContext` on the first
   user gesture (the first key/click/tap that starts the talk). Never assume audio plays on
   load.
2. **Always render a visible mute toggle** (the engine's glass menu is the place). Default
   music **off**; default cues **on but quiet** unless the user said "silent".
3. **Cues are accents, not a soundtrack.** Short (50–400ms), low gain (peak ~ -12 dBFS),
   tied to a beat. Never stack cues.
4. **Respect the room.** One ambient bed at most, duckable, looping seamlessly, with a fade
   in/out. No cue on every slide — reserve them for hero, `omt`, and the close.
5. **Graceful silence.** If `AudioContext` is unavailable or assets fail to load, the deck
   continues silently with no errors.

## Two ways to make sound

### A. Synthesized cues (zero asset files — preferred for portability)

Keeps the deck a single file. Generate cues with the Web Audio API:

```js
let actx;
function audio(){ return actx || (actx = new (window.AudioContext||window.webkitAudioContext)()); }
const muted = () => document.documentElement.classList.contains('muted');

function blip(freq=660, dur=0.12, type='sine', gain=0.18){
  if (muted()) return;
  const a = audio(), o = a.createOscillator(), g = a.createGain();
  o.type = type; o.frequency.value = freq;
  g.gain.setValueAtTime(0, a.currentTime);
  g.gain.linearRampToValueAtTime(gain, a.currentTime + 0.01);
  g.gain.exponentialRampToValueAtTime(0.0001, a.currentTime + dur);
  o.connect(g).connect(a.destination); o.start(); o.stop(a.currentTime + dur);
}

// A small cue palette mapped to beats:
const CUES = {
  swoosh: () => { /* fast downward sweep */ const a=audio(); if(muted())return;
    const o=a.createOscillator(),g=a.createGain(); o.type='sawtooth';
    o.frequency.setValueAtTime(900,a.currentTime); o.frequency.exponentialRampToValueAtTime(120,a.currentTime+0.25);
    g.gain.setValueAtTime(0.12,a.currentTime); g.gain.exponentialRampToValueAtTime(0.0001,a.currentTime+0.28);
    o.connect(g).connect(a.destination); o.start(); o.stop(a.currentTime+0.3); },
  chime:  () => { blip(880,0.5,'sine',0.16); blip(1320,0.6,'sine',0.10); },  // hero number
  tick:   () => blip(440,0.05,'square',0.06),                                 // beat reveal
  omt:    () => { blip(196,0.7,'sine',0.20); blip(294,0.8,'triangle',0.12); },// the turn
};
window.beat = name => (CUES[name]||(()=>{}))();   // motion.md calls window.beat('omt') etc.
```

### B. Recorded beds (when you want real applause / music)

Drop files in `assets/` next to the deck (and bundle them on deploy). Keep them small,
loop seamlessly, and fade — never hard-cut.

```js
function bed(src, {loop=true, gain=0.5, fade=1.2}={}){
  const el = new Audio(src); el.loop = loop; el.volume = 0;
  if (muted()) return el;
  el.play().catch(()=>{});                  // may reject until a gesture — that's fine
  const step = gain/(fade*60); (function up(){ if(el.volume<gain){ el.volume=Math.min(gain,el.volume+step); requestAnimationFrame(up);} })();
  return el;                                // keep the handle to fade out later
}
```

Typical beds (matching the LunaTechs / vidiot sound kit): a soft applause bed under the
`omt` release, a low music pad under the title and the close, a single "power-up" hit on the
hero number.

## The live waveform (signature visual)

A canvas behind the slide that reacts to whatever's playing — ties the audio to the visuals.
Use an `AnalyserNode` and draw on `requestAnimationFrame`; when nothing plays it rests as a
flat line. Keep it low-contrast (it's atmosphere, not a chart) and behind all content
(`z-index` below the slide, `pointer-events:none`). Disable under `prefers-reduced-motion`.

## Mapping cues to the talk

| Moment | Cue |
| --- | --- |
| Slide change | nothing (silence is fine) — or a faint `swoosh` only on section breaks |
| `[data-beat]` reveal | `tick`, very quiet, or nothing |
| Hero number lands | `chime` + (optional) power-up bed hit |
| `omt` turn | `omt` cue, then applause bed fades up |
| Final slide | confetti (engine) + applause bed peak, then fade |

If in doubt, use **less**. A keynote with three perfectly-placed cues beats one with thirty.
