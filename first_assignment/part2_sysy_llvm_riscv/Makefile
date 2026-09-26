CC = riscv64-unknown-elf-gcc
AR = riscv64-unknown-elf-ar
LLVM_AS = llvm-as
LLC = llc
OPT = opt

ROOT_DIR := ../..
LIB_DIR := $(ROOT_DIR)/lib
OUT_DIR := artifacts
TEST_DIR := tests
RUNTIME_DIR := $(OUT_DIR)/sifive-runtime
RUNTIME_LIB := $(RUNTIME_DIR)/libsysy_riscv_sifive.a

LLC_FLAGS := -march=riscv64 -mattr=+m,+a,+f,+d -filetype=asm
LDFLAGS := -static -mcmodel=medany
LINK_FLAGS := -Wl,--no-relax,-Ttext=0x90000000

.PHONY: all verify verify-llvm verify-asm inspect asm-inspect environment test clean

all: $(OUT_DIR)/sysy_demo $(OUT_DIR)/sysy_demo_asm

verify: verify-llvm verify-asm

verify-llvm: $(OUT_DIR)/sysy_demo
	$(OPT) -passes=verify sysy_demo.ll -disable-output
	mkdir -p $(OUT_DIR)/tests
	TEST_ARTIFACT_DIR=$(OUT_DIR)/tests ./run_tests.sh $(OUT_DIR)/sysy_demo \
	  > $(OUT_DIR)/tests/reference_results.txt
	cat $(OUT_DIR)/tests/reference_results.txt

verify-asm: $(OUT_DIR)/sysy_demo_asm
	mkdir -p $(OUT_DIR)/tests_asm
	TEST_ARTIFACT_DIR=$(OUT_DIR)/tests_asm ./run_tests.sh $(OUT_DIR)/sysy_demo_asm \
	  > $(OUT_DIR)/tests_asm/results.txt
	cat $(OUT_DIR)/tests_asm/results.txt

inspect: all
	file $(OUT_DIR)/sysy_demo > $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-readelf -h -A $(OUT_DIR)/sysy_demo \
	  | sed 's/[[:space:]]\+$$//' >> $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-nm $(OUT_DIR)/sysy_demo \
	  | grep -E ' (main|is_even|gcd|getint|putint|putch)$$' \
	  >> $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-objdump -d $(OUT_DIR)/sysy_demo > $(OUT_DIR)/disassembly.txt

asm-inspect: $(OUT_DIR)/sysy_demo_asm.o
	riscv64-unknown-elf-readelf -h -A -s $< \
	  | sed 's/[[:space:]]\+$$//' > $(OUT_DIR)/sysy_demo_asm_readelf.txt
	riscv64-unknown-elf-objdump -dr $< > $(OUT_DIR)/sysy_demo_asm_objdump.txt

environment:
	./environment.sh > $(OUT_DIR)/environment.txt

test: verify

$(OUT_DIR):
	mkdir -p $@

$(RUNTIME_DIR):
	mkdir -p $@

$(OUT_DIR)/sysy_demo.bc: sysy_demo.ll | $(OUT_DIR)
	$(LLVM_AS) $< -o $@

$(OUT_DIR)/sysy_demo_llvm.s: $(OUT_DIR)/sysy_demo.bc
	$(LLC) $(LLC_FLAGS) $< -o $@
	./normalize_riscv_asm.py $@

$(OUT_DIR)/sysy_demo.o: $(OUT_DIR)/sysy_demo_llvm.s
	$(CC) -c $< -o $@

$(RUNTIME_DIR)/sylib.o: $(LIB_DIR)/sylib.c $(LIB_DIR)/sylib.h | $(RUNTIME_DIR)
	$(CC) -O2 -mcmodel=medany -fno-pic -I$(LIB_DIR) -c $< -o $@

$(RUNTIME_LIB): $(RUNTIME_DIR)/sylib.o
	$(AR) rcs $@ $<

$(OUT_DIR)/sysy_demo: $(OUT_DIR)/sysy_demo.o $(RUNTIME_LIB)
	$(CC) $(OUT_DIR)/sysy_demo.o -o $@ \
	  -L$(RUNTIME_DIR) -lsysy_riscv_sifive \
	  $(LDFLAGS) $(LINK_FLAGS)

$(OUT_DIR)/sysy_demo_asm.o: sysy_demo_asm.s | $(OUT_DIR)
	$(CC) -march=rv64imafdc -mabi=lp64d -c $< -o $@

$(OUT_DIR)/sysy_demo_asm: $(OUT_DIR)/sysy_demo_asm.o $(RUNTIME_LIB)
	$(CC) $(OUT_DIR)/sysy_demo_asm.o -o $@ \
	  -L$(RUNTIME_DIR) -lsysy_riscv_sifive \
	  $(LDFLAGS) $(LINK_FLAGS)

clean:
	$(RM) -r $(OUT_DIR)
