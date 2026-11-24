#!/bin/sh
# FLOP testnet setup, for humans and for agents.
#
# This script checks, it does not spend. It never asks for a seed, never
# prints a seed, never runs a paid session, and never sends money.
# A paid session needs a testnet miner, and no public testnet miner pack
# is published yet. When one is out, the command for it is in AGENTS.md
# step 6, and it needs your say so first.
#
# Usage, from the repo root:
#   sh setup.sh --doctor            check everything, change nothing
#   sh setup.sh --agent             DID, keystore, gateway checks, asks first
#   sh setup.sh --miner-check       GPU check, then the honest miner status
#   sh setup.sh --validator-check   hardware check, then the honest validator status
#   sh setup.sh --dry-run --agent   print the commands, run none of them
#
# Versions this script uses, checked live 24 Nov 2026:
#   CLI @flop-labs/cli 0.8.2, SDK @flop-labs/sdk 0.10.0, Pi 0.3.5,
#   client 0.2.2, contracts 0.1.2, Python flop-sdk 0.3.5.
# The docs baseline, CLI 0.7.0 and SDK 0.9.0, does not work on the live
# testnet runtime, 1014035. Do not use it.

set -u

DRY_RUN=0
MODE="doctor"

say() { printf '%s\n' "$1"; }
ok() { printf 'PASS: %s\n' "$1"; }
bad() { printf 'FAIL: %s\n' "$1"; }
check() { printf 'CHECK: %s\n' "$1"; }

usage() {
  sed -n '2,20p' "$0"
  say ""
  say "Flags: --doctor, --agent, --miner-check, --validator-check, --dry-run, --help"
}

ask() {
  # Ask yes or no. In dry run mode, always answer no.
  if [ "$DRY_RUN" = "1" ]; then
    say "(dry run, skipping: $1)"
    return 1
  fi
  printf '%s [y/N] ' "$1"
  read -r answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

run_or_print() {
  # Run a command, or print it in dry run mode.
  if [ "$DRY_RUN" = "1" ]; then
    say "would run: $*"
    return 0
  fi
  "$@"
}

for arg in "$@"; do
  case "$arg" in
    --doctor) MODE="doctor" ;;
    --agent) MODE="agent" ;;
    --miner-check) MODE="miner-check" ;;
    --validator-check) MODE="validator-check" ;;
    --dry-run) DRY_RUN=1 ;;
    --help|-h) usage; exit 0 ;;
    *) say "Unknown flag: $arg"; usage; exit 1 ;;
  esac
done

cd "$(dirname "$0")" || exit 1

doctor() {
  say "FLOP testnet doctor. This checks things. It changes nothing."
  say ""
  if [ "$DRY_RUN" = "1" ]; then
    say "would run: sh examples/check-versions.sh"
    say "would run: sh examples/check-chain.sh"
    say "would run: node examples/list-models.mjs"
    say "would run: python3 --version, node --version, nvidia-smi"
    exit 0
  fi
  say "1. Package versions. The live testnet needs SDK 0.10.0 and CLI 0.8.2."
  if sh examples/check-versions.sh; then
    ok "versions match the live testnet"
  else
    bad "versions do not match. Do not install the docs baseline."
  fi
  say ""
  say "2. Chain. The first block hash must be 0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800."
  if sh examples/check-chain.sh; then
    ok "chain genesis matches"
  else
    check "chain check did not confirm. That can mean the RPC is busy or rate limited, not that the chain is down. Check testnet.flopscan.io too."
  fi
  say ""
  say "3. Gateway models. Listing needs no key."
  if node examples/list-models.mjs; then
    ok "models listed"
  else
    bad "models did not list"
  fi
  say ""
  say "4. Tools on this machine."
  python3 --version 2>/dev/null || bad "python3 is missing. DID steps need Python 3.12 or later."
  node --version 2>/dev/null || bad "node is missing. The SDK and CLI need Node 22 or later."
  if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi --query-gpu=name,memory.total --format=csv 2>/dev/null || check "nvidia-smi is here but did not report a GPU"
  else
    say "No GPU here. That is fine for an agent. Miners need 16 GB or more VRAM per GPU."
  fi
  say ""
  say "5. What is not ready yet, 24 Nov 2026. No public testnet miner pack is published. The scored phase has not started, so work now earns nothing. The faucet has no verified public Self claim at opening. This script does not work around any of that."
}

