#!/bin/bash

# 🧠 Replace these with your actual Nexus Node IDs
NODE_IDS=(
  12885580
  13116972
  13202089
  10323131
  10296221
  10172321
)

THREADS=5

echo "📺 Launching Nexus CLI nodes into screen sessions: 1 to 6..."

for i in "${!NODE_IDS[@]}"; do
  NODE_ID=${NODE_IDS[$i]}
  SCREEN_NAME="$((i+1))"

  echo "🌀 Starting screen session '$SCREEN_NAME' for node ID $NODE_ID..."
  screen -dmS "$SCREEN_NAME" bash -c "nexus-network start --node-id $NODE_ID --max-threads $THREADS; exec bash"
  sleep 1
done

echo
echo "✅ All screen sessions started."
echo "🧠 To attach:  screen -r 1   (or 2, 3, ..., 6)"
echo "🔚 To detach:  Ctrl+A then D"
echo "📜 To list all sessions: screen -ls"
