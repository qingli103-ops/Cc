"""Fetch market caps via yfinance and write data.json for the web app."""

from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path

import yfinance as yf

CANDIDATES = [
    ("AAPL", "Apple"),
    ("MSFT", "Microsoft"),
    ("NVDA", "NVIDIA"),
    ("GOOGL", "Alphabet (Google)"),
    ("AMZN", "Amazon"),
    ("META", "Meta Platforms"),
    ("BRK-B", "Berkshire Hathaway"),
    ("TSLA", "Tesla"),
    ("LLY", "Eli Lilly"),
    ("AVGO", "Broadcom"),
    ("JPM", "JPMorgan Chase"),
    ("V", "Visa"),
    ("WMT", "Walmart"),
    ("XOM", "ExxonMobil"),
    ("UNH", "UnitedHealth Group"),
    ("MA", "Mastercard"),
    ("PG", "Procter & Gamble"),
    ("JNJ", "Johnson & Johnson"),
    ("HD", "Home Depot"),
    ("ORCL", "Oracle"),
    ("COST", "Costco"),
    ("ABBV", "AbbVie"),
    ("BAC", "Bank of America"),
    ("KO", "Coca-Cola"),
    ("CVX", "Chevron"),
    ("NFLX", "Netflix"),
    ("CRM", "Salesforce"),
    ("AMD", "AMD"),
    ("TMO", "Thermo Fisher Scientific"),
    ("MRK", "Merck"),
]


def fetch_market_cap(ticker: str) -> int | None:
    info = yf.Ticker(ticker).info
    cap = info.get("marketCap")
    return int(cap) if cap else None


def main() -> None:
    companies = []
    for ticker, name in CANDIDATES:
        try:
            cap = fetch_market_cap(ticker)
            print(f"{ticker:6s} {name:30s} {cap}")
            companies.append({"ticker": ticker, "name": name, "market_cap": cap})
        except Exception as exc:
            print(f"{ticker:6s} {name:30s} ERROR: {exc}")
            companies.append({"ticker": ticker, "name": name, "market_cap": None})

    payload = {
        "updated_at": datetime.now(timezone.utc).isoformat(),
        "companies": companies,
    }
    out = Path(__file__).parent / "data.json"
    out.write_text(json.dumps(payload, indent=2))
    print(f"\nWrote {out}")


if __name__ == "__main__":
    main()
