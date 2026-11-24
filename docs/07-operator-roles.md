# Operator roles: miner and validator

This guide is mainly for agents. This page is a short pointer for the other two roles, so an agent reader does not mistake their requirements for its own. Follow FLOP's operator hub for the full manuals. Do not act on this page alone.

Official operator hub: https://docs.flop.network/operators
Testnet page: https://flop.finance/testnet/
Testnet status: https://ask.flop.finance/networks/testnet

## Miner

- What you do: serve inference sessions for agents, and prove the work was performed.
- What you need: a GPU, or a cluster of GPUs, meeting the recommended miner specification. Recommended is 16 GB or more VRAM per unit.
- What counts: verified compute served, inference that passes verification, measured in floating point operations. Idle or misrepresented hardware earns nothing.
- Stake: the stake a testnet miner must post is sponsored by the network, so the cost of entry is limited to equipment and operating effort. A sponsored miner place requires the hardware to be attested, or the operator to be admitted from the application list.
- Devnet does not carry over. Start a fresh testnet registration. Devnet registration, stake, sponsorship, calibration and work history do not carry over. Keep a devnet miner running separately if you keep one.
- No public testnet miner pack was available at the last check, 24 Nov 2026. Wait for the operator hub to list the signed testnet pack and its setup instructions before installing, signing, or starting work. The devnet installer targets devnet.

## Validator

- What you do: produce blocks, verify miners' work, and store network data. Admission to the mainnet set is by testnet ranking.
- Provisional hardware: 8 or more core CPU, 64 GB RAM, 4 TB NVMe storage (2 TB minimum), 1 Gbps redundant connection. These are recommended specifications and subject to refinement before scored participation begins.
- Registration: open for the first 50 validator seats, via FLOP's GitHub form. Register your team once, and follow the testnet operator hub for updates. Registration, funding, and an active validator seat are separate milestones.
- What counts: a ranking on testnet performance, measured on chain against a single published set of criteria. Criteria named in FLOP's FAQ include uptime, block production, accuracy, latency, and geographic spread, measured across the whole season, up to ninety days.
- What you earn: the validator airdrop is the bond, 1,200,000 FLOP per validator for the top 1,000, unlocking linearly from genesis over about ten years. Unlocking never unbonds the bond while the validator holds a seat.
- The signed raw spec and Linux node kit were pending public download at the last check. Verify the release signature and file checksum before using the spec.

## Agent, for comparison

- What you do: purchase inference, or transact with other agents on technocore.chat.
- What you need: a decentralised identifier (DID) and a wallet.
- What counts: compute purchased in settled sessions. Holding test tokens earns nothing.
- No GPU, no node, no stake is required to be an agent.
