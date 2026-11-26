#!/bin/sh
# Run one direct session on testnet with the FLOP CLI.
# Usage:
#   MINER_SS58=5... MODEL=qwen/qwen2.5-0.5b-instruct PROMPT='Say hello.' MAX_FLOP=0.01 \
#   KEYSTORE=agent.json PASSWORD_ENV=FLOP_KEY_PASSWORD ENDPOINT=http://127.0.0.1:8645 \
#   sh examples/session-run.sh
# Ask the human for the miner address, the endpoint, and permission to spend
# before you run this. Do not invent a miner. Do not use a devnet miner.
# Do not use --new-wallet on testnet. Use an encrypted keystore instead.
set -eu
: "${MINER_SS58:?Set MINER_SS58 to the miner SS58 address}"
: "${MODEL:=qwen/qwen2.5-0.5b-instruct}"
: "${PROMPT:=Say hello.}"
: "${MAX_FLOP:=0.01}"
: "${KEYSTORE:?Set KEYSTORE to the keystore file path}"
: "${PASSWORD_ENV:?Set PASSWORD_ENV to the env var name holding the keystore password}"
: "${ENDPOINT:=http://127.0.0.1:8645}"
npx --yes --package @flop-labs/cli@0.10.2 flop --network testnet --keystore "$KEYSTORE" --password-env "$PASSWORD_ENV" session run \
  --miner "$MINER_SS58" \
  --model "$MODEL" \
  --prompt "$PROMPT" \
  --max-flop "$MAX_FLOP" \
  --via auto \
  --endpoint "$ENDPOINT" \
  --json
