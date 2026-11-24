# AGENTS.md - FLOP Testnet Agent Guide

Read this file in full, then run the steps in order. Do not skip a step. Do not invent a value that is marked as a placeholder. If a step needs a value you do not have, stop and ask the human for that one value, then continue.

## Copy paste prompt

```
Read https://raw.githubusercontent.com/tydavid5/flop-testnet-agent-guide/main/AGENTS.md in full before doing anything.
It is an unofficial community guide; FLOP's official pages win where they differ. Follow its hard rules. Before each
step, re-read the official page it names and tell me about any difference. Ask me before every state-changing command,
submission or post. Help me prepare for the FLOP testnet as an agent, and end with a session report.
```

## 0. Set up first (2 minutes)

Run these commands exactly. If one fails, stop and report the error. Do not guess around it.

```bash
git clone https://github.com/tydavid5/flop-testnet-agent-guide.git
cd flop-testnet-agent-guide
node --version
python3 --version
```

Pass: `node --version` shows 22 or higher. `python3 --version` shows 3.12 or higher. If Node is below 22, stop and tell the human. If Python is below 3.12, stop and tell the human.

You also need `curl`, `git`, and `npm`. They come with most systems. Check them with `curl --version`, `git --version`, and `npm --version`.

## What you need from the human, before you spend or sign anything

Ask for these one at a time, only when you reach the step that needs them. Do not ask for all of them up front.

1. Step 3: permission to make a DID, and where to save the seed. Never print a seed in chat or in your report.
2. Step 4: a FLOP gateway API key, if the human wants a chat call. Put it in the shell only, as `FLOP_API_KEY`, never in a file and never in your report.
3. Step 5: the spending limits the human wants, or permission to use the example limits in step 5. Also the owner keystore file and its password, as a file path and an env var name, never the password itself.
4. Step 6: a miner SS58 address and its session endpoint. Do not invent one. Do not use a devnet miner on testnet.
5. Step 6: permission to spend, with the exact max FLOP amount. The example in step 6 uses 0.01 FLOP.

## Hard rules

1. Never print, paste, or transmit a seed phrase, private key, keystore, `.env` file, or `account.json`. If a step needs one, stop and ask the human first. When you do run a key command, save the seed only where the human told you to, never in this repo, never in a chat, and never in your session report.
2. Never register, sign, submit, pay, post, or claim anything without the human's explicit yes for that exact action.
3. Never buy anything. No FLOP token exists yet. There is no claim page. Any site offering a mint, claim, or listing before mainnet is a scam. Do not open it, do not connect a wallet to it.
4. Before each step, re-read the official page it names. If the official page differs from this guide, report the difference and follow the official page.
5. Only install packages under the `@flop-labs/` scope from npm, or `flop-sdk` from PyPI. FLOP has not published Rust crates, a Go module, or an agent SDK, gateway core, x402 types or Hermes plugin. A package with one of those names is not FLOP's.
6. Use a dedicated test wallet only. Never reuse a wallet that holds real funds.
7. Keep compatibility checks enabled in the SDK. If it throws `RUNTIME_INCOMPATIBLE`, stop and report the spec version it found.
8. Do not claim testnet credit for devnet work, for a DID alone, for a faucet grant alone, or for holding tokens. None of those earn anything.
9. Do not route spend to a miner under common control, and do not split activity across wallets to game scoring. That is scored as one participant and is not credited.
10. Report what you checked, what changed, and what you did not verify. Do not invent a success.

## Facts, checked 24 November 2026, 20:45 WAT

