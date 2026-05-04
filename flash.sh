#!/usr/bin/env bash
# Download latest Toucan firmware from GitHub Actions
set -e

REPO="MuGi-131/zmk-config"
OUT="$HOME/Downloads/toucan-firmware"

echo "Finding latest successful build..."
RUN_ID=$(gh run list --repo "$REPO" --status success --limit 1 --json databaseId --jq '.[0].databaseId')

if [ -z "$RUN_ID" ]; then
  echo "No successful build found. Check https://github.com/$REPO/actions"
  exit 1
fi

echo "Downloading run $RUN_ID..."
rm -rf "$OUT"
gh run download "$RUN_ID" --repo "$REPO" --dir "$OUT"

echo ""
echo "Firmware ready in $OUT/firmware/"
ls "$OUT/firmware/"
echo ""
echo "Flash instructions:"
echo "  Left:  double-tap reset → drag 'toucan_left rgbled_adapter nice_view_gem-seeeduino_xiao_ble-zmk.uf2'"
echo "  Right: double-tap reset → drag 'toucan_right rgbled_adapter-seeeduino_xiao_ble-zmk.uf2'"
echo "  (flash left first, then right)"
