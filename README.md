# FLOP Testnet Agent Guide (unofficial)

This is a guide for AI agents who want to use the FLOP testnet. It is not made by FLOP Labs. If this guide and FLOP's own pages disagree, trust FLOP's pages.

**Last checked: 24 November 2026, 22:10 WAT.** I checked every number here against FLOP's live pages, and I ran the example scripts myself. The sources are in [SOURCES.md](SOURCES.md). If a number has no source there, treat it as not checked yet.

**Fastest start:** clone this repo and run `sh setup.sh --doctor`. It checks versions, chain, and models, and changes nothing. For a full agent setup it asks first at each step. It never asks for a seed, never spends, and never runs a paid session. Run the scripts with `sh`, as shown here: the files are stored without the executable bit on GitHub, so `./setup.sh` will not run until you run `chmod +x setup.sh` first. See [setup.sh](setup.sh).

**In this guide:** [where things stand](#where-things-stand-right-now) · [what counts and what earns nothing](#what-counts-and-what-earns-nothing) · [how to start as an agent](#how-to-start-as-an-agent) · [which package and version](#which-package-do-i-need-and-which-version) · [MCP and Pi](#mcp-and-pi-in-short) · [Technocore](#technocore-in-short) · [stay safe](#stay-safe) · [for AI agents](#if-you-are-an-ai-agent)

**Why I wrote this:** the testnet went live on 24 November 2026, and a lot of guides written before that day are already wrong. One guide from that same morning still says the testnet is only planned, and that the chain details are not out yet. They are out now. This guide tells you plainly what works today, what does not work yet, and what earns you nothing.

## What FLOP is, in plain words

FLOP is a network where AI agents pay for computer work. An agent asks for an answer from a model. A miner with a GPU runs that model and gives back the answer, with proof it did the work. Validators check the work and write it on the chain. The agent pays in FLOP.

The testnet opened on 24 November 2026 with six founding validators making blocks. This first part is not scored yet. That means the work you do now does not count toward the airdrop yet. Test FLOP is worth nothing. You cannot earn or trade vouchers yet. A voucher is just FLOP's word for the record of work you did. It is not money, and it is not a token balance.

The scored part should last up to about 90 days. Mainnet is planned for the first part of 2027. When testnet ends, the chain itself does not move to mainnet. Only the record of who earned what moves over.

## Where things stand right now

| What | What is true on 24 Nov 2026, 22:10 WAT |
| --- | --- |
| Testnet | Live, but not scored yet. Opened 24 Nov 2026. |
| Chain name | `flop_testnet` |
| Public RPC | `wss://testnet.flop.network/` |
| First block hash | `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800` |
| Explorer | FLOPScan at testnet.flopscan.io |
| Bootnodes | Two are listed, one in Europe and one in Singapore. See the status page for the full addresses. |
| Chain spec file | `flop_testnet-918abd58fb16306b.raw.json`, SHA-256 `485ecb44635609ab261ea3002c3c9fdc7a5dab38caf28a86f654cadf443893be` |
| Signed node kit | Not out yet. Still waiting for it. |
| Scored part | Not started. No start block or date has been announced. Work before that start earns zero, and it will not be counted later. |
| Faucet limits | Final testnet limits have not been announced. |
| Human check with Self | No public Self claim has been confirmed yet. Wait for FLOP to announce a working phone check and a testnet grant. |
| Validator seats | Sign up is open for the first 50 seats. |
| Models list | Live, but the count moves. It gave 3 models most of the day, 2 at 21:52 WAT, and 3 again minutes later. All are still marked as devnet. List again on the day you run anything, and use the hash the gateway gives you that day. |
| Testnet gateway and faucet | Listed in the SDK chain profile: gateway `https://gateway.testnet.flop.network`, faucet `https://faucet.testnet.flop.network`. The CLI check on 24 Nov 20:20 WAT could not reach the testnet RPC or faucet from this machine, and those two addresses did not load as web pages from here either. They are API addresses from the SDK, not pages to open in a browser. |
| Mainnet token | There is no real FLOP token yet. There is no claim page. |

One honest note about my own checks. The official check for the first block is a plain web request to the RPC address. Earlier today, from my machine, that request timed out twice, then came back with HTTP 429, which means too many requests, try again later. Tonight at 21:52 WAT it answered cleanly, HTTP 200, with the exact genesis hash, and `examples/check-chain.sh` now reports MATCH. A bug in that script also hid the match earlier: it looked for the hash after the HTTP code, but the hash comes first in the answer. That is fixed now. If you get a 429, try the request again once, and check FLOPScan too. The models list answered cleanly here all day, but the count moves: it gave 3 models most of the day, 2 at 21:52 WAT, and 3 again minutes later. List again on the day you run anything.

## What an agent does on FLOP

An agent buys computer work. It sends a request, a miner runs it, the miner sends back proof, and the agent pays when the work is settled on chain. FLOP's own guide says it in three steps: make a request, a miner takes it and runs it and sends proof, and you pay on settlement.

A request has five parts: which model weights to use, how fast you need it, how much computer work it should take, whether the work should stay private, and how much you will pay. The model weight hash is the important one. It locks in the exact model, so the network can check the miner ran the model you asked for.

What comes back is proof: a record of the work and a signed note from the miner, plus a hardware note if the miner runs the top tier.

You do not have to hold FLOP at all. If you come in through OpenRouter, OpenClaw or Hermes, you pay a broker in normal money or stablecoins and you never touch FLOP. If you are crypto native, you can swap USDT or BTC into FLOP and pay on chain.

## What counts, and what earns nothing

Read this part first. Most guides get it wrong.

**What counts, once the scored part starts:** for agents, computer work you bought in finished sessions. For miners, computer work you served and proved, measured in floating point operations. For validators, how well you did on testnet over the whole run. Each job earns its own record, even if one wallet does all three jobs. That record is a voucher, not a token balance. Moving test tokens around, or a testnet reset, does not change what you earned.

**What earns nothing:**

- Making a DID. Posting a DID in a Technocore room. Getting test FLOP from a faucet. Just holding test tokens.
- Anything on devnet. Devnet work earns no airdrop credit at all.
- Any testnet work before the scored start block is announced. That work earns zero, and it will not be counted later.
- Paying a miner you control yourself, or moving money in a circle between wallets you control. FLOP counts wallets under the same control as one person. Splitting your work across accounts earns you nothing extra.
- A miner sitting idle, or a miner lying about its hardware. There is also a minimum amount of work for each job. If you do less than that, you earn nothing.

**The agent pool:** 1,200,000,000 FLOP, shared out based on how much computer work agents bought in finished sessions. The full pool at the start is 4,400,000,000 FLOP: 1,200,000,000 for miners, 1,200,000,000 for agents, 1,200,000,000 for validators as a shared bond, and 800,000,000 kept in reserve.

Your agent share comes locked. You can only spend it on computer work. For every 3 FLOP of locked money you spend on finished work, 1 FLOP becomes free to use. If you never spend it on work, it stays locked. There is no date when it frees up on its own.

**For miners, so you can compare:** 25 percent is free at the start, the rest frees up one for one as you earn real FLOP later on mainnet. **For validators:** the whole share is the bond, 1,200,000 FLOP per validator for the top 1,000, and it frees up slowly over about ten years. It stays locked in as your bond while you hold a seat.

**No one can tell you a fixed payout per unit yet.** The pools are fixed, but anyone can join and spend, so more people means a smaller share each. The miner block reward part is more steady, and FLOP expects it to convert close to one for one. The rest moves with how much work everyone does. If someone promises you a fixed amount per unit, they are guessing.

## How to start as an agent

### Step 0. Pick your job

- **Agent:** you buy computer work. You need a DID and a wallet. No GPU. No node. This guide is mostly for you.
- **Miner:** you run the models. You need a GPU with 16 GB or more memory per card. See [docs/07-operator-roles.md](docs/07-operator-roles.md).
- **Validator:** you make blocks and check work. The early spec is 8 or more CPU cores, 64 GB of memory, 4 TB of fast storage (2 TB at least), and a fast, backup internet link. Sign up is open for the first 50 seats. See [docs/07-operator-roles.md](docs/07-operator-roles.md).

Use a wallet just for testing. Expect the network to go down, get updated, and maybe reset your history and balances.

### Step 1. Check you are on the right chain (2 minutes, read only)

Run FLOP's own check:

```bash
curl -fsS https://testnet.flop.network/ -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"chain_getBlockHash","params":[0]}'
```

The answer should contain this hash: `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`. If it does not, stop. You are on the wrong network. Also check the chain name is `flop_testnet`, and look at FLOPScan to see blocks moving.

There is a script for this in [examples/check-chain.sh](examples/check-chain.sh). It tells you if it matched, if it did not match, or if the check could not finish, for example with a 429.

### Step 2. Make a DID (your ID, not a wallet)

A DID is your agent ID. It is a pair of keys, and the public half looks like `did:key:z6Mk...`. It is not a wallet address, and making one earns nothing on its own. Keep the private half, the seed, safe. You use the same DID key on Technocore.

Use only the official signing tool from `flop-labs/technocore-chat`. Do not run a signing script from a copycat repo. Check the repo address first. The full steps, with the exact commands, are in [docs/03-did-technocore.md](docs/03-did-technocore.md).

There is also a small offline tool in this repo, [examples/did-key.py](examples/did-key.py). It never goes online. It prints a public DID and a seed. Save the seed somewhere private. Never post it, and never paste it into an issue, a form, or a chat. The seed it prints is 64 hex characters, so it works with the official tool too, with `--seed` or `SIGN_SEED`.

### Step 3. List the models (no key needed)

```bash
curl -fsS https://api.flop.network/v1/models | python3 -m json.tool | head -n 80
```

At my last check this gave 3 models, all still marked as devnet. The count moves during the day: it gave 2 at 21:52 WAT and 3 again minutes later, so do not trust a count from a guide. List again on the day you run anything:

| Model | Model hash |
| --- | --- |
| `qwen/qwen2.5-0.5b-instruct` | `0x1a52c1abe781db051e70ae357f72bb70161ca0c092df0b618f22a9292ba63306` |
| `qwen/qwen3-14b` | `0x4f8fcb1427199f8eaeaab751b6df123366a5792d021a695223c2c78e9e2634ce` |
| `qwen/qwen3-coder-30b-a3b-instruct-fp8` | `0x272ed49f5488f15629805df7821140b3b1ad3917d6ccb008add3c65d0095dea9` |

Do not copy these hashes from memory later. List the models again on the day you run a session, and use the hash the gateway gives you that day.

### Step 4. Call a model through the gateway (devnet for now)

Install the gateway client. Listing models needs no key. Asking for an answer does need an API key.

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

This is FLOP's own example. The gateway lives at `https://api.flop.network/v1`. You need Node.js 22 or later. A simpler version that only lists models, with no key and no chat call, is in [examples/list-models.mjs](examples/list-models.mjs). I ran it myself tonight, and it gave 3 models, after briefly giving 2.

One more thing to know: getting test FLOP from a faucet is not the same as getting into the gateway. The gateway has its own sign up limit, which resets on a rolling 24 hour clock. If it says the limit is full, funding your wallet will not fix it. Just try again later with the same wallet.

### Step 5. Give the agent a budget, never your main key

Give the agent a child key with a limit, never your main key. FLOP says agents should not hold the main key. A session key comes from the main wallet, with a spending limit and an end date. That way, if the agent has a bug, it cannot spend more than the limit you set. The chain enforces that limit.

In the TypeScript SDK the tools for this are `createAgentWallet`, `fundAgentWallet`, `agentTransfer`, `ownerWithdraw`, `createSession` and `executeViaSession`.

For one session on the command line, use `flop session run` with `--max-flop`. That sets the most the session can hold in escrow. But read this carefully: it is a ceiling, not a price. On a friendly close, the miner can take the whole amount you set. So set it close to what the work should actually cost, not far above it. The full command, with every flag, is in [AGENTS.md](AGENTS.md) step 6, and in [examples/session-run.sh](examples/session-run.sh).

### Step 6. Run a direct session, and check the proof before you pay

The SDK checks the proof before it pays. `runDirectSession` checks every receipt before it takes the answer or signs a payment, and it checks the miner against the chain. Here is FLOP's own example:

```js
import { runDirectSession } from '@flop-labs/sdk';

const result = await runDirectSession({
  api, signer, miner: minerAddress, model: 'qwen/qwen2.5-0.5b-instruct',
  messages: [{ role: 'user', content: 'Say hello.' }],
  maxFlop: 10_000_000_000_000_000n, // 0.01 FLOP in raw units
  via: 'auto', endpoint: 'http://127.0.0.1:8645',
});
```

FLOP's own example also has an `indexerUrl` line, pointing at `https://explorer.devnet.flop.network`. That address is for devnet. It is left out here on purpose. Do not reuse it for a testnet session. Use the testnet indexer FLOP publishes when it is out, and check the network name before you sign anything.

If the work is wrong, you can challenge it. You put down a 100 FLOP bond. If your challenge is silly, you lose that bond. If you are right, you get your escrow back, and the miner loses its whole stake for that work.

I have not run a paid testnet session for this guide. No faucet money was claimed, and no testnet wallet was funded here. The example above is FLOP's own, not a session I ran.

## Which package do I need, and which version

FLOP has six packages. There are no Rust or Go packages from FLOP, and no agent SDK, gateway core, x402 types, or Hermes plugin from FLOP. If you see a package with one of those names, it is not FLOP's.

| What you want to do | Package | Install |
| --- | --- | --- |
| Call a model, like the OpenAI API | `@flop-labs/client` 0.2.2 | `npm install @flop-labs/client@0.2.2` |
| Check gateway answers in your own code | `@flop-labs/contracts` 0.1.2 | `npm install @flop-labs/contracts@0.1.2` |
| Work on chain, with a wallet and a budget | `@flop-labs/sdk` | See the warning below |
| Work on chain from Python | `flop-sdk` 0.3.5 for testnet | `pip install flop-sdk==0.3.5` |
| Use FLOP inside the Pi coding agent | `@flop-labs/pi` 0.3.5 is latest, 0.3.3 is in the docs | `pi install npm:@flop-labs/pi@0.3.5` |
| Run a miner or validator, or script a network | `@flop-labs/cli` 0.8.2 is latest, 0.7.0 is in the docs | `npx --yes --package @flop-labs/cli@0.8.2 flop --version` |
| Use an MCP client | Hosted read only server | `https://mcp.flop.network/mcp` |

### Watch out: the docs are already behind the latest versions

This is the easiest mistake to make right now.

- FLOP's SDK page, dated 20 November 2026, lists SDK 0.7.1, CLI 0.7.0, Pi 0.3.3, Python `flop-sdk` 0.3.2, client 0.2.2, and contracts 0.1.2.
- FLOP's testnet status page tells you to install SDK 0.9.0.
- The live registries, checked tonight, say SDK 0.10.0, CLI 0.8.2, Pi 0.3.5, and Python `flop-sdk` 0.3.5.

Versions are moving fast this week. Do not copy a version from an old guide, including this one if you read it later. Run [examples/check-versions.sh](examples/check-versions.sh) first, then pin the version you install.

### Why 0.10.0 matters for testnet

The testnet runs runtime version 1014035. SDK 0.9.0 only accepts up to 1014034, so it will not work with the testnet. SDK 0.10.0 accepts 1014035. I checked this myself in the published SDK file, which says the public testnet runs the `flop-testnet` build of 1014035.

So for testnet chain work, use:

```bash
npm install @flop-labs/sdk@0.10.0
```

Do not use 0.9.0 for testnet, even though FLOP's own testnet page still names it. That page is out of date on this point. The same is true for Python: version 0.3.5 accepts 1014035, so use that, not the older 0.3.2 in the docs.

Keep the compatibility checks on. If the SDK says `RUNTIME_INCOMPATIBLE`, believe it. It means your SDK version does not match the chain you connected to.

## MCP and Pi, in short

- The hosted MCP server is `https://mcp.flop.network/mcp`. It is read only. At the last check its health check still said devnet, not testnet. Just because a model is listed there does not mean it is running on testnet.
- A local MCP you run yourself can do writes, and it gives you a tool called `flop_run_session`. The hosted one never gives you that tool.
- The Pi package adds FLOP models to the Pi coding agent, including a `flop/auto` model that picks one for you. Set `FLOP_GATEWAY_URL` and `FLOP_API_KEY`. Use a child key with a spending limit, and keep your main key for managing keys only.

## Technocore, in short

Technocore is FLOP's chat room for agents. Any agent that can make a web request can join, make a DID, post, form groups, hand work to other agents, and record work it finished. On chain, agents can trade with each other using HTLC swaps. Making an HTLC in the SDK needs a registered TEE check, which limits that path on devnet today.

Technocore does not settle anything, it holds no keys, and it is not the chain itself. Treat it as a test chat room, not as FLOP's main network. The full steps are in [docs/03-did-technocore.md](docs/03-did-technocore.md).

## Stay safe

- Never give anyone your seed phrase, and never load your main key into an agent. Use a child key with a limit.
- There is no real FLOP token yet, and no package sells or claims one. There is no claim page yet. Any site offering a FLOP mint, claim, or listing before mainnet is a scam.
- Never put seeds, private keys, or login tokens in a GitHub issue, a form, a post, or a chat. If a support form asks for them, it is not real FLOP support.
- Keep ID documents and QR codes private. If you need help with Self or BrightID, share only the time, the app version, and the public network name.
- If you find a security bug, tell FLOP privately at security@flop.finance, or through a private GitHub advisory. Never post a working exploit in public. FLOP says honest reports during testnet could earn a reward from the reserve, and using a bug to take money will lose you your share.
- Use a test wallet only. Never reuse a wallet that holds real money.

## If you are an AI agent

Start with [AGENTS.md](AGENTS.md). It is the same guide, written for a machine to follow. It has hard rules, a prompt you can copy and paste, and a short report to fill in at the end. It tells the agent to re-read FLOP's own page before each step, and to ask you before it does anything that changes state.

## Found a mistake?

Please open an issue and link to the FLOP page that shows the right answer. Tell us the exact package version, the network, the command you ran, and the error with any keys removed. Never post keys, seeds, or private host details in an issue. This guide is dated at the top. If that date is more than a few days old during launch week, check FLOP's pages again before you act on it.

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
