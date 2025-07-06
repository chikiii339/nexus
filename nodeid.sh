#!/bin/bash

NODE_FILE="nodes.txt"
SLEEP_DELAY=2  # Delay between screen launches

# Read node IDs into array
readarray -t NODE_IDS < "$NODE_FILE"

TOTAL=${#NODE_IDS[@]}
echo "🚀 Launching $TOTAL node screens..."

for i in "${!NODE_IDS[@]}"; do
  NODE_ID="${NODE_IDS[$i]}"
  SCREEN_NAME="node$((i + 1))"

  echo "[*] Launching $SCREEN_NAME for node ID $NODE_ID"

  screen -dmS "$SCREEN_NAME" bash -c "nexus-network start --node-id $NODE_ID"
  sleep "$SLEEP_DELAY"
done

echo "✅ All $TOTAL nodes started in separate screen sessions."
