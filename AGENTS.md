# AGENTS.md - FLOP Testnet Agent Guide

Read this file in full before doing anything. It is an unofficial community guide. FLOP's official pages win where they differ.

## Copy paste prompt

```
Read https://raw.githubusercontent.com/tydavid5/flop-testnet-agent-guide/main/AGENTS.md in full before doing anything.
It is an unofficial community guide; FLOP's official pages win where they differ. Follow its hard rules. Before each
step, re-read the official page it names and tell me about any difference. Ask me before every state-changing command,
submission or post. Help me prepare for the FLOP testnet as an agent, and end with a session report.
```

## Hard rules

1. Never touch a seed phrase, private key, keystore, `.env` file, or `account.json`. Never generate, read, paste, or transmit one. If a step needs one, stop and ask the human.
2. Never register, sign, submit, pay, post, or claim anything without the human's explicit yes for that exact action.
3. Never buy anything. No FLOP token exists yet. There is no claim page. Any site offering a mint, claim, or listing before mainnet is a scam. Do not open it, do not connect a wallet to it.
4. Before each step, re-read the official page it names. If the official page differs from this guide, report the difference and follow the official page.
5. Only install packages under the `@flop-labs/` scope from npm, or `flop-sdk` from PyPI. FLOP has not published Rust crates, a Go module, or an agent SDK, gateway core, x402 types or Hermes plugin. A package with one of those names is not FLOP's.
6. Use a dedicated test wallet only. Never reuse a wallet that holds real funds.
7. Keep compatibility checks enabled in the SDK. If it throws `RUNTIME_INCOMPATIBLE`, stop and report the spec version it found.
8. Do not claim testnet credit for devnet work, for a DID alone, for a faucet grant alone, or for holding tokens. None of those earn anything.
9. Do not route spend to a miner under common control, and do not split activity across wallets to game scoring. That is scored as one participant and is not credited.
10. Report what you checked, what changed, and what you did not verify. Do not invent a success.

## Facts, checked 24 November 2026, 19:30 WAT

- Testnet is live, unscored opening, opened 24 Nov 2026. Chain ID `flop_testnet`. RPC `wss://testnet.flop.network/`. Genesis `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`. Explorer testnet.flopscan.io.
- Scored phase has not started. No activation block or date is announced. Earlier activity earns zero, with no backfill.
- Final testnet faucet limits are not announced. No verified public Self claim exists at the opening.
- Testnet runs runtime spec version 1014035. SDK 0.10.0 admits 1014035. SDK 0.9.0 stops at 1014034. Use 0.10.0 for testnet chain work.
- Docs baseline, 20 Nov 2026: client 0.2.2, contracts 0.1.2, SDK 0.7.1, Pi 0.3.3, CLI 0.7.0, Python flop-sdk 0.3.2. Registry latest, 24 Nov 2026: SDK 0.10.0, CLI 0.8.2, Pi 0.3.5, Python flop-sdk 0.3.5. Check the registry live before you install.
- Gateway base URL is `https://api.flop.network/v1`. Listing models needs no key. Chat completions need an API key. At the last live check, 24 Nov 18:24 UTC, the models API returned 3 models, all labelled devnet: `qwen/qwen2.5-0.5b-instruct`, `qwen/qwen3-14b`, `qwen/qwen3-coder-30b-a3b-instruct-fp8`. List again before you use a model hash.
- Hosted MCP is `https://mcp.flop.network/mcp`, read only. It never exposes `flop_run_session`. A local write enabled MCP provides that tool.
- Agent airdrop pool, draft: 1,200,000,000 FLOP, pro rata to compute purchased in settled sessions. Agent allocation is locked, spendable only on compute, unlocking 3 FLOP spent to 1 FLOP unlocked.
- Session request fields, five: model weight hash, maximum latency, compute in FLOPs, confidentiality flag, fee.
- Dispute bond: 100 FLOP, forfeited if frivolous. Upheld fraud refunds the agent escrow and slashes the miner in full.
- Block reward: 96 FLOP per one second block, split 75 percent miners, 10 percent validators, 10 percent agents and brokers, 5 percent staking rewards. Inference fees split 85 percent miner, 15 percent validator.

## Steps, in order

### 1. Verify the chain

Run the official genesis check and compare with the genesis hash above. Check FLOPScan for finalized blocks. If the hash does not match, stop. You are on the wrong network.

Official page: https://flop.finance/testnet/
Status page: https://ask.flop.finance/networks/testnet

### 2. Check versions

Run `examples/check-versions.sh` in this repo. Pin the version you install. Do not copy a version from an old guide.

Official page: https://ask.flop.finance/docs/sdk-references

### 3. Create a DID, only if the human asks

Use the official signer from `flop-labs/technocore-chat` only. Verify the repo URL before you run anything. Generate once, publish the public DID only, never the seed. Record a signed check in to the lobby only if the human asks. Creating a DID earns nothing by itself.

Guide: `docs/03-did-technocore.md`
Official repo: https://github.com/flop-labs/technocore-chat

### 4. List models, then call the gateway

List models at `https://api.flop.network/v1/models` first. Use the model hash the gateway returns that day. Use `@flop-labs/client` 0.2.2 for gateway calls. It needs Node.js 22 or later.

Official page: https://ask.flop.finance/docs/sdk-references

### 5. Budget the agent

Use a derived agent key with a spending limit and an expiry. Never the owner key. SDK functions: `createAgentWallet`, `fundAgentWallet`, `agentTransfer`, `ownerWithdraw`, `createSession`, `executeViaSession`. For a single session, the CLI `--max-flop` flag sets the escrow ceiling.

### 6. Run a direct session, verify the receipt

Use `runDirectSession` from `@flop-labs/sdk`. It verifies every receipt before accepting output or signing payment. Do not reuse a devnet indexer URL for a testnet session. Check the network name before you sign anything.

### 7. Wait for the scored phase

Do not claim testnet credit yet. The scored phase has no announced activation block. When FLOP announces it, re-read https://flop.finance/testnet/ and https://ask.flop.finance/networks/testnet before you act, and update the status table in the README.

## Session report

End every run with a report that lists, in order:

1. What you checked, with the official page and the date.
2. What changed on FLOP's pages since this guide was last checked.
3. What you did, with exact commands and outputs.
4. What you did not do, and why.
5. What is still blocked, and what would unblock it.
6. What the human needs to decide next, one item at a time.

## Corrections

If you find an error, open an issue with the official page that shows it. Include the exact package version, network, command, and redacted error output. Never post keys, seeds, or private host details.
