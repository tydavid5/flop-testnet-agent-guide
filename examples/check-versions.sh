#!/bin/sh
# Check the live latest versions of the official FLOP packages.
# Docs baseline, 20 Nov 2026: client 0.2.2, contracts 0.1.2, SDK 0.7.1,
# Pi 0.3.3, CLI 0.7.0, Python flop-sdk 0.3.2.
# Registry latest, checked 24 Nov 2026 19:25 WAT: SDK 0.10.0, CLI 0.8.2,
# Pi 0.3.5, Python flop-sdk 0.3.5. Versions move daily on launch week.
# Pin the version you install. Do not copy a version from an old guide.
# Usage: sh examples/check-versions.sh
set -eu
for pkg in @flop-labs/client @flop-labs/contracts @flop-labs/sdk @flop-labs/pi @flop-labs/cli; do
  echo -n "$pkg: "
  npm view "$pkg" version
done
echo -n "flop-sdk (PyPI): "
curl -fsS -m 20 https://pypi.org/pypi/flop-sdk/json | python3 -c "import sys, json; print(json.load(sys.stdin)['info']['version'])"
echo "For testnet chain work, use SDK 0.10.0 or later, because only 0.10.0 admits runtime 1014035. SDK 0.9.0 stops at 1014034."
