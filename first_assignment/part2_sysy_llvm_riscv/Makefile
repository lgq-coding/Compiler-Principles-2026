CC = riscv64-unknown-elf-gcc
LLVM_AS = llvm-as
LLC = llc
OPT = opt

ROOT_DIR := ../..
LIB_DIR := $(ROOT_DIR)/lib
OUT_DIR := artifacts
TEST_DIR := tests

# The supplied SysY runtime uses ISA attributes newer than the SiFive
# binutils 2.35 shipped with the original toolchain. Use the user-local
# GNU binutils 2.42 for assembly and linking.
BINUTILS_PREFIX ?= $(HOME)/.local/opt/riscv-binutils-2.42/usr
BINUTILS_DIR ?= $(HOME)/.local/opt/riscv-binutils-2.42/driver-bin
BINUTILS_B := -B$(BINUTILS_DIR)/
BINUTILS_READELF := $(BINUTILS_PREFIX)/bin/riscv64-unknown-elf-readelf
BINUTILS_OBJDUMP := $(BINUTILS_PREFIX)/bin/riscv64-unknown-elf-objdump

LLC_FLAGS := -march=riscv64 -mattr=+m,+a,+f,+d -filetype=obj
ASM_MARCH := rv64imafdc_zicsr_zmmul
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
	$(BINUTILS_READELF) -h -A $(OUT_DIR)/sysy_demo \
	  | sed 's/[[:space:]]\+$$//' >> $(OUT_DIR)/executable_info.txt
	$(BINUTILS_PREFIX)/bin/riscv64-unknown-elf-nm $(OUT_DIR)/sysy_demo \
	  | grep -E ' (main|is_even|gcd|getint|putint|putch)$$' \
	  >> $(OUT_DIR)/executable_info.txt
	$(BINUTILS_OBJDUMP) -d $(OUT_DIR)/sysy_demo > $(OUT_DIR)/disassembly.txt

asm-inspect: $(OUT_DIR)/sysy_demo_asm.o
	$(BINUTILS_READELF) -h -A -s $< \
	  | sed 's/[[:space:]]\+$$//' > $(OUT_DIR)/sysy_demo_asm_readelf.txt
	$(BINUTILS_OBJDUMP) -dr $< > $(OUT_DIR)/sysy_demo_asm_objdump.txt

environment:
	./environment.sh > $(OUT_DIR)/environment.txt

test: verify

$(OUT_DIR):
	mkdir -p $@

$(OUT_DIR)/sysy_demo.bc: sysy_demo.ll | $(OUT_DIR)
	$(LLVM_AS) $< -o $@

$(OUT_DIR)/sysy_demo.o: $(OUT_DIR)/sysy_demo.bc
	$(LLC) $(LLC_FLAGS) $< -o $@

$(OUT_DIR)/sysy_demo: $(OUT_DIR)/sysy_demo.o
	$(CC) $(BINUTILS_B) $< -o $@ \
	  -L$(LIB_DIR) -lsysy_riscv \
	  $(LDFLAGS) $(LINK_FLAGS)

$(OUT_DIR)/sysy_demo_asm.o: sysy_demo_asm.s | $(OUT_DIR)
	$(CC) $(BINUTILS_B) -march=$(ASM_MARCH) -c $< -o $@

$(OUT_DIR)/sysy_demo_asm: $(OUT_DIR)/sysy_demo_asm.o
	$(CC) $(BINUTILS_B) $< -o $@ \
	  -L$(LIB_DIR) -lsysy_riscv \
	  $(LDFLAGS) $(LINK_FLAGS)

clean:
	$(RM) -r $(OUT_DIR)
