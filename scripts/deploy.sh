#!/usr/bin/env bash
# deploy.sh — deploy a better-slides deck to a live URL (Vercel, free tier)
#
# Usage:
#   bash scripts/deploy.sh <deck-folder-or-html>
#
# Examples:
#   bash scripts/deploy.sh ./my-talk/            # folder with index.html (best)
#   bash scripts/deploy.sh ./presentation.html   # single file (assets auto-bundled)
#
# What this does:
#   1. Checks for Node + the Vercel CLI (uses npx if not installed globally)
#   2. Walks you through Vercel login the first time
#   3. Bundles a single HTML file's referenced assets if needed
#   4. Deploys to a permanent URL that works on any device
#
# Re-running on the same deck updates the SAME url.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; BOLD='\033[1m'; NC='\033[0m'
info() { echo -e "${CYAN}·${NC} $*"; }
ok()   { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
err()  { echo -e "${RED}✗${NC} $*" >&2; }

[[ $# -ge 1 ]] || { err "usage: deploy.sh <deck-folder-or-html>"; exit 1; }
INPUT="$1"
CLEANUP=false

# ─── stage the deck ────────────────────────────────────────
if [[ -d "$INPUT" ]]; then
  [[ -f "$INPUT/index.html" ]] || { err "folder '$INPUT' has no index.html"; exit 1; }
  DEPLOY_DIR="$(cd "$INPUT" && pwd)"
  DECK_NAME="$(basename "$DEPLOY_DIR")"
elif [[ -f "$INPUT" && "$INPUT" == *.html ]]; then
  info "single HTML file — bundling its assets…"
  SRC_DIR="$(cd "$(dirname "$INPUT")" && pwd)"
  DECK_NAME="$(basename "$INPUT" .html)"
  STAGE="$(mktemp -d)"
  DEPLOY_DIR="$STAGE/$DECK_NAME"
  mkdir -p "$DEPLOY_DIR"
  cp "$INPUT" "$DEPLOY_DIR/index.html"
  CLEANUP=true
  # copy every local file the HTML references (src= / href= / url()), keeping paths
  grep -oE '(src|href|url\()["'"'"']?[^"'"'"'>)]+' "$INPUT" 2>/dev/null \
    | sed "s/^src=//; s/^href=//; s/^url(//; s/[\"']//g" \
    | grep -v '^http' | grep -v '^data:' | grep -v '^#' | grep -v '^/' \
    | sort -u | while IFS= read -r ref; do
        if [[ -e "$SRC_DIR/$ref" ]]; then
          mkdir -p "$DEPLOY_DIR/$(dirname "$ref")"
          cp -r "$SRC_DIR/$ref" "$DEPLOY_DIR/$(dirname "$ref")/"
        fi
      done
  # assets/ folder convention — copy it whole if present
  [[ -d "$SRC_DIR/assets" && ! -d "$DEPLOY_DIR/assets" ]] && cp -r "$SRC_DIR/assets" "$DEPLOY_DIR/assets"
else
  err "'$INPUT' is not an HTML file or a folder"; exit 1
fi

# sanitize the Vercel project name (it comes from the directory name)
SAFE_NAME=$(echo "$DECK_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._-]/-/g; s/--*/-/g; s/^-//; s/-$//' | cut -c1-100)
if [[ "$CLEANUP" == "true" && "$SAFE_NAME" != "$DECK_NAME" ]]; then
  mv "$DEPLOY_DIR" "$STAGE/$SAFE_NAME"; DEPLOY_DIR="$STAGE/$SAFE_NAME"
fi

# ─── vercel cli + login ────────────────────────────────────
command -v npx >/dev/null || {
  err "Node.js is required but not installed."
  err "  macOS: brew install node   ·   or https://nodejs.org"
  exit 1
}
if command -v vercel >/dev/null; then VC="vercel"; else VC="npx --yes vercel"; fi

if ! $VC whoami >/dev/null 2>&1; then
  warn "not logged in to Vercel (free account: https://vercel.com/signup — GitHub login is easiest)"
  info "starting interactive login…"
  $VC login || { err "login failed — run '$VC login' manually, then re-run this script";
                 [[ "$CLEANUP" == "true" ]] && rm -rf "$STAGE"; exit 1; }
fi
ok "logged in as $($VC whoami 2>/dev/null)"

# ─── deploy ────────────────────────────────────────────────
info "deploying '$SAFE_NAME' …"
OUTPUT=$($VC deploy "$DEPLOY_DIR" --yes --prod 2>&1) || {
  err "deploy failed:"; echo "$OUTPUT"
  [[ "$CLEANUP" == "true" ]] && rm -rf "$STAGE"; exit 1
}
URL=$(echo "$OUTPUT" | grep -o 'https://[^ ]*' | tail -1)
[[ "$CLEANUP" == "true" ]] && rm -rf "$STAGE"

echo ""
ok "${BOLD}live:${NC} $URL"
echo "  Works on any device — text it, Slack it, put it behind the podium laptop."
echo "  Re-running this script updates the same URL."
echo "  Take it down anytime: https://vercel.com/dashboard → delete project '$SAFE_NAME'."
warn "open the URL and click through every slide once — if an image or audio file is"
echo "  missing, put the deck and its assets in one folder and deploy the folder instead."
