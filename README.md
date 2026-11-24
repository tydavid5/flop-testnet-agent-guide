# FLOP Testnet Agent Guide (unofficial)

A precise, checked guide for AI agents that want to use the FLOP testnet. Not affiliated with FLOP Labs. FLOP's official pages win wherever this guide differs.

**Last checked: 24 November 2026, 19:30 WAT (18:30 UTC).** Every dated claim in this guide names its source in [SOURCES.md](SOURCES.md). If a number has no source there, treat it as unverified.

**Why this guide exists:** the FLOP testnet went live on 24 November 2026, and most guides written before that day are already wrong. One guide published that same morning still says the testnet is planned and that the chain spec, genesis hash and RPC are not published yet. All three are published now. This guide was checked against the live official pages on launch day, and it says plainly what is live, what is not live yet, and what earns nothing.

## The testnet in one paragraph

FLOP is a network where AI agents buy inference from GPU miners, and validators settle the work on chain. The testnet opened on 24 November 2026 with six founding validators producing blocks. This opening is unscored. Test FLOP has no monetary value. Voucher earning and trading are disabled. The planned scored phase lasts up to about 90 days, and mainnet is targeted for Q1 2027. Testnet chain state is not migrated to mainnet. Only the allocation earned on testnet is carried forward.

## Where things stand

| Item | Status on 24 Nov 2026, 19:30 WAT | Source |
| --- | --- | --- |
| Testnet | Live, unscored opening, opened 24 Nov 2026 | flop.finance/testnet |
| Chain ID | `flop_testnet` | ask.flop.finance/networks/testnet |
| Public RPC | `wss://testnet.flop.network/` | flop.finance/testnet |
| Genesis hash | `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800` | flop.finance/testnet |
| Explorer | FLOPScan at testnet.flopscan.io | flop.finance/testnet |
| Bootnodes | Two public multiaddresses, EU and SG, listed in the status doc | ask.flop.finance/networks/testnet |
| Raw chain spec | `flop_testnet-918abd58fb16306b.raw.json`, SHA-256 `485ecb44635609ab261ea3002c3c9fdc7a5dab38caf28a86f654cadf443893be` | ask.flop.finance/networks/testnet |
| Signed node kit | Pending public download at last check | ask.flop.finance/networks/testnet |
| Scored phase | Not started. No activation block or date announced yet. Earlier activity earns zero, with no backfill. | ask.flop.finance/networks/testnet |
| Testnet faucet limits | Final limits not announced yet | docs.flop.network/docs/agent-onboarding |
| Verified human faucet (Self) | No verified public Self claim at the opening. Wait for a successful phone proof and a finalized testnet grant to be announced. | ask.flop.finance/networks/testnet |
| Validator seats | Registration open for the first 50 seats | flop.finance/testnet |
| Gateway models API | Live, returns 3 models at last check, all labelled devnet | api.flop.network/v1/models, checked live 24 Nov 18:24 UTC |
| Mainnet token | No launched or tradable FLOP token. No claim page. | docs.flop.network/docs/sdk-references |

Two checks from this VM, reported honestly. The official genesis check is a plain HTTPS POST to the RPC URL. From this VM that request timed out twice at 15 seconds, then returned HTTP 429 on a 30 second attempt. The endpoint is real and the official docs are the authority for it, but do not take this guide as proof that the RPC answered cleanly from here. Cross check on FLOPScan, and retry the POST once if you get a 429. The models API, by contrast, answered cleanly from this VM at 18:24 UTC with 3 models.

## What an agent does on FLOP

An agent buys inference. It posts a session request, a miner runs it, the miner returns a proof, and the agent pays in FLOP on settlement. The integration guide puts it in three sentences: create a session request in the mempool, a capable miner accepts, runs the task, and returns a proof, and you pay in FLOP on settlement.

A session request has five fields: the model weight hash, the maximum latency, the compute in FLOPs, a confidentiality flag, and the fee. The model hash pins the exact weights, which is how the network checks that the miner ran the model you asked for.

What the miner returns is a proof of inference: activation commitments and a co-signed transcript, plus a hardware quote if it runs the optional HARD tier.

An agent does not have to hold FLOP at all. Agents arriving through OpenRouter, OpenClaw or Hermes never touch FLOP and pay a broker in fiat or stablecoin. Crypto native agents swap USDT or BTC into FLOP through HTLC atomic swaps and transact on chain.

## What counts, and what earns nothing

This is the part most guides get wrong, so read it first.

**Counts, in the planned scored phase only:** compute purchased in settled inference sessions, for agents. Verified compute served, for miners. Testnet performance ranking, for validators. Each role earns its own voucher, even if one wallet holds all of them. A voucher is the record, not a testnet token balance. Moving testnet tokens around, or a testnet reset, does not change what you are owed.

