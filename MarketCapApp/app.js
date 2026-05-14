const formatMarketCap = (value) => {
  if (value == null || Number.isNaN(value)) return "—";
  const tiers = [
    { limit: 1e12, suffix: "T" },
    { limit: 1e9, suffix: "B" },
    { limit: 1e6, suffix: "M" },
  ];
  for (const { limit, suffix } of tiers) {
    if (value >= limit) return `$${(value / limit).toFixed(2)}${suffix}`;
  }
  return `$${value.toLocaleString()}`;
};

const render = (data) => {
  const rowsEl = document.getElementById("rows");
  const tableEl = document.getElementById("table");
  const metaEl = document.getElementById("meta");

  const sorted = [...data.companies]
    .filter((c) => typeof c.market_cap === "number")
    .sort((a, b) => b.market_cap - a.market_cap)
    .slice(0, 20);

  rowsEl.innerHTML = sorted
    .map(
      (c, i) => `
        <tr>
          <td class="rank">${i + 1}</td>
          <td>${c.name}</td>
          <td><code>${c.ticker}</code></td>
          <td class="num">${formatMarketCap(c.market_cap)}</td>
        </tr>
      `,
    )
    .join("");

  const updated = data.updated_at
    ? new Date(data.updated_at).toLocaleString()
    : "unknown";
  metaEl.textContent = `Last updated: ${updated}`;
  tableEl.hidden = false;
};

const showError = (msg) => {
  const el = document.getElementById("error");
  el.textContent = msg;
  el.hidden = false;
  document.getElementById("meta").textContent = "";
};

fetch("data.json", { cache: "no-store" })
  .then((r) => {
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    return r.json();
  })
  .then(render)
  .catch((err) =>
    showError(
      `Could not load data.json (${err.message}). Run "python update_data.py" to generate it.`,
    ),
  );
