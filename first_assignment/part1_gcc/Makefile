CC = riscv64-unknown-elf-gcc
AR = riscv64-unknown-elf-ar

ROOT_DIR := ../..
LIB_DIR := $(ROOT_DIR)/lib
OUT_DIR := artifacts
RUNTIME_DIR := $(OUT_DIR)/sifive-runtime
RUNTIME_LIB := $(RUNTIME_DIR)/libsysy_riscv_sifive.a

CPPFLAGS :=
CFLAGS_O0 := -O0 -g -fno-pic -mcmodel=medany
CFLAGS_O2 := -O2 -fno-pic -mcmodel=medany
LDFLAGS := -static -mcmodel=medany
LINK_FLAGS := -Wl,--no-relax,-Ttext=0x90000000

.PHONY: all preprocess compile optimized assemble link dumps toolchain inspect environment verify clean

all: preprocess compile optimized dumps assemble link

preprocess: $(OUT_DIR)/fib.i

compile: $(OUT_DIR)/fib.s

optimized: $(OUT_DIR)/fib.O2.s

assemble: $(OUT_DIR)/fib.o

link: $(OUT_DIR)/fib

dumps: $(OUT_DIR)/fib.c.original \
       $(OUT_DIR)/fib.c.gimple \
       $(OUT_DIR)/fib.c.rtl-expand \
       $(OUT_DIR)/fib.c.rtl-final

toolchain:
	$(CC) --version > $(OUT_DIR)/toolchain.txt
	$(CC) -dumpmachine >> $(OUT_DIR)/toolchain.txt
	$(CC) -print-multi-directory >> $(OUT_DIR)/toolchain.txt
	$(CC) -print-libgcc-file-name >> $(OUT_DIR)/toolchain.txt

environment:
	./environment.sh > $(OUT_DIR)/environment.txt

inspect: link
	file $(OUT_DIR)/fib.o > $(OUT_DIR)/fib_object_info.txt
	riscv64-unknown-elf-readelf -h -A -s $(OUT_DIR)/fib.o \
	  | sed 's/[[:space:]]\+$$//' >> $(OUT_DIR)/fib_object_info.txt
	riscv64-unknown-elf-objdump -dr $(OUT_DIR)/fib.o > $(OUT_DIR)/fib_objdump.txt
	file $(OUT_DIR)/fib > $(OUT_DIR)/fib_executable_info.txt
	riscv64-unknown-elf-readelf -h -A $(OUT_DIR)/fib \
	  | sed 's/[[:space:]]\+$$//' >> $(OUT_DIR)/fib_executable_info.txt

verify: $(OUT_DIR)/fib
	mkdir -p $(OUT_DIR)/tests
	TEST_ARTIFACT_DIR=$(OUT_DIR)/tests ./run_tests.sh $(OUT_DIR)/fib \
	  > $(OUT_DIR)/tests/results.txt
	cat $(OUT_DIR)/tests/results.txt

$(OUT_DIR):
	mkdir -p $@

$(RUNTIME_DIR):
	mkdir -p $@

$(OUT_DIR)/fib.i: fib.c | $(OUT_DIR)
	$(CC) -E $(CPPFLAGS) $< -o $@

$(OUT_DIR)/fib.s: fib.c | $(OUT_DIR)
	$(CC) -S $(CPPFLAGS) $(CFLAGS_O0) $< -o $@

$(OUT_DIR)/fib.O2.s: fib.c | $(OUT_DIR)
	$(CC) -S $(CPPFLAGS) $(CFLAGS_O2) $< -o $@

$(OUT_DIR)/fib.c.original: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS_O0) -fdump-tree-original -S $< -o /dev/null
	mv fib.c.*t.original $@

$(OUT_DIR)/fib.c.gimple: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS_O0) -fdump-tree-gimple -S $< -o /dev/null
	mv fib.c.*t.gimple $@

$(OUT_DIR)/fib.c.rtl-expand: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS_O0) -fdump-rtl-expand -S $< -o /dev/null
	mv fib.c.*r.expand $@

$(OUT_DIR)/fib.c.rtl-final: fib.c | $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS_O0) -fdump-rtl-final -S $< -o /dev/null
	mv fib.c.*r.final $@

$(OUT_DIR)/fib.o: $(OUT_DIR)/fib.s
	$(CC) -march=rv64imafdc -mabi=lp64d -c $< -o $@

$(RUNTIME_DIR)/sylib.o: $(LIB_DIR)/sylib.c $(LIB_DIR)/sylib.h | $(RUNTIME_DIR)
	$(CC) -O2 -mcmodel=medany -fno-pic -I$(LIB_DIR) -c $< -o $@

$(RUNTIME_LIB): $(RUNTIME_DIR)/sylib.o
	$(AR) rcs $@ $<

$(OUT_DIR)/fib: $(OUT_DIR)/fib.o $(RUNTIME_LIB)
	$(CC) $(OUT_DIR)/fib.o -o $@ \
	  -L$(RUNTIME_DIR) -lsysy_riscv_sifive \
	  $(LDFLAGS) $(LINK_FLAGS)

clean:
	$(RM) -r $(OUT_DIR)
