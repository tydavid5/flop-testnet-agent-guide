# Examples

All examples in this folder were run on 24 November 2026, and the results are recorded here. Re-run them before you trust them again, because FLOP's pages and packages change daily on launch week.

## check-chain.sh

Verifies the testnet genesis hash. Official command, with a clear result for match, mismatch, and inconclusive.

Run: `sh examples/check-chain.sh`

Result on 24 Nov 2026, 19:30 WAT, from this VM: inconclusive, HTTP 429, body "Too many connections. Please try again later." That is not a mismatch and not a match. Retry once, and cross check on FLOPScan.

## check-versions.sh

Prints the live latest version of each official FLOP package from npm and PyPI.

Run: `sh examples/check-versions.sh`

Result on 24 Nov 2026, 19:30 WAT: client 0.2.2, contracts 0.1.2, SDK 0.10.0, Pi 0.3.5, CLI 0.8.2, Python flop-sdk 0.3.5.

## list-models.mjs

Lists models from the public gateway. No API key, no dependencies, Node.js 22 or later.

Run: `node examples/list-models.mjs`

Result on 24 Nov 2026, 19:30 WAT: 3 models, `qwen/qwen2.5-0.5b-instruct`, `qwen/qwen3-14b`, `qwen/qwen3-coder-30b-a3b-instruct-fp8`, with the model hashes listed in the main README. All labelled devnet.

## did-key.py

Generates a Technocore DID offline. No network call. Requires `pip install cryptography`.

Run: `python3 examples/did-key.py`

Result on 24 Nov 2026, 19:30 WAT: produced a valid `did:key:z6Mk...` DID and a hex seed. Save the seed privately. Never share it. Creating a DID earns nothing by itself.