**Earns nothing:**

- Creating a DID. Posting a DID in a Technocore room. A faucet grant by itself. Holding test tokens.
- Any devnet activity. Devnet grants and spend earn no airdrop credit.
- Any testnet activity before the announced scored activation block. Earlier activity earns zero, with no backfill.
- Spend routed to a miner under common control, or circulated between wallets under common control. Wallets under common control are scored as a single participant. Dividing activity across accounts earns no additional allocation.
- Idle or misrepresented hardware, for miners. Dormant accounts do not earn, because each role has a minimum activity floor.

**Agent airdrop pool, draft:** 1,200,000,000 FLOP, shared pro rata to compute purchased in settled sessions. The full genesis pool is 4,400,000,000 FLOP: miners 1,200,000,000, agents 1,200,000,000, validators 1,200,000,000 as an aggregate bond, and an 800,000,000 ecosystem reserve. The agent allocation arrives locked and can be spent only on compute. Every 3 FLOP of locked airdrop spent on inference unlocks 1 FLOP. Tokens never spent on inference stay locked. There is no time based vesting schedule for agents.

**Miner unlock, for context:** 25 percent liquid at genesis, the rest unlocks 1 to 1 with FLOP later earned from block rewards and inference fees. **Validator unlock:** the whole airdrop is the bond, 1,200,000 FLOP per validator for the top 1,000, unlocking linearly from genesis over about ten years, and unlocking never unbonds the bond while the validator holds a seat.

**No conversion formula can be published in advance.** The pools are fixed, any number of agents can claim from the faucet and spend, and more activity means more claims against the same pool. The miner block reward portion is deterministic and is expected to convert close to one for one. The inference and agent portions float. Anyone promising you a fixed per unit payout is guessing.

## Agent quickstart

### Step 0. Decide your role

- **Agent:** you buy inference. You need a DID and a wallet. No GPU. No node. This guide is mainly for you.
- **Miner:** you serve inference. You need a GPU with 16 GB or more VRAM per unit. See [docs/07-operator-roles.md](docs/07-operator-roles.md).
- **Validator:** you produce blocks and verify work. Provisional spec is 8 or more core CPU, 64 GB RAM, 4 TB NVMe storage (2 TB minimum), 1 Gbps redundant connection. Registration is open for the first 50 seats. See [docs/07-operator-roles.md](docs/07-operator-roles.md).

Use a dedicated test wallet. Expect outages, runtime upgrades, and possible resets of history and balances.

### Step 1. Check the chain (read only, 2 minutes)

Run the official genesis check from FLOP's testnet status page:

```bash
curl -fsS https://testnet.flop.network/ -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"chain_getBlockHash","params":[0]}'
```

Compare the result with the genesis hash in the table above: `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`. If it does not match, stop. You are on the wrong network. Also compare the chain ID, `flop_testnet`, and check FLOPScan at testnet.flopscan.io to see finalized blocks moving.

A scripted version is in [examples/check-chain.sh](examples/check-chain.sh). It prints the expected hash, runs the check, and tells you whether it matched.

### Step 2. Create a DID (identity, not a wallet)

A DID is your agent identity. It is an Ed25519 key pair, published as `did:key:z6Mk...`. It is not a wallet address, and creating one earns nothing by itself. Keep the private key, the seed, safe. The same DID key is the one used on Technocore.

Use the official signer from `flop-labs/technocore-chat`. Do not run a signing script from a lookalike repo. Verify you are pulling from the real repo before you run it. Full steps, including publish and lobby check in, are in [docs/03-did-technocore.md](docs/03-did-technocore.md).

A local, offline key generator that produces the same `did:key` format is in [examples/did-key.py](examples/did-key.py). It never touches the network. It prints a public DID and a seed. Save the seed privately, never post it, never paste it into an issue, a form, or a chat.

### Step 3. List the models (no key needed)

```bash
curl -fsS https://api.flop.network/v1/models | python3 -m json.tool | head -n 80
```

At the last live check, 24 Nov 2026 18:24 UTC, this returned 3 models, all labelled devnet:

| Model | Model hash |
| --- | --- |
| `qwen/qwen2.5-0.5b-instruct` | `0x1a52c1abe781db051e70ae357f72bb70161ca0c092df0b618f22a9292ba63306` |
| `qwen/qwen3-14b` | `0x4f8fcb1427199f8eaeaab751b6df123366a5792d021a695223c2c78e9e2634ce` |
| `qwen/qwen3-coder-30b-a3b-instruct-fp8` | `0x272ed49f5488f15629805df7821140b3b1ad3917d6ccb008add3c65d0095dea9` |

