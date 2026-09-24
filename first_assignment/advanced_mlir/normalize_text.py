#!/usr/bin/env python3
"""Normalize generated text output for stable Git diffs."""

from pathlib import Path
import sys


def main() -> int:
    for arg in sys.argv[1:]:
        path = Path(arg)
        if not path.is_file():
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        lines = [line.rstrip() for line in text.splitlines()]
        path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
