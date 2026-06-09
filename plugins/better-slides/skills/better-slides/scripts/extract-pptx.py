#!/usr/bin/env python3
"""better-slides — extract content from a .pptx for conversion.

    python3 scripts/extract-pptx.py <input.pptx> <output_dir>

Writes:
  <output_dir>/content.md   — slide-by-slide text, notes, image references
  <output_dir>/assets/      — every embedded image, named slideNN-imgNN.<ext>

Requires python-pptx:  pip install python-pptx
The agent reads content.md, applies the Speaker Playbook to it (find the one
idea this deck is burying), then re-authors it on the better-slides engine.
"""
import sys
from pathlib import Path


def main() -> int:
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    try:
        from pptx import Presentation
    except ImportError:
        print("✗ python-pptx is required:  pip install python-pptx")
        return 1

    src, outdir = Path(sys.argv[1]), Path(sys.argv[2])
    if not src.is_file():
        print(f"✗ no such file: {src}")
        return 1
    assets = outdir / "assets"
    assets.mkdir(parents=True, exist_ok=True)

    prs = Presentation(str(src))
    lines = [f"# Extracted from {src.name}", ""]
    img_total = 0

    for n, slide in enumerate(prs.slides, 1):
        lines += [f"## Slide {n}", ""]
        imgs = 0
        for shape in slide.shapes:
            if shape.has_text_frame:
                for para in shape.text_frame.paragraphs:
                    text = "".join(r.text for r in para.runs).strip()
                    if text:
                        lines.append(("  " * para.level) + f"- {text}")
            if shape.shape_type == 13:  # PICTURE
                imgs += 1
                img_total += 1
                image = shape.image
                name = f"slide{n:02d}-img{imgs:02d}.{image.ext}"
                (assets / name).write_bytes(image.blob)
                lines.append(f"- ![image](assets/{name})")
        if slide.has_notes_slide:
            notes = slide.notes_slide.notes_text_frame.text.strip()
            if notes:
                lines += ["", f"> speaker notes: {notes}"]
        lines.append("")

    (outdir / "content.md").write_text("\n".join(lines), encoding="utf-8")
    print(f"✓ {len(prs.slides)} slides, {img_total} images → {outdir}/content.md")
    return 0


if __name__ == "__main__":
    sys.exit(main())