Do not copy these hashes from memory later. List the models again when you run a session, and use the hash the gateway returns that day. The gateway list is the authority for which model hash to pin.

### Step 4. Call a model through the gateway (devnet today)

Install the gateway client and list models with it. Chat completions need an API key. Listing models does not.

```bash
npm install @flop-labs/client@0.2.2
```

```js
import { FlopClient } from "@flop-labs/client";
const client = new FlopClient({ apiKey: process.env.FLOP_API_KEY });
const models = await client.listModels();
const completion = await client.createChatCompletion({
  model: models.data[0].id,
  messages: [{ role: "user", content: "Hello" }],
});
```

This example is from FLOP's SDK references page. The default base URL is `https://api.flop.network/v1`. It needs Node.js 22 or later. A runnable listing version, with no key and no chat call, is in [examples/list-models.mjs](examples/list-models.mjs).

### Step 5. Give the agent a budget, never the owner key

Give an agent a derived key with a cap, never the owner key. FLOP's technology FAQ says agents do not hold the main key: a session or agent key is derived from the main wallet with a spending limit and an expiry. The spend control page lists pre-set spend limits, delegated bounded authority via proxies, multisig, timelocks and multi-party escrow. The reason is plain: a bug in the agent cannot exceed a boundary the chain enforces.

In the TypeScript SDK these controls appear as `createAgentWallet`, `fundAgentWallet`, `agentTransfer`, `ownerWithdraw`, `createSession` and `executeViaSession`. For a single session, the CLI `--max-flop` flag sets the escrow ceiling in FLOP.

### Step 6. Run a direct session, and verify the receipt before you pay

The SDK checks receipts before it pays. `runDirectSession` verifies every receipt before accepting output or signing payment, and cross checks the miner session info against the finalized channel key and registry identity. This is the documented example from FLOP's direct session guide:

```js
import { runDirectSession } from '@flop-labs/sdk';

const result = await runDirectSession({
  api, signer, miner: minerAddress, model: 'qwen/qwen2.5-0.5b-instruct',
  messages: [{ role: 'user', content: 'Say hello.' }],
  maxFlop: 10_000_000_000_000_000n, // 0.01 FLOP in raw units
  via: 'auto', endpoint: 'http://127.0.0.1:8645',
  indexerUrl: 'https://explorer.devnet.flop.network',
});
```

Note the indexer URL in that example points at devnet. Do not reuse a devnet indexer URL for a testnet session. Use the testnet explorer and indexer FLOP publishes for testnet when they are announced, and check the network name before you sign anything.

If the work is wrong, the agent can challenge it. A discretionary challenger posts a 100 FLOP bond, forfeited if the dispute is frivolous, and an upheld fraud verdict refunds the agent escrow and slashes the miner in full.

## Packages: which one, and which version

FLOP publishes six packages. There are no Rust crates, no Go module, and no agent SDK, gateway core, x402 types or Hermes plugin packages from FLOP. A package with one of those names on a public registry is not FLOP's.

| Your agent | Package | Install |
| --- | --- | --- |
| Calls a model, OpenAI style API | `@flop-labs/client` 0.2.2 | `npm install @flop-labs/client@0.2.2` |
| Checks gateway responses in your own client | `@flop-labs/contracts` 0.1.2 | `npm install @flop-labs/contracts@0.1.2` |
| Holds its own wallet and budget, chain work | `@flop-labs/sdk` | See version warning below |
| Runs in Python, chain work | `flop-sdk` | `pip install flop-sdk==0.3.2` for the docs baseline, see below |
| Is the Pi coding agent | `@flop-labs/pi` 0.3.3 in the docs baseline | `pi install npm:@flop-labs/pi@0.3.3` |
| Operates a miner or validator, or scripts a network | `@flop-labs/cli` 0.7.0 in the docs baseline | `npx --yes --package @flop-labs/cli@0.7.0 flop --version` |
| Is an MCP client | Hosted read only MCP server | `https://mcp.flop.network/mcp` |

### Version warning: the docs baseline is already behind the registry

This is the single easiest mistake to make right now, so it gets its own section.

- FLOP's SDK references page records a baseline dated 20 November 2026: SDK 0.7.1, CLI 0.7.0, Pi 0.3.3, Python `flop-sdk` 0.3.2, client 0.2.2, contracts 0.1.2.
- FLOP's testnet status page tells you to install SDK 0.9.0.
- The npm registry latest for `@flop-labs/sdk`, checked 24 Nov 2026 19:25 WAT, is **0.10.0**. CLI latest is 0.8.2, Pi latest is 0.3.5, Python `flop-sdk` latest on PyPI is 0.3.5.

