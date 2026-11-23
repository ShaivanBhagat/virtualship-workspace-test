#!/usr/bin/env bash
set -e

TARGET_DIR="/workspaces/tutorials"
mkdir -p "$TARGET_DIR"

NOTEBOOKS=(
  "docs/user-guide/tutorials/CTD_transects.ipynb"
  "docs/user-guide/tutorials/Drifter_data_tutorial.ipynb"
  "docs/user-guide/tutorials/Argo_data_tutorial.ipynb"
  "docs/user-guide/tutorials/ADCP_transects.ipynb"
  "docs/user-guide/tutorials/xbt_plotting.ipynb"
  "docs/user-guide/tutorials/Ship_underwater_ST_plotting.ipynb"
)

for nb in "${NOTEBOOKS[@]}"; do
  FILENAME=$(basename "$nb")
  DEST="$TARGET_DIR/$FILENAME"
  URL="https://raw.githubusercontent.com/Parcels-code/virtualship/main/$nb"

  echo "Fetching: $nb -> $DEST"
  HTTP_STATUS=$(curl -s -w "%{http_code}" -o "$DEST" "$URL")

  if [ "$HTTP_STATUS" -ne 200 ]; then
    echo "WARNING: Failed to download $nb (HTTP $HTTP_STATUS)"
    rm -f "$DEST"
  fi
done

echo "Tutorials ready in $TARGET_DIR"
