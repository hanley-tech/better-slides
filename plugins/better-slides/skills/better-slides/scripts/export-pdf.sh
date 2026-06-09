#!/usr/bin/env bash
# export-pdf.sh — export a better-slides deck to PDF
#
# Usage:
#   bash scripts/export-pdf.sh <path-to-deck.html> [output.pdf] [--compact]
#
# Examples:
#   bash scripts/export-pdf.sh ./my-talk/index.html
#   bash scripts/export-pdf.sh ./deck.html ./deck.pdf
#   bash scripts/export-pdf.sh ./deck.html --compact      # ~50-70% smaller file
#
# What this does:
#   1. Serves the deck's folder over HTTP (fonts + relative assets need it)
#   2. Opens it in headless Chromium at 1920×1080 (1280×720 with --compact)
#   3. Steps through every slide with the deck's own navigation, waits for
#      fonts and entrance animations, and screenshots each one
#   4. Assembles the screenshots into a single landscape PDF and opens it
#
# Motion and sound are not preserved — each page is the slide's final state.
# First run installs Playwright + Chromium (~150MB, one time); later runs are fast.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; BOLD='\033[1m'; NC='\033[0m'
info() { echo -e "${CYAN}·${NC} $*"; }
ok()   { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
err()  { echo -e "${RED}✗${NC} $*" >&2; }

# ─── flags & input ─────────────────────────────────────────
VP_W=1920; VP_H=1080
POSITIONAL=()
for arg in "$@"; do
  case $arg in
    --compact) VP_W=1280; VP_H=720 ;;
    *) POSITIONAL+=("$arg") ;;
  esac
done
set -- "${POSITIONAL[@]+"${POSITIONAL[@]}"}"

[[ $# -ge 1 ]] || { err "usage: export-pdf.sh <deck.html> [out.pdf] [--compact]"; exit 1; }
DECK="$1"
[[ -f "$DECK" ]] || { err "no such file: $DECK"; exit 1; }
DECK="$(cd "$(dirname "$DECK")" && pwd)/$(basename "$DECK")"
OUT="${2:-${DECK%.html}.pdf}"
mkdir -p "$(dirname "$OUT")"
OUT="$(cd "$(dirname "$OUT")" && pwd)/$(basename "$OUT")"

command -v npx >/dev/null || {
  err "Node.js is required but not installed."
  err "  macOS: brew install node   ·   or https://nodejs.org"
  exit 1
}

# ─── playwright workspace (kept across runs so only the 1st is slow) ───
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

[[ "$VP_W" == "1280" ]] && info "compact mode: 1280×720 (smaller file)"
info "exporting $(basename "$DECK") …"

NODE_PATH="$WORK/node_modules" node - "$DECK" "$OUT" "$VP_W" "$VP_H" <<'EOF'
const { chromium } = require('playwright');
const http = require('http'); const fs = require('fs'); const path = require('path');

const [DECK, OUT, W, H] = process.argv.slice(2);
const DIR = path.dirname(DECK), FILE = path.basename(DECK);
const MIME = { '.html':'text/html','.css':'text/css','.js':'application/javascript',
  '.png':'image/png','.jpg':'image/jpeg','.jpeg':'image/jpeg','.gif':'image/gif',
  '.svg':'image/svg+xml','.webp':'image/webp','.mp3':'audio/mpeg','.wav':'audio/wav',
  '.woff':'font/woff','.woff2':'font/woff2','.ttf':'font/ttf' };

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
  const page = await browser.newPage({ viewport: { width: +W, height: +H } });
  await page.goto(`http://127.0.0.1:${port}/`, { waitUntil: 'networkidle' });
  await page.evaluate(() => document.fonts.ready);
  await page.waitForTimeout(1500);                       // first-slide entrances

  const total = await page.evaluate(() => document.querySelectorAll('.slide').length);
  if (!total) { console.error('  ERROR: no .slide elements found — is this a better-slides deck?');
                await browser.close(); server.close(); process.exit(1); }
  console.log(`  ${total} slides`);

  const shots = [];
  for (let i = 0; i < total; i++) {
    await page.evaluate(n => {
      // drive the deck's own navigation when present, else toggle .active directly
      if (typeof show === 'function') show(n);
      else document.querySelectorAll('.slide').forEach((s, x) => s.classList.toggle('active', x === n));
      // force every staged entrance to its final state for the capture
      const cur = document.querySelectorAll('.slide')[n];
      cur.querySelectorAll('.pop,.slam,[data-beat],.omt-kicker,.omt-line').forEach(el => {
        el.style.animation = 'none'; el.style.transition = 'none';
        el.style.opacity = '1'; el.style.visibility = 'visible'; el.style.transform = 'none';
        el.classList.add('shown');
      });
    }, i);
    await page.waitForTimeout(i === total - 1 ? 900 : 450);  // let charts draw; skip most confetti
    const f = path.join(require('os').tmpdir(), `bs-slide-${String(i+1).padStart(3,'0')}.png`);
    await page.screenshot({ path: f });
    shots.push(f);
    process.stdout.write(`  captured ${i+1}/${total}\r`);
  }
  console.log('');
  await browser.close(); server.close();

  // assemble: one full-bleed image per landscape page
  const b2 = await chromium.launch();
  const p2 = await b2.newPage();
  const body = shots.map(f =>
    `<div class="pg"><img src="data:image/png;base64,${fs.readFileSync(f).toString('base64')}"></div>`).join('');
  await p2.setContent(`<!DOCTYPE html><style>
    *{margin:0;padding:0} @page{size:${W}px ${H}px;margin:0}
    .pg{width:${W}px;height:${H}px;page-break-after:always;overflow:hidden}
    .pg:last-child{page-break-after:auto} img{width:100%;height:100%;display:block}
  </style>${body}`, { waitUntil: 'load' });
  await p2.pdf({ path: OUT, width: `${W}px`, height: `${H}px`, printBackground: true,
                 margin: { top: 0, right: 0, bottom: 0, left: 0 } });
  await b2.close();
  shots.forEach(f => fs.unlinkSync(f));
  console.log(`  ✓ ${OUT}`);
})().catch(e => { console.error('  ✗', e.message); process.exit(1); });
EOF

SIZE=$(du -h "$OUT" | cut -f1 | xargs)
ok "PDF exported — $OUT ($SIZE)"
echo "  Works everywhere: email, Slack, Notion, print. Motion/sound become each slide's final state."
if [[ "$VP_W" == "1920" ]]; then
  echo "  Too big? Re-run with --compact (1280×720, ~50-70% smaller)."
fi
command -v open >/dev/null && open "$OUT" || { command -v xdg-open >/dev/null && xdg-open "$OUT" || true; }
