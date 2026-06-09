#!/usr/bin/env bash
# better-slides — export a deck to PDF.
#
#   bash scripts/export-pdf.sh <path-to-deck.html> [output.pdf]
#
# How it works: the deck's @media print CSS already lays every slide out
# one-per-page at 1920×1080, so we drive headless Chromium (via Playwright)
# through the print pipeline once and get a multi-page PDF — no per-slide
# screenshots, no image stitching.
#
# Notes for the user:
# - First run downloads Chromium (~100MB, one time). Subsequent runs are fast.
# - Motion and sound are not preserved — the PDF is each slide's final state.
# - The fastest no-install alternative is pressing `p` in the deck and using
#   the browser's own "Save as PDF".
set -euo pipefail

DECK="${1:?usage: export-pdf.sh <deck.html> [out.pdf]}"
DECK="$(cd "$(dirname "$DECK")" && pwd)/$(basename "$DECK")"
OUT="${2:-${DECK%.html}.pdf}"
[ -f "$DECK" ] || { echo "✗ no such file: $DECK" >&2; exit 1; }

command -v node >/dev/null || { echo "✗ Node.js is required (brew install node)" >&2; exit 1; }

# Workspace with a local playwright install (kept across runs for speed)
WORK="${TMPDIR:-/tmp}/better-slides-pdf"
mkdir -p "$WORK"
cd "$WORK"
[ -d node_modules/playwright ] || {
  echo "· installing Playwright (first run only)…"
  npm init -y >/dev/null 2>&1
  npm install --no-fund --no-audit playwright >/dev/null
  npx playwright install chromium >/dev/null
}

# Serve the deck's directory so relative assets (audio, images, fonts) resolve.
DIR="$(dirname "$DECK")"; FILE="$(basename "$DECK")"
PORT=8917
(python3 -m http.server "$PORT" --directory "$DIR" >/dev/null 2>&1 &)
SRV=$!
trap 'kill $SRV 2>/dev/null || true' EXIT
sleep 1

node - "$FILE" "$OUT" "$PORT" <<'EOF'
const { chromium } = require('playwright');
(async () => {
  const [file, out, port] = process.argv.slice(2);
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });
  await page.goto(`http://127.0.0.1:${port}/${file}`, { waitUntil: 'networkidle' });
  await page.waitForTimeout(2500);                     // let fonts + entrances settle
  await page.emulateMedia({ media: 'print' });
  await page.pdf({ path: out, width: '1920px', height: '1080px',
                   printBackground: true, pageRanges: '' });
  await browser.close();
  console.log(`✓ wrote ${out}`);
})().catch(e => { console.error('✗', e.message); process.exit(1); });
EOF

open "$OUT" 2>/dev/null || true
