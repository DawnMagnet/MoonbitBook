# Build scripts

This folder contains a small helper to build the book into a single Markdown and optionally convert it to PDF.

Usage (from repository root):

```bash
chmod +x scripts/build_book.sh
./scripts/build_book.sh
```

What it does:

- Reads `toc.md` and extracts `.md` filenames in backticks (unique, in-order).
- Concatenates those files into `build/MoonBitBook.md` (inserting `---` between chapters).
- Converts the combined Markdown to PDF using `pandoc` (if available), output: `build/MoonBitBook.pdf`.

Requirements:

- `pandoc` (optional, required to create PDF)
- `xelatex` (for PDF engine; optional if you use another engine)

Notes:

- The script converts each chapter's top-level `#` heading to `##` except the first file to produce a single H1 for the whole book.
- If the TOC references files not present on disk, the script warns and skips them.
