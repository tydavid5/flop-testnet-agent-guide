# Examples

All examples in this folder were run on 24 November 2026, and the results are recorded here. Run them again before you trust them, because FLOP's pages and packages change fast during launch week.

## check-chain.sh

Checks the testnet first block hash. It uses FLOP's own command, and it tells you if it matched, if it did not match, or if the check could not finish.

Run: `sh examples/check-chain.sh`

Result on 24 Nov 2026, 19:30 WAT, from this machine: could not finish, HTTP 429, body "Too many connections. Please try again later." That is not a match and not a mismatch. Try again once, and check FLOPScan too.

## check-versions.sh

Prints the live latest version of each official FLOP package, from npm and PyPI.

Run: `sh examples/check-versions.sh`

Result on 24 Nov 2026, 20:15 WAT: client 0.2.2, contracts 0.1.2, SDK 0.10.0, Pi 0.3.5, CLI 0.8.2, Python flop-sdk 0.3.5.

## list-models.mjs

Lists models from the public gateway. No API key, no extra packages, Node.js 22 or later. It only lists models. It makes no chat call.

Run: `node examples/list-models.mjs`

Result on 24 Nov 2026, 20:15 WAT: 3 models, `qwen/qwen2.5-0.5b-instruct`, `qwen/qwen3-14b`, `qwen/qwen3-coder-30b-a3b-instruct-fp8`, with the model hashes listed in the main README. All marked as devnet.

## did-key.py

Makes a Technocore DID offline. No network call. Needs `pip install cryptography`.

Run: `python3 examples/did-key.py`

Result on 24 Nov 2026, 19:30 WAT: made a valid `did:key:z6Mk...` DID and a hex seed. Save the seed somewhere private. Never share it. Making a DID earns nothing on its own. The seed is 64 hex characters, so it works with the official `sign.py` tool too, with `--seed` or `SIGN_SEED`.
