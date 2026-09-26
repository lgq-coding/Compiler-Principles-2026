#!/usr/bin/env bash
set -euo pipefail

echo "== riscv gcc =="
riscv64-unknown-elf-gcc --version | head -n 1
riscv64-unknown-elf-gcc -dumpmachine
riscv64-unknown-elf-gcc -print-multi-directory
echo "== riscv assembler =="
riscv64-unknown-elf-as --version | head -n 1
echo "== riscv linker =="
riscv64-unknown-elf-ld --version | head -n 1
echo "== qemu =="
qemu-riscv64 --version | head -n 1
