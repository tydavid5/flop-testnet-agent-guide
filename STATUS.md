# Status log

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
