# 基础要求第二部分：SysY、LLVM IR 与 RISC-V

本目录包含两条等价实现路线：

1. `sysy_demo.ll`：刘国全编写的 LLVM IR 路线。
2. `sysy_demo_asm.s`：刘昀皓编写的手写 RISC-V 汇编路线。

两条路线使用同一份：

- `sysy_demo.sy`；
- `tests/input_*.txt`；
- `tests/expected_*.txt`；
- 助教提供的 `lib/sylib.c`。

构建时使用 SiFive GCC 10.2 从 `sylib.c` 重建 `libsysy_riscv_sifive.a`，因此默认链路统一使用 SiFive as 2.35、SiFive ld 2.35 和 LP64D ABI。

## 构建

```bash
make all
```

## 验证

```bash
make verify
```

`make verify` 会依次验证：

```text
verify-llvm
verify-asm
```

## 检查信息

```bash
make inspect
make asm-inspect
```

## 主要记录

```text
阶段验证.md
交接文档_刘昀皓.md
../交接回执_刘国全.md
artifacts/build_and_test.log
artifacts/tests/
artifacts/tests_asm/
artifacts/sysy_demo_asm_readelf.txt
artifacts/sysy_demo_asm_objdump.txt
```
