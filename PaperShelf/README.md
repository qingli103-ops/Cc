# PaperShelf

A single-file browser app to **organize and read your downloaded PDF papers from a local folder** on Windows.

## Requirements

**Chrome or Edge on Windows** (uses the File System Access API — not available in Firefox).

## How to use

1. Open `PaperShelf/index.html` in Chrome or Edge.
2. Click **Choose folder** and pick the folder where you save downloaded PDFs (e.g. `Downloads\Papers`).
3. PaperShelf scans the folder, auto-reads title/authors/year from each PDF, and shows a card grid.
4. **Click a card** to open the paper — the PDF appears inline in a split view, with an editable panel on the right for title, authors, year, category, tags, and notes.
5. **Rescan** any time to pick up newly downloaded papers.

## What it does

- **Reads PDFs directly from your folder** — nothing is copied, uploaded, or moved. Files stay where they are.
- **Auto-extracts metadata**: title (from embedded info or the largest-font text on page 1), authors, and year (most-frequent plausible year in the first two pages). Correct anything in the details panel.
- **Categories** in the sidebar with live counts. Starts with *To read*, *Methods / protocols*, *Key references* — add your own.
- **Tags, notes, search** across title/author/tags/notes.
- **Persists your edits** (titles, categories, tags, notes) in browser storage (IndexedDB), keyed by filename. The PDFs themselves are never touched.
- On return visits: if the browser still has permission, the folder reconnects automatically. If not, one click re-grants it.

## Notes

- Metadata detection is heuristic; academic PDFs vary. Titles usually land well; authors are often missing and quick to fill in.
- The app needs an internet connection the first time for the PDF.js CDN (used for metadata extraction). Reading PDFs uses the browser's native viewer and works offline after that.
- Categories and notes are per-browser-profile. Renaming a PDF file breaks its link to saved metadata.
