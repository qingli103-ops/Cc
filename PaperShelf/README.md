# PaperShelf

A single-file, browser-based app to **organize and quickly read your downloaded PDF papers**, sorted into categories — built for a research/lab workflow.

## Use it

Open `index.html` in any modern browser (Chrome, Edge, Safari, Firefox). No install, no server, no account.

## What it does

- **Drag & drop PDFs** in (or click *Add PDFs*). Files are stored locally in your browser via IndexedDB — nothing is uploaded anywhere.
- **Auto-reads metadata** from each PDF on import: **title** (from the embedded info or the largest-font text on page 1), **authors** (when present), and **publication year** (most-frequent plausible year in the first two pages). You can correct any of it.
- **Categories** in the sidebar — create your own (starts with *To read*, *Methods / protocols*, *Key references*). Click a category to filter; counts update live.
- **Read inline**: click any paper to open a split view — PDF on the left, editable details on the right.
- **Tag, take notes, search** across titles, authors, tags and notes.
- **Sort** by recently added, year, title, or author.

## Notes & limits

- Everything lives in the browser profile you open it in. It is **per-browser, per-device** — clearing site data removes your library. (A future enhancement could add export/import to back the library up.)
- Metadata auto-detection is heuristic; academic PDFs vary a lot. Titles usually land well; authors are often missing and easy to fill in.
- An internet connection is needed the first time so the PDF.js library (used only for metadata extraction) loads from a CDN. Reading PDFs uses the browser's built-in viewer and works offline.

## Tech

Plain HTML/CSS/JavaScript, [PDF.js](https://mozilla.github.io/pdf.js/) for text/metadata extraction, IndexedDB for storage. No build step.
