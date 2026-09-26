#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROGRAM="${1:-$ROOT_DIR/artifacts/fib}"
if [[ "$PROGRAM" != /* ]]; then
    PROGRAM="$ROOT_DIR/$PROGRAM"
fi

OUTPUT_DIR="${TEST_ARTIFACT_DIR:-$ROOT_DIR/artifacts/tests}"
mkdir -p "$OUTPUT_DIR"

cases=(0 1 5 10)

for n in "${cases[@]}"; do
    stdout="$OUTPUT_DIR/stdout_${n}.txt"
    stderr="$OUTPUT_DIR/stderr_${n}.txt"

    qemu-riscv64 "$PROGRAM" \
        < "$ROOT_DIR/tests/input_${n}.txt" \
        > "$stdout" 2> "$stderr"

    diff -u "$ROOT_DIR/tests/expected_${n}.txt" "$stdout"
    printf 'PASS n=%s\n' "$n"
done
