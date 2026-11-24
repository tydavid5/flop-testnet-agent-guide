# Sources

Every factual claim in this guide should trace to one of these sources. FLOP's official pages win wherever this guide differs. Check dates are in WAT unless stated otherwise.

## Official FLOP pages, read 24 November 2026

- Testnet page, flop.finance/testnet. Live, unscored opening, opened 24 Nov 2026. Six founding validators. RPC `wss://testnet.flop.network/`. Genesis hash `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`. Registration open for the first 50 validator seats. Timeline, roles, hardware, onboarding, what counts, one participant one score, independent demand only, fraud forfeits, security disclosure to security@flop.finance.
- Testnet status, ask.flop.finance/networks/testnet. Chain ID `flop_testnet`. Bootnodes EU and SG. Raw spec `flop_testnet-918abd58fb16306b.raw.json`, SHA-256 `485ecb44635609ab261ea3002c3c9fdc7a5dab38caf28a86f654cadf443893be`. Signed raw spec and Linux node kit pending. No verified public Self claim at the opening. Earning begins at a publicly announced finalized activation block of a future tested runtime upgrade. No announced block or date yet. Earlier activity earns zero, with no backfill. SDK 0.9.0 named on that page, with a runtime allowlist stopping at 1014034 and an opening runtime of 1014035. MCP endpoint and model API listed, with a note that a listing does not establish testnet mining or settlement.
- Agent onboarding FAQ, docs.flop.network/docs/agent-onboarding. Wallet enrollment cap, rolling 24 hour window. Faucet limits, final testnet limits not announced. Devnet Self and BrightID tier: 500 FLOP base grant, up to 2,000 FLOP per grant, 2,000 FLOP rolling seven day cap, 24 hour cooldown. Faucet grant does not earn airdrop credit. Devnet grants and spend earn no airdrop credit.
- SDK and package references, ask.flop.finance/docs/sdk-references. Baseline `2026-11-20-sdk-0.7.1-cli-0.7.0`, recorded 20 Nov 2026. Client 0.2.2, contracts 0.1.2, SDK 0.7.1, Pi 0.3.3, CLI 0.7.0, Python flop-sdk 0.3.2. Gateway base URL `https://api.flop.network/v1`. Hosted MCP `https://mcp.flop.network/mcp`, read only. SDK functions, agent wallet functions, `runDirectSession`, HTLC TEE requirement, Pi peer requirements. No Rust crates, Go module, agent SDK, gateway core, x402 types or Hermes plugin from FLOP.
- Tokenomics and supply FAQ, docs.flop.network/docs/tokenomics-and-supply. Block reward 96 FLOP, split 75, 10, 10, 5. Inference fees 85 percent miner, 15 percent validator. Genesis pool 4,400,000,000 FLOP: miners 1,200,000,000, agents 1,200,000,000, validators 1,200,000,000, reserve 800,000,000. Agent unlock 3 to 1 spend to unlock. Miner 25 percent liquid, rest earn to unlock 1 to 1. Validator bond linear unlock over about ten years. Vouchers, not testnet balances, are the canonical record. No conversion formula in advance.
- Protocol parameters, ask.flop.finance/docs/protocol-parameters. Block reward 96 FLOP, era 0. Dispute bond 100 FLOP. Audit rate 2.5 percent, challenge window about 7 days, response deadline 2 hours, fraud slash 100 percent.

## Live registry and API checks, run 24 November 2026

- npm registry, `@flop-labs/sdk` latest 0.10.0, checked 19:25 WAT via registry.npmjs.org. Description: TypeScript SDK for the FLOP Network, HTLC workflows, PoUI proofs, and account management.
- npm registry, `@flop-labs/cli` latest 0.8.2, `@flop-labs/pi` latest 0.3.5, checked 19:25 WAT.
- PyPI, `flop-sdk` latest 0.3.5, releases 0.3.0, 0.3.2, 0.3.3, 0.3.4, 0.3.5, checked 19:25 WAT via pypi.org/pypi/flop-sdk/json.
- unpkg, `@flop-labs/sdk@0.10.0/dist/runtime-compatibility.js`, checked 19:25 WAT. Admits spec version 1014035. Says the public testnet runs the `flop-testnet` build of 1014035, code hash `0xd62d8278...fa858`, 61 pallets, devnet set minus PaidStorage and voucher pallets 150 to 155.
- unpkg, `@flop-labs/sdk@0.9.0/dist/runtime-compatibility.js`, checked 19:25 WAT. Admits up to 1014034 only.
- Models API, `https://api.flop.network/v1/models`, checked live 24 Nov 18:24 UTC. Returned 3 models, all labelled devnet, with model hashes listed in the README. Pricing and capacity fields were live in the response. The response named devnet in the model names and in `source: devnet-nominal`.
- RPC genesis POST, `https://testnet.flop.network/`, tried from this VM 24 Nov 19:20 to 19:30 WAT. Timed out twice at 15 seconds, then returned HTTP 429 on a 30 second attempt. Reported honestly in the README. The endpoint and the expected hash come from the official testnet pages, not from a successful call here.

## Secondary sources, used only where noted

- Flop Network News, Build an AI Agent on Flop Network, last updated 14 Nov 2026. Agent integration guide, agent onboarding FAQ, and SDK references as they stood then. Used for the five field session request, the `runDirectSession` example, agent wallet functions, and the MCP and Pi notes. Every number from that page was cross checked against the official pages above before it was kept.
- Flop Network News, FLOP SDK and CLI Guide, updated 24 Nov 2026. Noted that npm latest for SDK was 0.9.0 on 23 Nov, and that the docs baseline still listed 0.7.1 on 20 Nov. This guide checked the registry again on 24 Nov evening and found 0.10.0, which supersedes that note.
- GitHub, flop-labs/technocore-chat. Official Technocore source and signer. Used for the DID steps. No code from that repo is copied here.
- GitHub search, 24 Nov 2026. A competing guide, flopnews26/flop-testnet-guide, created 24 Nov 11:03 UTC, still says the testnet is planned and that the chain spec, genesis, bootnodes and RPC are not published yet. That was true before launch and is wrong after it. This guide corrects that, with the live official pages as the source.

## What was not verified

- A paid testnet inference session was not run for this guide. No testnet faucet grant was claimed, and no testnet wallet was funded. The direct session example is FLOP's documented example, not a session run by this guide.
- The signed testnet node kit was not downloaded, because it was pending public download at the last check.
- The final testnet faucet limits, the scored activation block, and the testnet indexer URL were not published at the last check. This guide does not invent them.
- FLOPScan block height and validator set were not scraped live for this guide. The explorer link is given so the reader can check them directly.
