#!/usr/bin/env bash
# better-slides — deploy a deck to a live URL (Vercel free tier).
#
#   bash scripts/deploy.sh <deck-folder-or-html>
#
# Accepts a folder (with index.html) or a single .html file. Folders are the
# reliable path when the deck has assets (audio, images) beside it — the whole
# folder uploads as-is and relative paths keep working.
#
# First-time users: you need a free Vercel account.
#   1. sign up at https://vercel.com/signup  (GitHub login is easiest)
#   2. run `npx vercel login` and follow the prompt
# Re-running this script on the same deck updates the SAME url.
set -euo pipefail

TARGET="${1:?usage: deploy.sh <deck-folder-or-html>}"
command -v node >/dev/null || { echo "✗ Node.js is required (brew install node)" >&2; exit 1; }

npx --yes vercel whoami >/dev/null 2>&1 || {
  echo "✗ not logged in to Vercel. Run:  npx vercel login   (free account: https://vercel.com/signup)" >&2
  exit 1
}

if [ -d "$TARGET" ]; then
  DIR="$TARGET"
  [ -f "$DIR/index.html" ] || { echo "✗ $DIR has no index.html" >&2; exit 1; }
else
  [ -f "$TARGET" ] || { echo "✗ no such file: $TARGET" >&2; exit 1; }
  # Single file → stage it as a folder so it serves at /
  DIR="$(mktemp -d)/deck"
  mkdir -p "$DIR"
  cp "$TARGET" "$DIR/index.html"
  # bundle same-directory assets referenced by the HTML (src/href/url())
  SRCDIR="$(cd "$(dirname "$TARGET")" && pwd)"
  grep -oE '(src|href)="[^"#:]+"|url\([^)]+\)' "$TARGET" \
    | sed -E 's/^(src|href)="//; s/"$//; s/^url\(//; s/\)$//; s/^["'"'"']//; s/["'"'"']$//' \
    | grep -vE '^(https?:|data:|#|\/)' | sort -u | while IFS= read -r a; do
        [ -f "$SRCDIR/$a" ] && { mkdir -p "$DIR/$(dirname "$a")"; cp "$SRCDIR/$a" "$DIR/$a"; }
      done
fi

echo "· deploying $DIR …"
URL=$(npx --yes vercel deploy "$DIR" --prod --yes 2>/dev/null | tail -1)
echo "✓ live: $URL"
echo "  (works on any device — text it, Slack it. To take it down: https://vercel.com/dashboard)"
echo "  ⚠ open it and click through every slide once — if an image/audio file is missing,"
echo "    put the deck and its assets in one folder and deploy the folder instead."
