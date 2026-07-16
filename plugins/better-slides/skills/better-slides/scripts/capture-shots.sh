#!/usr/bin/env bash
# capture-shots.sh — capture share cards and slide stills from a better-slides deck
#
# Usage:
#   bash scripts/capture-shots.sh <path-to-deck.html> [options]
#
# Options:
#   --og            write og.jpg (1280×720, slide 1) next to the deck   [default if no mode given]
#   --preview       write preview.jpg (1920×1080, slide 1) next to the deck
#   --slides 1,4,6  write shot-<n>.jpg for those slides into <deck-dir>/shots/
#   --all           every slide → <deck-dir>/shots/shot-<n>.jpg
#   --out DIR       override the output directory
#   --quality N     JPEG quality (default 90)
#
# Examples:
#   bash scripts/capture-shots.sh demo/noir/index.html --og
#   bash scripts/capture-shots.sh demo/noir/index.html --og --preview --slides 3,5
#
# Why this exists:
#   Every published deck needs an og.jpg captured from the *rendered* first slide
#   (see SKILL.md Phase 4). Doing that by hand is a navigate→wait→screenshot→crop
#   loop; this is that loop, deterministically.
#
# Entrance animations are forced to their final state before each capture, so a
# shot is the slide as the room sees it after the reveal — never mid-fade.
# First run installs Playwright + Chromium (~150MB, one time); later runs are fast.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${CYAN}·${NC} $*"; }
ok()   { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
err()  { echo -e "${RED}✗${NC} $*" >&2; }

# ─── flags & input ─────────────────────────────────────────
WANT_OG=0; WANT_PREVIEW=0; SLIDES=""; OUTDIR=""; QUALITY=90
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --og)      WANT_OG=1; shift ;;
    --preview) WANT_PREVIEW=1; shift ;;
    --all)     SLIDES="all"; shift ;;
    --slides)  SLIDES="${2:-}"; shift 2 ;;
    --out)     OUTDIR="${2:-}"; shift 2 ;;
    --quality) QUALITY="${2:-}"; shift 2 ;;
    *)         POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]+"${POSITIONAL[@]}"}"

