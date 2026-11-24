# Status log

## 24 November 2026, 20:45 WAT

Fifth check, a public facing audit before this goes wider. All external links were checked live. All internal links were checked against the files in this repo.

Fixes in this update:

- Removed two test key addresses and one test DID from SOURCES.md. They were throwaway test keys, already deleted, but publishing them could have led someone to send funds to a dead address. They are not in this repo any more. Note: they are still in earlier git history, because git history keeps old commits. Do not use them.
- Fixed a stale line in SOURCES.md that still said the `run` command. It is `session run`.
- Added a note in AGENTS.md that FLOP's direct session guide is written for devnet, and the testnet command adapts it by changing the network flag.
- Added a note in the README that the testnet gateway and faucet addresses did not load as web pages from here. They are API addresses from the SDK, not pages to open in a browser.
- Added .gitignore, SECURITY.md, and CONTRIBUTING.md, so no one accidentally commits a keystore, a seed file, or an env file, and so a reader knows how to report a mistake or a security bug safely.
- Added a short contents list to the top of the README.
- Unified the last checked date to 24 Nov 2026, 20:45 WAT across the README, AGENTS.md, and examples. Models and versions were rechecked at that time: still 3 models, still SDK 0.10.0, CLI 0.8.2, Pi 0.3.5, Python 0.3.5.

## 24 November 2026, 20:30 WAT

Fourth check, a full loophole audit of AGENTS.md and README, line by line, against live sources. Every command that can run without money or a miner was run again.

Loopholes found and fixed:

- The step 5 limits were wrong. 3.5 FLOP per transaction and 35 FLOP per day are proposed limits, pending approval, not defaults. The approved calibrated limits are 5 and 50. The example now uses 5 and 50, and says plainly that 3.5 and 35 are proposed only.
- Step 5 had no way to make a keystore, and the SDK snippet used an `OWNER_SIGNER` with no code to load it. Fixed by adding the exact `flop keys generate` command, tested live, and the exact `flop session create` command as the runnable path. The SDK code is now marked as a template, not a live run, with a note that loading a seed wrong is how keys leak.
- Step 4 gave code with no file name and no run command. Fixed: save it as `gateway-call.mjs`, then run `node gateway-call.mjs`.
- Step 3 did not say to install `cryptography` before running `sign.py` with plain Python. Fixed with the exact pip install command.
- Step 6 did not say to set the keystore password in the shell first, and did not link the keystore to the file made in step 5. Fixed, and added a warning not to switch from `--via auto` to `--via force` without asking first.
- Models and versions rechecked tonight: still 3 models, SDK still 0.10.0, testnet page still 200, testnet status page still names 1014034 and 1014035.

What is still not verified, and stays stated in the guide: no funded testnet wallet was used to run the SDK agent wallet calls, and no paid testnet session was run, because there is no published testnet miner to call yet. The CLI paths for those steps were checked with `--help` and, for keystore generation, with a live run that created and then deleted a test key.

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
