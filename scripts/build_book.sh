#!/usr/bin/env bash
# Build script: collect chapters listed in `toc.md`, merge into one Markdown,
# then convert to PDF via pandoc.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOC="$ROOT_DIR/toc.md"
OUT_DIR="$ROOT_DIR/build"
OUT_MD="$OUT_DIR/MoonBitBook.md"
OUT_PDF="$OUT_DIR/MoonBitBook.pdf"

mkdir -p "$OUT_DIR"

echo "Building combined Markdown at $OUT_MD"
rm -f "$OUT_MD"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc not found. Install pandoc to enable PDF generation." >&2
  echo "You can still produce the combined Markdown at: $OUT_MD"
fi

# Extract .md filenames mentioned in backticks from toc.md in order, unique
mapfile -t files < <(grep -oP '`[^`]+\.md`' "$TOC" | tr -d '\`' | awk '!seen[$0]++')

if [ ${#files[@]} -eq 0 ]; then
  echo "No markdown files found in $TOC" >&2
  exit 1
fi

first=true
for f in "${files[@]}"; do
  fp="$ROOT_DIR/$f"
  if [ ! -f "$fp" ]; then
    # try relative to root without path
    if [ -f "$ROOT_DIR/$(basename "$f")" ]; then
      fp="$ROOT_DIR/$(basename "$f")"
    else
      echo "Warning: file referenced in TOC not found: $f" >&2
      continue
    fi
  fi

  echo "Adding: $fp"
  if $first; then
    # copy as-is
    cat "$fp" >> "$OUT_MD"
    first=false
  else
    # separator
    printf "\n\n---\n\n" >> "$OUT_MD"
    # convert first-line H1 -> H2 to avoid multiple H1 in combined doc
    awk 'NR==1 { if($0 ~ /^# /) { sub(/^# /, "## ") } print; next } { print }' "$fp" >> "$OUT_MD"
  fi
done

echo "Combined markdown written to: $OUT_MD"

if command -v pandoc >/dev/null 2>&1; then
  echo "Converting to PDF: $OUT_PDF"
  pandoc "$OUT_MD" --from=gfm --pdf-engine=xelatex --toc -V geometry:margin=1in -o "$OUT_PDF"
  echo "PDF generated at: $OUT_PDF"
else
  echo "pandoc not installed; skipping PDF generation." >&2
fi

echo "Done."
