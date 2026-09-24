# 第一次作业进阶部分：MLIR 与 AscendNPU IR

本目录用于完成第一次作业的进阶要求，观察 MLIR 多层方言和 AscendNPU IR 的渐进式 lowering。

## 文件说明

- `vecadd.mlir`：官方 VecAdd DEVICE 示例输入。
- `vecadd_host_for_cpu.mlir`：用于观察 HIVM 到上游 Linalg/LLVM 的 Host 版探索输入。
- `MLIR中端_lowering分析.md`：方言、pipeline 和实际 lowering 分析。
- `交接文档_刘昀皓_进阶部分.md`：分工及后续工作说明。
- `Makefile`：复现实验。
- `check_environment.sh`：检查 MLIR、CANN、`hivmc` 和 NPU 设备。
- `artifacts/`：实际生成的 MLIR、pass pipeline 和环境记录。

## 快速开始

```bash
make check
make -B all
make verify
```

## 当前边界

当前 WSL 环境可以运行 `bishengir-opt` 和 `bishengir-compile`，并完成 MLIR 中端 lowering。

由于缺少 `hivmc`、CANN 和昇腾设备，当前不能生成设备二进制，也不能进行 NPU 上板运行。
