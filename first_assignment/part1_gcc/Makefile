CC = riscv64-unknown-elf-gcc

ROOT_DIR := ../..
LIB_DIR := $(ROOT_DIR)/lib
OUT_DIR := artifacts

CPPFLAGS :=
CFLAGS := -O0 -g -fno-pic -mcmodel=medany

.PHONY: all preprocess compile optimized dumps toolchain clean

all: preprocess compile optimized

preprocess: $(OUT_DIR)/fib.i

compile: $(OUT_DIR)/fib.s

optimized: $(OUT_DIR)/fib.O2.s

dumps: $(OUT_DIR)/fib.c.original \
       $(OUT_DIR)/fib.c.gimple \
       $(OUT_DIR)/fib.c.rtl-expand \
       $(OUT_DIR)/fib.c.rtl-final

toolchain:
	$(CC) --version > $(OUT_DIR)/toolchain.txt
	$(CC) -dumpmachine >> $(OUT_DIR)/toolchain.txt
	$(CC) -print-multi-directory >> $(OUT_DIR)/toolchain.txt
	$(CC) -print-libgcc-file-name >> $(OUT_DIR)/toolchain.txt

$(OUT_DIR):
	mkdir -p $@

$(OUT_DIR)/fib.i: fib.c | $(OUT_DIR)
	$(CC) -E $(CPPFLAGS) $< -o $@

$(OUT_DIR)/fib.s: fib.c | $(OUT_DIR)
	$(CC) -S $(CPPFLAGS) $(CFLAGS) $< -o $@

$(OUT_DIR)/fib.O2.s: fib.c | $(OUT_DIR)
	$(CC) -S $(CPPFLAGS) -O2 -fno-pic -mcmodel=medany $< -o $@

$(OUT_DIR)/fib.c.original: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fdump-tree-original -S $< -o /dev/null
	mv fib.c.*t.original $@

$(OUT_DIR)/fib.c.gimple: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fdump-tree-gimple -S $< -o /dev/null
	mv fib.c.*t.gimple $@

$(OUT_DIR)/fib.c.rtl-expand: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fdump-rtl-expand -S $< -o /dev/null
	mv fib.c.*r.expand $@

$(OUT_DIR)/fib.c.rtl-final: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -fdump-rtl-final -S $< -o /dev/null
	mv fib.c.*r.final $@

clean:
	$(RM) -r $(OUT_DIR)
