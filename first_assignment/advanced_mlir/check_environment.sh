#!/usr/bin/env bash
set -euo pipefail

VENV_PYTHON="${VENV_PYTHON:-$HOME/.venvs/ascendnpuir/bin/python}"
if [[ -x "$VENV_PYTHON" ]]; then
    SITE_PACKAGES="$("$VENV_PYTHON" -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')"
else
    SITE_PACKAGES="$HOME/.venvs/ascendnpuir/lib/python3.12/site-packages"
fi
BISHENGIR_BIN="${BISHENGIR_BIN:-$SITE_PACKAGES/ascendnpuir/bin}"
BISHENGIR_OPT="$BISHENGIR_BIN/bishengir-opt"
BISHENGIR_COMPILE="$BISHENGIR_BIN/bishengir-compile"

echo "== Ninja =="
ninja --version

echo "== CMake =="
cmake --version | head -n 1

echo "== Clang =="
clang --version | head -n 1

echo "== bishengir-opt =="
if [[ -x "$BISHENGIR_OPT" ]]; then
    "$BISHENGIR_OPT" --version | sed 's/[[:space:]]\+$//'
else
    echo "missing: $BISHENGIR_OPT"
fi

echo "== bishengir-compile =="
if [[ -x "$BISHENGIR_COMPILE" ]]; then
    "$BISHENGIR_COMPILE" --version | sed 's/[[:space:]]\+$//'
else
    echo "missing: $BISHENGIR_COMPILE"
fi

echo "== Python binding =="
if [[ -x "$VENV_PYTHON" ]]; then
    "$VENV_PYTHON" - <<'PY'
import ascendnpuir
print("version:", ascendnpuir.__version__)
print("module:", ascendnpuir.__file__)
PY
else
    echo "missing virtual environment: $VENV_PYTHON"
fi

echo "== optional hivmc =="
if command -v hivmc >/dev/null 2>&1; then
    command -v hivmc
    hivmc --version | head -n 1
else
    echo "missing"
fi

echo "== optional CANN =="
if [[ -n "${ASCEND_HOME_PATH:-}" ]]; then
    echo "ASCEND_HOME_PATH=$ASCEND_HOME_PATH"
elif [[ -d /usr/local/Ascend ]]; then
    echo "found /usr/local/Ascend"
else
    echo "missing"
fi

echo "== optional NPU device nodes =="
if compgen -G '/dev/davinci*' >/dev/null; then
    ls -l /dev/davinci*
else
    echo "missing"
fi
