# 第一次作业第一部分：GCC 编译过程与 RISC-V 目标程序

本目录使用 SiFive GCC 10.2 完成从 `fib.c` 到 RISC-V 可执行程序的完整链路。

## 阶段

```text
fib.c
  -> fib.i
  -> fib.s
  -> fib.o
  -> fib
  -> qemu-riscv64
```

同时提供：

- GCC Tree、GIMPLE 和 RTL dump；
- `-O0` 与 `-O2` 汇编对比；
- 目标文件 ELF、符号和重定位信息；
- QEMU 自动化测试结果。

## 复现

```bash
make -B all verify inspect environment
```

## 主要文件

```text
fib.c
artifacts/fib.i
artifacts/fib.s
artifacts/fib.o
artifacts/fib
artifacts/fib_object_info.txt
artifacts/fib_executable_info.txt
artifacts/tests/results.txt
阶段分析.md
```