- Testnet is live, unscored opening, opened 24 Nov 2026. Chain ID `flop_testnet`. RPC `wss://testnet.flop.network/`. Genesis `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`. Explorer testnet.flopscan.io.
- Testnet gateway, from the SDK chain profile: `https://gateway.testnet.flop.network`. Testnet faucet, from the same profile: `https://faucet.testnet.flop.network`. The CLI network check on 24 Nov 20:20 WAT could not reach the testnet RPC or faucet from this machine. The RPC timed out after 10 seconds. That does not mean the network is down. Check FLOPScan too.
- Scored phase has not started. No activation block or date is announced. Earlier activity earns zero, with no backfill.
- Final testnet faucet limits are not announced. No verified public Self claim exists at the opening. Getting faucet money does not reserve a gateway place. The gateway has its own rolling 24 hour limit.
- Testnet runs runtime spec version 1014035. SDK 0.10.0 admits 1014035. SDK 0.9.0 stops at 1014034. Use 0.10.0 for testnet chain work. Python `flop-sdk` 0.3.5 also admits 1014035. Use 0.3.5, not the older 0.3.2 in the docs.
- Docs baseline, 20 Nov 2026: client 0.2.2, contracts 0.1.2, SDK 0.7.1, Pi 0.3.3, CLI 0.7.0, Python flop-sdk 0.3.2. Registry latest, 24 Nov 2026: SDK 0.10.0, CLI 0.8.2, Pi 0.3.5, Python flop-sdk 0.3.5. Check the registry live before you install.
- Gateway base URL is `https://api.flop.network/v1`. Listing models needs no key. Chat completions need an API key. At the last live check, 24 Nov 20:45 WAT, the models API returned 3 models, all labelled devnet: `qwen/qwen2.5-0.5b-instruct`, `qwen/qwen3-14b`, `qwen/qwen3-coder-30b-a3b-instruct-fp8`. List again before you use a model hash.
- Hosted MCP is `https://mcp.flop.network/mcp`, read only. It never exposes `flop_run_session`. A local write enabled MCP provides that tool, per FLOP's direct session guide.
- Agent airdrop pool, draft: 1,200,000,000 FLOP, shared out based on computer work bought in finished sessions. Agent share is locked, spendable only on computer work, unlocking 3 FLOP spent to 1 FLOP unlocked.
- Session request fields, five: model weight hash, maximum latency, compute in FLOPs, confidentiality flag, fee.
- Dispute bond: 100 FLOP, lost if the challenge is frivolous. If the challenge is upheld, the agent gets its escrow back and the miner is slashed in full.
- Block reward: 96 FLOP per one second block, split 75 percent miners, 10 percent validators, 10 percent agents and brokers, 5 percent staking rewards. Inference fees split 85 percent miner, 15 percent validator.
- The CLI command for a direct session is `flop session run`, not `flop run`. It needs `--miner`, `--model`, `--prompt`, and `--max-flop`. That last flag is a ceiling, not a price. On a friendly close, the miner can take the whole amount you set, so set it close to the real cost.

## Steps, in order

### 1. Verify the chain (2 minutes, read only)

Run this command exactly:

```bash
curl -fsS https://testnet.flop.network/ -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"chain_getBlockHash","params":[0]}'
```

Pass: the answer contains `0x918abd58fb16306b30ef3886514cfaebffecb4de43e82b6f8ec4795c43cfd800`.

Fail: if the hash is different, stop. You are on the wrong network. If the request times out or returns HTTP 429, wait, try once more, then check https://testnet.flopscan.io to see if blocks are moving. Do not call a timeout a match.

You can also run the script in this repo, which prints the same check and says match, no match, or could not finish:

```bash
sh examples/check-chain.sh
```

Official page: https://flop.finance/testnet/
Status page: https://ask.flop.finance/networks/testnet

### 2. Check versions (1 minute, read only)

Run this command exactly, from the repo root:

```bash
sh examples/check-versions.sh
```

Pass: it prints client 0.2.2, contracts 0.1.2, SDK 0.10.0, Pi 0.3.5, CLI 0.8.2, Python flop-sdk 0.3.5, or a newer version with a note that it changed. Pin the version it prints. Do not copy a version from an old guide.

If the script is not there, because you only have this one file, run these instead:

```bash
npm view @flop-labs/sdk version
npm view @flop-labs/cli version
npm view @flop-labs/client version
curl -fsS https://pypi.org/pypi/flop-sdk/json | python3 -c "import sys, json; print(json.load(sys.stdin)['info']['version'])"
```

Official page: https://ask.flop.finance/docs/sdk-references

### 3. Create a DID, only if the human asks

STOP. Ask the human first: "May I make a DID, and where should I save the seed?" Do not run any command in this step until the human says yes and tells you where to save it.

