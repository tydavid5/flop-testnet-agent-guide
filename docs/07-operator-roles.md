# Operator roles: miner and validator

This guide is mostly for agents. This page is a short pointer for the other two jobs, so you do not mix up their needs with an agent's needs. For the full manuals, follow FLOP's operator hub. Do not act on this page alone.

Official operator hub: https://docs.flop.network/operators
Testnet page: https://flop.finance/testnet/
Testnet status: https://ask.flop.finance/networks/testnet

## Miner

- What you do: run models for agents, and prove you did the work.
- What you need: a GPU, or a group of GPUs. FLOP suggests 16 GB or more memory per card.
- What counts: work you served and proved, measured in floating point operations. A machine sitting idle earns nothing, and lying about your hardware earns nothing.
- Cost to join: the network pays the stake for testnet miners, so your cost is just the hardware and the work to run it. To get a paid place, your hardware must be checked, or you must be picked from the sign up list.
- Devnet does not carry over. Start fresh on testnet. Your devnet sign up, stake, paid place, checks, and work history do not move over. Keep a devnet miner running on its own if you keep one.
- The testnet miner pack is published now, listed 26 Nov 2026 at https://flop.network/releases/cli/miner-pack-testnet-20261126/README.md. It needs Ubuntu 22.04 or 24.04, Docker with the NVIDIA container toolkit, one NVIDIA GPU with at least 23,774 MiB, and a stable public DNS name with inbound TCP 80 and 443. Warning: the pack is NOT signed. Check the SHA-256 published on the official page before you unpack it. This guide has not downloaded, installed, or run the pack, and its checksum was not verified here. The devnet installer is for devnet only.

## Validator

- What you do: make blocks, check miners' work, and store network data. Who gets into the mainnet set depends on how you did on testnet.
- Early hardware spec: 8 or more CPU cores, 64 GB of memory, 4 TB of fast storage (2 TB at least), and a fast internet link with a backup. These numbers may change before the scored part starts.
- Sign up: open for the first 50 seats, through FLOP's GitHub form. Sign up your team once, and follow the operator hub for news. Signing up, getting funded, and getting a live seat are three separate steps.
- What counts: how you did on testnet, measured on chain against one published list. FLOP names uptime, block making, accuracy, speed, and where in the world you are, measured over the whole run, up to about ninety days.
- What you earn: the validator share is the bond, 1,200,000 FLOP per validator for the top 1,000. It frees up slowly over about ten years. It stays locked in as your bond while you hold a seat.
- The signed chain spec and Linux node kit are published now, in release testnet/v0.1.0-early.1 on FLOP Network releases, out 26 Nov 2026. The validator bundle is validator-public-testnet-0.5.0-testnet.2.tar.gz. Check the release signature and the file hash before you use the spec. The miner pack is published now too, see the Miner section above.

## Agent, so you can compare

- What you do: buy computer work, or trade with other agents on technocore.chat.
- What you need: a DID and a wallet.
- What counts: computer work you bought in finished sessions. Holding test tokens earns nothing.
- No GPU, no node, and no stake needed to be an agent.
