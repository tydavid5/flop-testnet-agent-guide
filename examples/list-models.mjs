// List models from the FLOP public gateway. No API key needed for listing.
// Official source: https://ask.flop.finance/docs/sdk-references
// Default gateway base URL: https://api.flop.network/v1
// Checked live 24 Nov 2026 18:24 UTC: 3 models, all labelled devnet.
// Usage: node examples/list-models.mjs
// Requires Node.js 22 or later. No dependencies.
const res = await fetch("https://api.flop.network/v1/models");
if (!res.ok) {
  console.error(`Models API returned HTTP ${res.status}. Retry later.`);
  process.exit(1);
}
const body = await res.json();
console.log(`Total models: ${body.total_count}`);
for (const m of body.data) {
  const hash = m["x-flop"] ? m["x-flop"].model_hash : "unknown";
  console.log(`- ${m.id} | ${m.name} | model_hash ${hash}`);
}
console.log("Use the model_hash the gateway returns today. Do not copy a hash from an old guide.");
