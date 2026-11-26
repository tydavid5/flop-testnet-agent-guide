# Examples

All examples in this folder were run on 24 November 2026, and the results are recorded here. Run them again before you trust them, because FLOP's pages and packages change fast during launch week.

## setup.sh (repo root)

Checks and sets up, without spending. `sh setup.sh --doctor` checks versions, chain, and models and changes nothing. `sh setup.sh --agent` walks through DID, keystore, capped session key, faucet, and gateway, and asks first at each step. `sh setup.sh --miner-check` and `sh setup.sh --validator-check` check your hardware and tell you the honest status. Add `--dry-run` to print the commands and run none of them. It never asks for a seed, never prints one, and never runs a paid session.

Run: `sh setup.sh --doctor`

Result on 24 Nov 2026, 21:53 WAT: doctor ran clean, versions matched, chain reported MATCH, models listed 3, after briefly listing 2. Miner check found no GPU here and reported no public testnet miner pack yet. Validator check reported 4 CPU cores and 7.7 GB RAM here, below the validator spec, and no signed testnet validator package yet. Update 26 Nov 2026: the signed node kit and validator bundle are published now, in release testnet/v0.1.0-early.1, but the miner pack is still not out.

## check-chain.sh

Checks the testnet first block hash. It uses FLOP's own command, and it tells you if it matched, if it did not match, or if the check could not finish.

Run: `sh examples/check-chain.sh`

Result on 24 Nov 2026, 19:30 WAT, from this machine: could not finish, HTTP 429, body "Too many connections. Please try again later." That is not a match and not a mismatch. At 21:52 WAT the same check answered cleanly, HTTP 200, with the exact genesis hash, and the script reports MATCH. A bug in the script hid the match earlier, its check looked for the hash after the HTTP code, but the hash comes first. Fixed 21:52 WAT.

## check-versions.sh

Prints the live latest version of each official FLOP package, from npm and PyPI.

Run: `sh examples/check-versions.sh`

Result on 24 Nov 2026, 22:10 WAT: client 0.2.2, contracts 0.1.2, SDK 0.10.0, Pi 0.3.5, CLI 0.8.2, Python flop-sdk 0.3.5. Unchanged all day.

## list-models.mjs

Lists models from the public gateway. No API key, no extra packages, Node.js 22 or later. It only lists models. It makes no chat call.

Run: `node examples/list-models.mjs`

Result on 24 Nov 2026, 21:53 WAT: 3 models, `qwen/qwen2.5-0.5b-instruct`, `qwen/qwen3-14b`, `qwen/qwen3-coder-30b-a3b-instruct-fp8`, with the model hashes listed in the main README. All marked as devnet. The count moves during the day: it gave 2 at 21:52 WAT and 3 again minutes later.

## session-run.sh

Runs one direct session on testnet with the FLOP CLI. It stops if the miner address, keystore, or password env var is missing. Ask the human for the miner address, the endpoint, and permission to spend before you run it.

Run: `MINER_SS58=5... KEYSTORE=agent.json PASSWORD_ENV=FLOP_KEY_PASSWORD sh examples/session-run.sh`

Result: not run with a real miner for this guide, because there is no published testnet miner to call yet. The script was checked with no miner set, and it stopped with the missing value message, as designed. The CLI help for `flop session run` was checked live on 24 Nov 2026 20:20 WAT.

## did-key.py

Makes a Technocore DID offline. No network call. Needs `pip install --break-system-packages cryptography` on Debian or Ubuntu, where plain pip install is blocked by the system. On macOS, plain `pip install cryptography` works.

Run: `python3 examples/did-key.py`

Result on 24 Nov 2026, 19:30 WAT: made a valid `did:key:z6Mk...` DID and a hex seed. Save the seed somewhere private. Never share it. Making a DID earns nothing on its own. The seed is 64 hex characters, so it works with the official `sign.py` tool too, with `--seed` or `SIGN_SEED`.
