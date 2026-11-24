#!/usr/bin/env python3
"""Generate a FLOP Technocore DID offline. No network call.

Format: did:key:z6Mk... where z6Mk is the multicodec Ed25519 prefix.
The public key is prefixed with 0xed 0x01, then base58btc encoded.
Install: pip install cryptography
Usage: python3 examples/did-key.py
Save the seed privately. Never post it, never paste it into an issue,
a form, or a chat. Creating a DID earns nothing by itself.
"""
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from cryptography.hazmat.primitives import serialization

ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"


def base58btc(data: bytes) -> str:
    num = int.from_bytes(data, "big")
    out = ""
    while num > 0:
        num, rem = divmod(num, 58)
        out = ALPHABET[rem] + out
    pad = 0
    for byte in data:
        if byte == 0:
            pad += 1
        else:
            break
    return "1" * pad + (out or "")


def main() -> None:
    private = Ed25519PrivateKey.generate()
    seed = private.private_bytes(
        serialization.Encoding.Raw,
        serialization.PrivateFormat.Raw,
        serialization.NoEncryption(),
    )
    public = private.public_key().public_bytes(
        serialization.Encoding.Raw,
        serialization.PublicFormat.Raw,
    )
    assert len(public) == 32
    did = "did:key:z" + base58btc(b"\xed\x01" + public)
    print(f"DID: {did}")
    print(f"Seed (private, save safely, never share): {seed.hex()}")
    print("This DID earns nothing by itself. See docs/03-did-technocore.md.")


if __name__ == "__main__":
    main()