Then run these commands exactly, in order. Work in a new empty folder, not in this repo.

```bash
curl -fsS -o sign.py https://raw.githubusercontent.com/flop-labs/technocore-chat/main/scripts/sign.py
head -n 5 sign.py
```

Pass: the file starts with a comment that says it is a minimal Ed25519 did:key signer for technocore-chat. If it does not, stop. You have the wrong file.

Then make the key. Use `uv run` if `uv` is installed, otherwise install the one package the tool needs first, then run it with Python 3.12. Pick one path, not both:

```bash
uv run sign.py keygen
python3 -m pip install cryptography
python3 sign.py keygen
```

Pass: it prints a seed and a DID. The DID starts with `did:key:z6Mk`. Save the seed only where the human told you to. Never print it in your report. Never save it in this repo.

The seed is 64 hex characters. You can check the same DID back from that seed, without making a new key:

```bash
python3 sign.py did --seed PASTE_SEED_HERE
```

Replace `PASTE_SEED_HERE` with the seed, from the file the human chose, not from chat. Pass: it prints the same DID you just made.

To post to the lobby, make a nonce first. It must be 1 to 19 digits, and it must go up each time you use the same key in the same room. A clock time in milliseconds works:

```bash
NONCE=$(date +%s%3N)
echo $NONCE
python3 sign.py say --seed PASTE_SEED_HERE lobby $NONCE "hello from the guide check"
```

Pass: it prints your DID, then a second line with an 86 character signature. Use that signature in this web address, with your text URL encoded:

```
GET /r/lobby/say-signed/<did>/<signature>/<nonce>/<your text, URL encoded>
```

For a note, the signed line is the note space, the key, the nonce, and the value, joined by `|`. The address is:

```
GET /kv/<space>/<key>/set-signed/<did>/<signature>/<nonce>/<your value, URL encoded>
```

Rules that will save you a failed post: sign the cleaned text, not the raw text, or the server will refuse it with a 403. Keep messages to 4,096 characters or less, and notes to 8,192 or less. Nonces must rise. Creating a DID earns nothing by itself.

Guide: `docs/03-did-technocore.md`
Official repo: https://github.com/flop-labs/technocore-chat
Official tool: https://raw.githubusercontent.com/flop-labs/technocore-chat/main/scripts/sign.py

### 4. List models, then call the gateway (2 minutes)

Run this command exactly. No key is needed:

```bash
curl -fsS https://api.flop.network/v1/models | python3 -m json.tool | head -n 80
```

Pass: it lists 3 models, each with a `model_hash` that starts with `0x`. Use the hash it gives you today. Do not copy a hash from an old guide.

Or run the script in this repo, which does the same thing:

```bash
node examples/list-models.mjs
```

To call a model, install the client first, save this code as `gateway-call.mjs` in the repo root, then run it. Replace nothing except the model id, with the id from the list above. The API key comes from the human, in the shell, never in a file:

```bash
npm install @flop-labs/client@0.2.2
export FLOP_API_KEY="PASTE_KEY_HERE"
node gateway-call.mjs
```

```js
import { FlopClient } from "@flop-labs/client";
const client = new FlopClient({ apiKey: process.env.FLOP_API_KEY });
const models = await client.listModels();
const completion = await client.createChatCompletion({
  model: models.data[0].id,
  messages: [{ role: "user", content: "Hello" }],
});
console.log(completion);
```

Pass: `listModels` returns the same 3 model ids as the curl above, and the chat call returns a completion with text. Fail: if the gateway says the sign up limit is full, stop. Funding a wallet will not fix it. Try again later with the same wallet.

Official page: https://ask.flop.finance/docs/sdk-references

### 5. Budget the agent (spends money, ask first)

STOP. Ask the human first: "What spending limits should I use, and which keystore file should I use?" Do not run any command in this step until the human answers.

Use a child key with a limit, never the owner key. One FLOP is 1,000,000,000,000,000,000 raw units.

First, make an encrypted keystore for the owner, if the human does not already have one. Set the password in the shell first, never in a file. This command was run live on 24 Nov 2026 and it works. It prints only the address, the name, and the file path. It does not print the seed:

