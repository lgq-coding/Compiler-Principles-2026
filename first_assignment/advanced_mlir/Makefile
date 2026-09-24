VENV_PYTHON ?= $(HOME)/.venvs/ascendnpuir/bin/python
BISHENGIR_BIN ?= $(shell $(VENV_PYTHON) -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])')/ascendnpuir/bin
BISHENGIR_OPT ?= $(BISHENGIR_BIN)/bishengir-opt
BISHENGIR_COMPILE ?= $(BISHENGIR_BIN)/bishengir-compile
OUT_DIR := artifacts

.PHONY: all check lower hivm verify device clean

all: lower hivm verify

check:
	./check_environment.sh

lower:
	mkdir -p $(OUT_DIR)
	$(BISHENGIR_OPT) vecadd_host_for_cpu.mlir \
	  --execution-engine-convert-hivm-to-upstream \
	  -o $(OUT_DIR)/vecadd_host_linalg.mlir
	./normalize_text.py $(OUT_DIR)/vecadd_host_linalg.mlir
	$(BISHENGIR_OPT) vecadd_host_for_cpu.mlir \
	  --lower-for-cpu-runner-pipeline='wrapper-name=main_wrapper' \
	  -o $(OUT_DIR)/vecadd_host_cpu_pipeline.mlir
	./normalize_text.py $(OUT_DIR)/vecadd_host_cpu_pipeline.mlir
	$(BISHENGIR_OPT) vecadd_host_for_cpu.mlir \
	  --lower-for-cpu-runner-pipeline='wrapper-name=main_wrapper' \
	  --dump-pass-pipeline -o /dev/null \
	  > $(OUT_DIR)/cpu_runner_pipeline.txt 2>&1

hivm:
	mkdir -p $(OUT_DIR)
	$(BISHENGIR_OPT) vecadd.mlir \
	  --hivm-infer-func-core-type \
	  -o $(OUT_DIR)/vecadd_hivm-infer-func-core-type.mlir
	./normalize_text.py $(OUT_DIR)/vecadd_hivm-infer-func-core-type.mlir
	$(BISHENGIR_OPT) $(OUT_DIR)/vecadd_hivm-infer-func-core-type.mlir \
	  --hivm-plan-memory \
	  -o $(OUT_DIR)/vecadd_hivm_core_plan.mlir
	./normalize_text.py $(OUT_DIR)/vecadd_hivm_core_plan.mlir
	$(BISHENGIR_OPT) $(OUT_DIR)/vecadd_hivm_core_plan.mlir \
	  --hivm-inject-sync \
	  -o $(OUT_DIR)/vecadd_hivm_sync.mlir
	./normalize_text.py $(OUT_DIR)/vecadd_hivm_sync.mlir

verify:
	test -s $(OUT_DIR)/vecadd_host_linalg.mlir
	test -s $(OUT_DIR)/vecadd_host_cpu_pipeline.mlir
	test -s $(OUT_DIR)/vecadd_hivm_sync.mlir
	grep -q 'linalg.add' $(OUT_DIR)/vecadd_host_linalg.mlir
	grep -q 'llvm.func @main_wrapper' $(OUT_DIR)/vecadd_host_cpu_pipeline.mlir
	grep -q 'hivm.hir.set_flag' $(OUT_DIR)/vecadd_hivm_sync.mlir
	grep -q 'hivm.hir.wait_flag' $(OUT_DIR)/vecadd_hivm_sync.mlir
	@echo 'PASS: MLIR lowering evidence verified'

# Requires hivmc and CANN. Kept as an explicit target because the current
# Python wheel does not bundle hivmc.
device:
	$(BISHENGIR_COMPILE) vecadd.mlir \
	  --target=Ascend910B1 \
	  --enable-hivm-compile \
	  -o $(OUT_DIR)/kernel.o

clean:
	$(RM) -r $(OUT_DIR)