[[ $# -ge 1 ]] || { err "usage: capture-shots.sh <deck.html> [--og] [--preview] [--slides 1,4] [--all]"; exit 1; }
DECK="$1"
[[ -f "$DECK" ]] || { err "no such file: $DECK"; exit 1; }
DECK="$(cd "$(dirname "$DECK")" && pwd)/$(basename "$DECK")"
DECKDIR="$(dirname "$DECK")"
[[ -n "$OUTDIR" ]] || OUTDIR="$DECKDIR"
mkdir -p "$OUTDIR"
OUTDIR="$(cd "$OUTDIR" && pwd)"

# default mode: the one everybody actually needs
if [[ $WANT_OG -eq 0 && $WANT_PREVIEW -eq 0 && -z "$SLIDES" ]]; then WANT_OG=1; fi

command -v npx >/dev/null || {
  err "Node.js is required but not installed."
  err "  macOS: brew install node   ·   or https://nodejs.org"
  exit 1
}

# ─── playwright workspace (shared with export-pdf.sh so the install is paid once) ───
WORK="${TMPDIR:-/tmp}/better-slides-export"
mkdir -p "$WORK"
if [[ ! -d "$WORK/node_modules/playwright" ]]; then
  info "installing Playwright + Chromium (first run only, ~150MB)…"
  ( cd "$WORK" \
    && printf '{ "name": "bs-export", "private": true }\n' > package.json \
    && npm install --no-fund --no-audit playwright >/dev/null \
    && npx playwright install chromium >/dev/null ) || {
      err "Playwright install failed. Try manually:"
      err "  cd $WORK && npm install playwright && npx playwright install chromium"
      exit 1
    }
fi

info "capturing from $(basename "$DECKDIR")/$(basename "$DECK") …"

NODE_PATH="$WORK/node_modules" node - "$DECK" "$OUTDIR" "$WANT_OG" "$WANT_PREVIEW" "$SLIDES" "$QUALITY" <<'EOF'
const { chromium } = require('playwright');
const http = require('http'); const fs = require('fs'); const path = require('path');

const [DECK, OUTDIR, WANT_OG, WANT_PREVIEW, SLIDES, QUALITY] = process.argv.slice(2);

// A deck that wedges the browser must fail loudly, not hang the caller forever.
const WATCHDOG = setTimeout(() => {
  console.error('  ✗ timed out after 180s — a slide likely wedged the page (runaway animation?)');
  process.exit(1);
}, 180000);
WATCHDOG.unref();
const DIR = path.dirname(DECK), FILE = path.basename(DECK);
const MIME = { '.html':'text/html','.css':'text/css','.js':'application/javascript',
  '.png':'image/png','.jpg':'image/jpeg','.jpeg':'image/jpeg','.gif':'image/gif',
  '.svg':'image/svg+xml','.webp':'image/webp','.mp3':'audio/mpeg','.wav':'audio/wav',
  '.mp4':'video/mp4','.woff':'font/woff','.woff2':'font/woff2','.ttf':'font/ttf' };

(async () => {
  // serve the deck folder so relative assets + Google Fonts resolve
  const server = http.createServer((req, res) => {
    const p = path.join(DIR, decodeURIComponent(req.url) === '/' ? FILE : decodeURIComponent(req.url));
    try { res.writeHead(200, {'Content-Type': MIME[path.extname(p).toLowerCase()] || 'application/octet-stream'});
          res.end(fs.readFileSync(p)); }
    catch { res.writeHead(404); res.end(); }
  });
  const port = await new Promise(r => server.listen(0, () => r(server.address().port)));

  const browser = await chromium.launch();

  // Capture at the stage's own 16:9 so the shot is the composition, never a
  // letterboxed viewport with black bars baked into the JPEG.
  const shoot = async (slideIdx, w, h, outPath) => {
    // Emulate reduced-motion: every deck must mirror its entrances to a final resting
    // state there (SKILL.md invariant), which is exactly what a still should show. It
    // also stops looping decorative animations (e.g. a word that breathes at scale 1.03)
    // from being frozen mid-cycle, where it can collide with neighbouring type.
    const page = await browser.newPage({ viewport: { width: w, height: h }, reducedMotion: 'reduce' });
    const missing = [];
    page.on('response', r => { if (r.status() >= 400) missing.push(`${r.status()} ${r.url()}`); });
    await page.goto(`http://127.0.0.1:${port}/`, { waitUntil: 'networkidle' });
    await page.evaluate(() => document.fonts.ready);
    await page.waitForTimeout(1200);

    const total = await page.evaluate(() => document.querySelectorAll('.slide').length);
    if (!total) throw new Error('no .slide elements found — is this a better-slides deck?');
    if (slideIdx >= total) throw new Error(`slide ${slideIdx + 1} does not exist (deck has ${total})`);

    await page.evaluate(n => {
      if (typeof show === 'function') show(n);
      else document.querySelectorAll('.slide').forEach((s, x) => s.classList.toggle('active', x === n));
      const cur = document.querySelectorAll('.slide')[n];
      cur.querySelectorAll('.pop,.slam,[data-beat],.omt-kicker,.omt-line').forEach(el => {
        el.style.animation = 'none'; el.style.transition = 'none';
        el.style.opacity = '1'; el.style.visibility = 'visible'; el.style.transform = 'none';
        el.classList.add('shown');
      });
      // freeze Ken Burns / looping backgrounds mid-frame rather than at t=0
      cur.querySelectorAll('video').forEach(v => { try { v.pause(); } catch {} });
    }, slideIdx);

    // GSAP-driven builds ignore the CSS overrides above: a slide's timeline is
    // constructed on entry and staggers in over seconds. Screenshotting now yields
    // a plausible-looking but WRONG frame (half the items still invisible).
    //
    // Do NOT do this by speeding up gsap.globalTimeline — that also accelerates the
    // deck's infinite ambient loops (motes, confetti), which spins up runaway work
    // and wedges the page. Instead finish each build tween explicitly and leave
    // repeating tweens alone.
    await page.waitForTimeout(300);   // let the slide's build get constructed
    const hasGsap = await page.evaluate(() => {
      if (!window.gsap) return false;
      // two passes: finishing a parent can reveal nested/delayed children
      for (let pass = 0; pass < 2; pass++) {
        gsap.globalTimeline.getChildren(true, true, true).forEach(t => {
          try {
            if (typeof t.repeat === 'function' && t.repeat() === -1) return;  // infinite: decorative
            t.progress(1, true);
          } catch {}
        });
      }
      return true;
    });
    await page.waitForTimeout(hasGsap ? 400 : 700);

    // Fail loudly rather than ship a half-built frame. Threshold is deliberately
    // near-zero: styles legitimately dim text for de-emphasis (struck-through words,
    // muted foot lines), and flagging those would train the reader to ignore this
    // warning. Only an element that is effectively invisible indicates a stalled build.
    const unbuilt = await page.evaluate(n => {
      const cur = document.querySelectorAll('.slide')[n];
      return [...cur.querySelectorAll('*')].filter(el => {
        if (!el.getClientRects().length) return false;
        const cs = getComputedStyle(el);
        return parseFloat(cs.opacity) < 0.15 && el.children.length === 0 && el.textContent.trim();
      }).map(el => (el.className || el.tagName) + ': ' + el.textContent.trim().slice(0, 30));
    }, slideIdx);

    // clip to the stage element itself — that IS the 1920×1080 composition
    const stage = await page.$('.stage') || await page.$('#stage');
    if (stage) await stage.screenshot({ path: outPath, type: 'jpeg', quality: +QUALITY });
    else await page.screenshot({ path: outPath, type: 'jpeg', quality: +QUALITY });

    await page.close();
    return { total, missing: [...new Set(missing)].filter(u => !/favicon/.test(u)), unbuilt };
  };

  let allMissing = [], allUnbuilt = [];
  const wrote = [];
  const note = (r, label) => {
    allMissing.push(...r.missing);
    if (r.unbuilt && r.unbuilt.length) allUnbuilt.push(`${label}: ${r.unbuilt.join(' | ')}`);
  };

  if (WANT_OG === '1') {
    const p = path.join(OUTDIR, 'og.jpg');
    note(await shoot(0, 1280, 720, p), 'og.jpg'); wrote.push(p);
  }
  if (WANT_PREVIEW === '1') {
    const p = path.join(OUTDIR, 'preview.jpg');
    note(await shoot(0, 1920, 1080, p), 'preview.jpg'); wrote.push(p);
  }
  if (SLIDES) {
    const shotsDir = path.join(OUTDIR, 'shots');
    fs.mkdirSync(shotsDir, { recursive: true });
    let idxs;
    if (SLIDES === 'all') {
      const r = await shoot(0, 1920, 1080, path.join(shotsDir, 'shot-1.jpg'));
      note(r, 'shot-1'); wrote.push(path.join(shotsDir, 'shot-1.jpg'));
      idxs = Array.from({ length: r.total - 1 }, (_, i) => i + 1);
    } else {
      idxs = SLIDES.split(',').map(s => parseInt(s.trim(), 10) - 1).filter(n => !isNaN(n) && n >= 0);
    }
    for (const i of idxs) {
      const p = path.join(shotsDir, `shot-${i + 1}.jpg`);
      note(await shoot(i, 1920, 1080, p), `shot-${i + 1}`); wrote.push(p);
    }
  }

  await browser.close(); server.close();

  for (const p of wrote) {
    fs.chmodSync(p, 0o644);   // image tools write 600; servers 403 those
    console.log(`  ✓ ${path.relative(process.cwd(), p)} (${Math.round(fs.statSync(p).size / 1024)}KB)`);
  }
  const uniq = [...new Set(allMissing)];
  if (uniq.length) {
    console.log('  ⚠ deck requested assets that 404ed:');
    uniq.forEach(u => console.log(`      ${u}`));
    process.exitCode = 2;
  }
  if (allUnbuilt.length) {
    console.log('  ⚠ elements still faded/invisible at capture — the shot may be mid-build:');
    allUnbuilt.forEach(u => console.log(`      ${u}`));
    process.exitCode = 2;
  }
})().catch(e => { console.error('  ✗', e.message); process.exit(1); });
EOF

STATUS=$?
if [[ $STATUS -eq 2 ]]; then
  warn "captured, but the deck references assets that failed to load (see above) — fix before publishing."
elif [[ $STATUS -eq 0 ]]; then
  ok "done — $OUTDIR"
  echo "  og.jpg is the social share card: og:image / twitter:image must point at its ABSOLUTE URL."
  echo "  Re-run whenever the title slide changes."
fi
exit $STATUS
