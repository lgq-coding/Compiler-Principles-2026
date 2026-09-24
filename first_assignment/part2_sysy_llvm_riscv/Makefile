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
# GNU binutils 2.42 for the link step.
BINUTILS_DIR ?= $(HOME)/.local/opt/riscv-binutils-2.42/driver-bin
BINUTILS_B := -B$(BINUTILS_DIR)/

LLC_FLAGS := -march=riscv64 -mattr=+m,+a,+f,+d -filetype=obj
LDFLAGS := -static -mcmodel=medany
LINK_FLAGS := -Wl,--no-relax,-Ttext=0x90000000

.PHONY: all verify inspect environment test clean

all: $(OUT_DIR)/sysy_demo

verify: $(OUT_DIR)/sysy_demo
	$(OPT) -passes=verify sysy_demo.ll -disable-output
	./run_tests.sh

inspect: all
	file $(OUT_DIR)/sysy_demo > $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-readelf -h -A $(OUT_DIR)/sysy_demo \
	  | sed 's/[[:space:]]\+$$//' >> $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-nm $(OUT_DIR)/sysy_demo \
	  | grep -E ' (main|is_even|gcd|getint|putint|putch)$$' \
	  >> $(OUT_DIR)/executable_info.txt
	riscv64-unknown-elf-objdump -d $(OUT_DIR)/sysy_demo > $(OUT_DIR)/disassembly.txt

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

clean:
	$(RM) -r $(OUT_DIR)