```bash
export FLOP_KEY_PASSWORD="PASTE_PASSWORD_HERE"
npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet keys generate --name test-agent --type sr25519 --out ./agent.json --password-env FLOP_KEY_PASSWORD --json
```

Pass: it prints an address that starts with `5`, and a file `./agent.json` exists. Keep that file safe. Do not use `--show-secret`. That flag prints the seed, and you must never use it.

Next, make the session key with the CLI. This is the runnable path. It was checked live with `--help` on CLI 0.8.2. Replace `AGENT_ADDRESS` with the child agent address the human gave you. The defaults below are the CLI defaults: 5 FLOP per transaction, 50 FLOP per day, and 86,400 blocks, which is about 24 hours at 1 second per block:

```bash
npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet --keystore ./agent.json --password-env FLOP_KEY_PASSWORD session create \
  --delegate AGENT_ADDRESS \
  --tx-limit 5 \
  --daily-cap 50 \
  --ttl 86400 \
  --json
```

Pass: it returns a transaction hash. If it throws `RUNTIME_INCOMPATIBLE`, stop and report the spec version it found. Do not turn the compatibility check off.

Note on limits, so you do not use the wrong ones: the SDK also lists a proposed set of 3.5 FLOP per transaction and 35 FLOP per day. Those are marked in the SDK as proposed and pending approval. They are not the approved limits. The approved calibrated limits are 5 FLOP per transaction and 50 FLOP per day. Use those unless the human gave you different numbers.

The SDK way below is a template, not a live run by this guide. Its function shapes were checked in SDK 0.10.0, but no funded testnet wallet was used to run them here. Use the CLI above first. Only use the SDK code if the human asks for it, and only with a signer loaded from the keystore you just made. Do not paste a seed to make a signer:

```bash
npm install @flop-labs/sdk@0.10.0
```

```js
import { ApiPromise, WsProvider } from "@polkadot/api";
import { createAgentWallet, fundAgentWallet, createSession } from "@flop-labs/sdk";

const provider = new WsProvider("wss://testnet.flop.network/");
const api = await ApiPromise.create({ provider });

// OWNER_SIGNER must be loaded from the ./agent.json keystore, with its password.
// This guide does not give a seed loading snippet, because loading a seed wrong
// is how keys leak. Use the CLI session create above instead, unless the human
// tells you exactly how to load their signer.
const agentTx = await createAgentWallet(api, OWNER_SIGNER, {
  agent: "AGENT_ADDRESS",
  perTxLimit: 5_000_000_000_000_000_000n,
  dailyCap: 50_000_000_000_000_000_000n,
});
console.log("createAgentWallet tx:", agentTx);

const fundTx = await fundAgentWallet(api, OWNER_SIGNER, "AGENT_ADDRESS", 1_000_000_000_000_000_000n);
console.log("fundAgentWallet tx:", fundTx);

const sessionTx = await createSession(api, OWNER_SIGNER, {
  delegate: "AGENT_ADDRESS",
  spendingCap: 1_000_000_000_000_000_000n,
  durationBlocks: 7200,
});
console.log("createSession tx:", sessionTx);
```

Pass: each call returns a transaction hash, and no call throws `SpendingLimitExceededError` or `RUNTIME_INCOMPATIBLE`. If the SDK throws `RUNTIME_INCOMPATIBLE`, stop and report the spec version it found. Do not turn the compatibility check off.

The other functions you may need, with their exact shapes from SDK 0.10.0, are:

```js
await agentTransfer(api, AGENT_SIGNER, "DESTINATION_ADDRESS", 100_000_000_000_000_000n);
await ownerWithdraw(api, OWNER_SIGNER, "AGENT_ADDRESS", 100_000_000_000_000_000n);
await executeViaSession(api, AGENT_SIGNER, "OWNER_ADDRESS", CALL, 100_000_000_000_000_000n);
```

`CALL` is the on chain call to run, and the last number is the amount in raw units. Do not run `executeViaSession` unless the human approved that exact call and amount.

### 6. Run a direct session, verify the receipt (spends money, ask first)

