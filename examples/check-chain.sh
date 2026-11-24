#!/bin/sh
# Check the FLOP testnet genesis hash against the published value.
# Official source: https://flop.finance/testnet/
# Expected genesis, checked 24 Nov 2026:
# 0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800
# Chain ID: flop_testnet. RPC: wss://testnet.flop.network/
# Usage: sh examples/check-chain.sh
# Note: from some networks this RPC POST is slow or rate limited.
# A 429 or a timeout is not a mismatch, it is an inconclusive check.
# Retry once, and cross check on FLOPScan at https://testnet.flopscan.io
set -eu
EXPECTED="0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800"
echo "Expected genesis: $EXPECTED"
echo "Chain ID: flop_testnet"
BODY=$(curl -sS -m 30 -w "\nHTTP_CODE:%{http_code}" https://testnet.flop.network/ -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"chain_getBlockHash","params":[0]}' || true)
echo "RPC response: $BODY"
case "$BODY" in
  *"HTTP_CODE:200"*)
    case "$BODY" in
      *"$EXPECTED"*)
        echo "MATCH: genesis hash matches the published testnet genesis."
        ;;
      *)
        echo "NO MATCH: the RPC answered, but the response did not contain the expected genesis hash."
        echo "Stop. You may be on the wrong network. Re-read https://flop.finance/testnet/ before you proceed."
        exit 1
        ;;
    esac
    ;;
  *)
    echo "INCONCLUSIVE: the RPC did not return HTTP 200. This is not a mismatch, and it is not a match."
    echo "Retry once, and cross check on FLOPScan at https://testnet.flopscan.io"
    exit 2
    ;;
esac