Version numbers are moving daily on launch week. Do not copy a version from an old guide, including this one if you are reading it later. Run [examples/check-versions.sh](examples/check-versions.sh) first, then pin the version you actually install.

### Why 0.10.0 matters for testnet

The testnet runs runtime spec version **1014035**. SDK 0.9.0 admits spec versions up to 1014034 only, so it does not admit the testnet runtime. SDK 0.10.0 admits 1014035. This was verified directly from the published `dist/runtime-compatibility.js` file for 0.10.0, which says the public testnet runs the `flop-testnet` build of 1014035, with code hash starting `0xd62d8278` and ending `fa858`, 61 pallets, devnet set minus PaidStorage and the voucher pallets 150 to 155.

So for testnet chain work, use:

```bash
npm install @flop-labs/sdk@0.10.0
```

Do not use 0.9.0 for testnet, even though FLOP's own testnet page still names it at the last check. That page is stale on this point. Keep compatibility checks enabled. If the SDK throws `RUNTIME_INCOMPATIBLE`, it is telling you the version is wrong for the runtime you connected to. Believe it.

## MCP and Pi

- Hosted MCP server: `https://mcp.flop.network/mcp`, streamable HTTP, read only. At the opening check its health tool reported FLOP devnet, not testnet. A listing does not establish testnet mining or settlement.
- Local, write enabled stdio MCP provides `flop_run_session`. The hosted MCP never exposes this tool.
- Pi package: adds a `flop` provider, with one model per offer the gateway lists, and the `flop/auto` virtual model, which picks a FLOP model for each request. Set `FLOP_GATEWAY_URL` and `FLOP_API_KEY`. Use a bounded child credential with a spend cap, and reserve owner keys for managing credentials.

## Technocore in brief

Technocore is FLOP's agent to agent chatroom. Any agent that can make HTTP requests can join, create a DID key, post, form groups, hand tasks to other agents, and record completed work. On chain, agents can trade FLOP against another chain's asset through HTLC atomic swaps. HTLC creation in the SDK requires a registered TEE appraisal profile, which limits that route on the devnet today.

Technocore is ephemeral, settles nothing, holds no keys, and is not part of a protocol. Treat it as experimental agent infrastructure, not as the future FLOP blockchain itself. Full steps are in [docs/03-did-technocore.md](docs/03-did-technocore.md).

## Safety and scams

- Never give an agent, a website, or a FLOP airdrop checker your seed phrase, and never load an owner key into an agent. Use a bounded child credential with a spend cap.
- There is no FLOP token yet, and no package sells or claims one. There is no official claim page yet. Any site offering a FLOP mint, a claim, or a market listing before mainnet is a scam.
- Never include seeds, private keys, or bearer tokens in a GitHub issue, a form, a post, or a chat. If a support form asks for them, it is not FLOP support.
- Keep identity documents and QR payloads private. For Self or BrightID support, share only the time, app version, and public network name.
- Security vulnerabilities go privately to security@flop.finance, or through a GitHub private advisory. Never post an exploitable finding as a public issue. FLOP's testnet page says vulnerabilities reported responsibly during the testnet could be eligible for a reward from the ecosystem reserve, and exploiting a vulnerability forfeits eligibility.
- Use a dedicated test wallet. Never reuse a mainnet wallet or a wallet that holds real funds for testnet work.

## For AI agents: read AGENTS.md

If you are an AI agent, or you are pointing one at this repo, start with [AGENTS.md](AGENTS.md). It is the machine readable version of this guide, with hard rules, a copy paste prompt, and a session report format. It tells the agent to re-read the official page before each step, and to ask before every state changing command.

## Corrections

Found something wrong or out of date? Open an issue with the official page that shows it. Include the exact package version, network, command, and redacted error output. Never post keys, seeds, or private host details in an issue. This guide is versioned by its last checked date at the top. If that date is more than a few days old on launch week, re-check the official pages before you act.

## Official links

- Testnet: https://flop.finance/testnet/
- Airdrop: https://flop.finance/airdrop/
- Docs, operator hub: https://docs.flop.network/operators
- Docs, SDK references: https://ask.flop.finance/docs/sdk-references
- Testnet status, Ask FLOP: https://ask.flop.finance/networks/testnet
- Agent onboarding FAQ: https://docs.flop.network/docs/agent-onboarding
- FLOPScan testnet: https://testnet.flopscan.io
- Technocore: https://technocore.chat
- FLOP Labs on X: https://x.com/flop_labs

Unofficial guide, by [@tydavid5](https://github.com/tydavid5). Not affiliated with FLOP Labs.
