#!/bin/bash

echo "🧠 Enter your wallet address:"
read WALLET

echo "🔢 How many node IDs do you want to generate?"
read COUNT

OUTFILE="nodes.txt"
> "$OUTFILE"  # Clear old file

for ((i = 1; i <= COUNT; i++)); do
  echo "[$i/$COUNT] Registering node..."

  # Register user (starts temp session)
  nexus-network register-user --wallet-address "$WALLET"

  # Register node and extract Node ID
  NODE_ID=$(nexus-network register-node | grep -oE '[0-9]{7,}')

  if [[ -n "$NODE_ID" ]]; then
    echo "[+] Node ID: $NODE_ID"
    echo "$NODE_ID" >> "$OUTFILE"
  else
    echo "[!] Failed to get node ID (check rate limits or wallet)"
  fi

  # Logout to avoid wallet lock or session spam
  nexus-network logout

  # Optional: slow down to avoid IP ban
  sleep 2
done

echo "✅ Done. Saved all Node IDs to $OUTFILE"
