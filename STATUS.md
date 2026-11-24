# Status log

## 24 November 2026, 20:20 WAT

Third check, to make AGENTS.md runnable at a glance. Every command in the new AGENTS.md was checked against a live source, and the ones that can run without money or a miner were run.

Fixes in this update:

- AGENTS.md now starts with setup, clone, and version checks, then gives the exact command for every step, with what a pass looks like and what to do if it fails.
- CLI command corrected to `flop session run`, checked live with `flop session run --help` on CLI 0.8.2. The old wording, `flop run`, was wrong for 0.8.2.
- Added the testnet gateway and faucet from the SDK chain profile, with the honest note that the CLI could not reach the testnet RPC or faucet from this machine tonight.
- Added exact SDK code for agent wallets and sessions, with signatures checked in SDK 0.10.0, and example limits of 3.5 FLOP per transaction and 35 FLOP per day.
- Added a runnable `examples/session-run.sh` template. It stops if the miner, keystore, or password env var is missing.
- DID steps now give the exact download, keygen, did, and say commands, and the say command was run with a test seed and gave the same DID as `examples/did-key.py`.
- Step 6 now says plainly: stop if there is no miner address and endpoint, and do not fall back to devnet.

## 24 November 2026, 20:15 WAT

Second check, after the first publish. The guide was re-read line by line, and the official pages, registries, models API, SDK files, CLI tarball, Python wheel, and Technocore signer were checked again.

Fixes in this update:

- DID steps now use Python 3.12 or later, with `uv run`, and use the signed lane, with the sweep, the nonce rule, and the message and note limits.
- Python `flop-sdk` testnet recommendation is now 0.3.5, not 0.3.2, after checking the published wheel. It accepts runtime 1014035.
- CLI `--max-flop` now says plainly that a friendly close can spend the whole amount you set.
- Added that faucet money does not reserve a gateway place, from the onboarding FAQ.
- Words were made simpler and more human throughout the README and the DID and operator docs.
- Models API checked again tonight: still 3 models, same hashes. SDK, CLI, Pi, and Python versions unchanged tonight: 0.10.0, 0.8.2, 0.3.5, and 0.3.5.
- All example scripts run again. See examples/README.md.

## 24 November 2026, 19:30 WAT

- Testnet live, unscored opening. Scored phase not started, no activation block announced.
- Genesis hash, chain ID, RPC, bootnodes, raw spec SHA verified against flop.finance/testnet and ask.flop.finance/networks/testnet.
- Models API checked live, 3 models, all devnet, hashes recorded in README.
- SDK 0.10.0 verified to admit runtime 1014035, from unpkg runtime-compatibility.js. SDK 0.9.0 stops at 1014034.
- Registry latest checked: SDK 0.10.0, CLI 0.8.2, Pi 0.3.5, Python flop-sdk 0.3.5, client 0.2.2, contracts 0.1.2.
- All example scripts run. list-models, check-versions, and did-key passed. check-chain returned inconclusive, HTTP 429, "Too many connections. Please try again later." Reported honestly in README.
- All official links in README checked, HTTP 200, except the MCP endpoint, which returns 405 on GET. That is expected for a POST only MCP endpoint, not a broken link.
- No paid testnet session was run. No faucet grant was claimed. No testnet wallet was funded.

## Next update triggers

- FLOP announces the scored activation block. Update the status table, the README, and AGENTS.md the same day.
- FLOP publishes the signed testnet node kit, the final faucet limits, or a testnet indexer URL. Add them, with the source and date.
- SDK, CLI, Pi, or Python flop-sdk publishes a new version. Re-run check-versions.sh and update the version table.
- Any official page changes a number in this guide. Open a correction, with the official page as the source.
