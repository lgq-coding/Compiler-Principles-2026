#!/usr/bin/env python3
"""Normalize LLVM RISC-V ISA attributes for the SiFive 10.2 assembler."""

from pathlib import Path
import sys


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} FILE", file=sys.stderr)
        return 2

    path = Path(sys.argv[1])
    compatible_attr = (
        '\t.attribute\t5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"'
    )
    lines = path.read_text(encoding="utf-8").splitlines()
    replaced = False

    for index, line in enumerate(lines):
        stripped = line.lstrip()
        if stripped.startswith(".attribute") and "5," in stripped:
            lines[index] = compatible_attr
            replaced = True

    if not replaced:
        print(f"{path}: RISC-V ISA attribute line not found", file=sys.stderr)
        return 1

    path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