agent() {
  say "Agent setup. Each step asks first. Nothing here spends money."
  say ""
  say "Step 1. Make a DID. This makes a key pair on your machine. Save the seed somewhere private, like a password manager. Never put it in a repo, an issue, or a chat."
  if ask "Make a DID with examples/did-key.py?"; then
    if [ "$DRY_RUN" = "0" ] && ! python3 -c "import cryptography" 2>/dev/null; then
      say "The cryptography package is missing. Install it first: pip install cryptography"
      say "Skipping the DID step. Run sh setup.sh --agent again after installing it."
    else
      run_or_print python3 examples/did-key.py
      say "If it printed a seed, save it now, where you chose. This script does not save it for you."
    fi
  fi
  say ""
  say "Step 2. Make an encrypted keystore for the owner, with the official CLI 0.8.2. The password goes in the shell only, never in a file. Do not use --show-secret, it prints the seed."
  if [ -f ./agent.json ]; then
    say "A file called ./agent.json already exists. This script will not overwrite it. Delete or rename it yourself first, or use the keystore you already have."
  elif ask "Make a keystore called ./agent.json?"; then
    if [ "$DRY_RUN" = "0" ] && [ -z "${FLOP_KEY_PASSWORD:-}" ]; then
      say "FLOP_KEY_PASSWORD is not set in the shell. Set it first: export FLOP_KEY_PASSWORD=<your password>"
      say "Skipping the keystore step. Run sh setup.sh --agent again after setting it."
    else
      say "Set the password in the shell first: export FLOP_KEY_PASSWORD=<your password>"
      run_or_print npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet keys generate --name agent --type sr25519 --out ./agent.json --password-env FLOP_KEY_PASSWORD --json
      say "Keep ./agent.json safe. It is in .gitignore, so it will not be committed."
    fi
  fi
  say ""
  say "Step 3. Make a capped session key from that keystore. Approved limits are 5 FLOP per transaction and 50 FLOP per day. Do not use 3.5 and 35, those are proposed limits, not approved."
  if [ ! -f ./agent.json ]; then
    say "There is no ./agent.json keystore here, so this step cannot run. Do step 2 first, or point the command at your own keystore file."
  elif [ "$DRY_RUN" = "0" ] && [ -z "${FLOP_KEY_PASSWORD:-}" ]; then
    say "FLOP_KEY_PASSWORD is not set in the shell. Set it first, then run this step again."
  elif ask "Create a session key with limits 5 and 50?"; then
    say "This step needs your agent wallet address. The script will not run it with a placeholder."
    if [ "$DRY_RUN" = "1" ]; then
      say "would run: npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet --keystore ./agent.json --password-env FLOP_KEY_PASSWORD session create --delegate YOUR_AGENT_ADDRESS --tx-limit 5 --daily-cap 50 --ttl 86400 --json"
    else
      printf 'Agent wallet address: '
      read -r agent_address
      case "$agent_address" in
        ""|AGENT_ADDRESS|YOUR_AGENT_ADDRESS)
          say "No address given. Skipping this step."
          ;;
        *)
          npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet --keystore ./agent.json --password-env FLOP_KEY_PASSWORD session create --delegate "$agent_address" --tx-limit 5 --daily-cap 50 --ttl 86400 --json
          ;;
      esac
    fi
  fi
  say ""
  say "Step 4. Faucet. Honest warning: there is no verified public Self claim on testnet at opening, and the faucet may not answer. If it does not, wait. Do not pay anyone for test FLOP."
  if ask "Try a faucet request for the keystore address?"; then
    if [ "$DRY_RUN" = "1" ]; then
      say "would run: npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet faucet request YOUR_KEYSTORE_ADDRESS"
    else
      printf 'Keystore address from step 2: '
      read -r keystore_address
      case "$keystore_address" in
        ""|KEYSTORE_ADDRESS|YOUR_KEYSTORE_ADDRESS)
          say "No address given. Skipping this step."
          ;;
        *)
          npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet faucet request "$keystore_address"
          ;;
      esac
    fi
  fi
  say ""
  say "Step 5. Gateway. Listing models needs no key. A chat call needs a FLOP gateway API key."
  run_or_print node examples/list-models.mjs
  say ""
  say "Done. A paid session is not part of this script. It needs a testnet miner, and there is no public testnet miner to call yet. The command is in AGENTS.md step 6, and it needs your say so and a miner address first."
}

miner_check() {
  say "Miner check. This checks your GPU and tells you the honest status."
  if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi --query-gpu=name,memory.total --format=csv 2>/dev/null || check "nvidia-smi is here but did not report a GPU"
    say "Miners need 16 GB or more VRAM per GPU."
  else
    say "No GPU found here. Miners need an NVIDIA GPU with 16 GB or more VRAM per unit."
  fi
  say ""
  say "Status, 24 Nov 2026: there is no public testnet miner pack, and no supported way to move a devnet miner to testnet. Devnet registration, stake, and calibration do not carry over. Do not install the devnet pack on testnet."
  say "Next step: register interest at https://flop.finance/apply/miner and wait for the Operator Hub to list the signed testnet pack. This repo watches for it and will say when it drops."
}

validator_check() {
  say "Validator check. This checks your hardware and tells you the honest status."
  say "CPU cores: $(nproc 2>/dev/null || echo unknown)"
  free -h 2>/dev/null | head -n 2 || true
  df -h . 2>/dev/null | tail -n 1 || true
  say "Validators need 8 or more CPU cores, 64 GB RAM, 4 TB NVMe (2 TB minimum), and a 1 Gbps redundant connection."
  say ""
  say "Status, 24 Nov 2026: registration is open for the first 50 validator seats, through the operator form at https://github.com/flop-labs/network/issues/new?template=operator-application.yml. The signed testnet validator package is not published yet, so this script does not download or install one. The prep kit is at https://docs.flop.network/testnet-validator-prep/"
  say "Registration, funding, and an active seat are separate steps. Being registered does not mean you have a seat."
}

case "$MODE" in
  doctor) doctor ;;
  agent) agent ;;
  miner-check) miner_check ;;
  validator-check) validator_check ;;
esac
