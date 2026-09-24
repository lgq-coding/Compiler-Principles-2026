#!/usr/bin/env bash
set -euo pipefail

BINUTILS_DIR="${BINUTILS_DIR:-$HOME/.local/opt/riscv-binutils-2.42/driver-bin}"

echo "== llvm-as =="
llvm-as --version | head -n 1
echo "== llc =="
llc --version | head -n 1
llc --version | awk '$1 == "riscv64" { print }'
echo "== riscv gcc =="
riscv64-unknown-elf-gcc --version | head -n 1
riscv64-unknown-elf-gcc -dumpmachine
riscv64-unknown-elf-gcc -print-multi-directory
echo "== riscv linker =="
"$BINUTILS_DIR/ld" --version | head -n 1
echo "== qemu =="
qemu-riscv64 --version | head -n 1