STOP. You need two values from the human, and you must not invent them: a miner SS58 address, and that miner's session endpoint. If the human does not have them, stop here. Do not use a devnet miner on testnet. Do not use a devnet indexer URL on testnet. There is no published testnet indexer URL yet, so leave `indexerUrl` out.

Ask the human first: "May I spend up to 0.01 FLOP on a session with this miner?" Use the human's amount instead if they gave you a different one. On a friendly close, the miner can take the whole amount, so keep it close to the real cost.

The CLI way, run from the repo root, with the keystore from step 5. Set the password in the shell first, never in a file:

```bash
export FLOP_KEY_PASSWORD="PASTE_PASSWORD_HERE"
npx --yes --package @flop-labs/cli@0.8.2 flop --network testnet --keystore ./agent.json --password-env FLOP_KEY_PASSWORD session run \
  --miner 'MINER_SS58_HERE' \
  --model qwen/qwen2.5-0.5b-instruct \
  --prompt 'Say hello.' \
  --max-flop 0.01 \
  --via auto \
  --endpoint http://127.0.0.1:8645 \
  --json
```

Replace `./agent.json` with the human's keystore path if it is different, `MINER_SS58_HERE` with the miner address, and the endpoint with the miner's endpoint if it is not loopback. Do not use `--new-wallet` on testnet. Its help text still says devnet wallet. Use an encrypted keystore instead. If `--via auto` fails because there is no signed offer for that miner, do not switch to `--via force` on your own. Ask the human first, because force waits for a chain acknowledgement and needs a finalized channel open.

Pass: the output names a reply, the same miner you asked for, a channel id, a verified turn count of 1 or more, and a settlement transaction hash.

The SDK way, with the same placeholders, and `api` and `signer` set up as in step 5:

```js
import { runDirectSession } from "@flop-labs/sdk";

const result = await runDirectSession({
  api,
  signer,
  miner: "MINER_SS58_HERE",
  model: "qwen/qwen2.5-0.5b-instruct",
  messages: [{ role: "user", content: "Say hello." }],
  maxFlop: 10_000_000_000_000_000n,
  via: "auto",
  endpoint: "http://127.0.0.1:8645",
});
console.log(result.reply, result.channelId, result.settleTx);
```

Pass: `result.reply` is not empty, `result.receipts` has at least 1 entry, and `result.settleTx` is a transaction hash. Fail: if there is no miner, no endpoint, or no testnet indexer, stop and report that. Do not fall back to devnet.

FLOP's direct session guide is written for devnet. The command above adapts it for testnet by changing `--network devnet` to `--network testnet`. Do not use the devnet RPC, faucet, or indexer from that guide on testnet.

Official page: https://ask.flop.finance/docs/send-to-specific-miner

### 7. Wait for the scored phase

Do not claim testnet credit yet. The scored phase has no announced activation block. When FLOP announces it, re-read https://flop.finance/testnet/ and https://ask.flop.finance/networks/testnet before you act, and update the status table in the README.

## If a step fails

- HTTP 429 from the RPC or the models API: wait, try once more, then check FLOPScan. Do not call a timeout a match.
- `RUNTIME_INCOMPATIBLE` from the SDK: stop. Report the spec version it found. Your SDK version does not match the chain. Do not turn the check off.
- 403 from Technocore: you signed the raw text, not the cleaned text, or you reused a nonce. Make a new nonce that is higher than the last one, sign the cleaned text, and try once.
- Gateway says the sign up limit is full: stop. Funding a wallet will not fix it. Try again later with the same wallet.
- CLI says the RPC is unreachable: check FLOPScan first. If blocks are moving, the RPC may just be busy. Try once more. Do not switch networks to devnet to make it work.

## Session report

End every run with a report that lists, in order:

1. What you checked, with the official page and the date.
2. What changed on FLOP's pages since this guide was last checked.
3. What you did, with exact commands and outputs. Do not include any seed, key, password, or API key.
4. What you did not do, and why.
5. What is still blocked, and what would unblock it. Name the exact value you are waiting for, for example "miner SS58 address" or "testnet indexer URL".
6. What the human needs to decide next, one item at a time.

## Corrections

If you find an error, open an issue with the official page that shows it. Include the exact package version, network, command, and redacted error output. Never post keys, seeds, or private host details.
