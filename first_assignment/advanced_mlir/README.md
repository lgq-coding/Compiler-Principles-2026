# 第一次作业进阶部分：MLIR 与 AscendNPU IR

本目录用于完成第一次作业的进阶要求，观察 MLIR 多层方言和 AscendNPU IR 的渐进式 lowering。

## 文件说明

- `vecadd.mlir`：官方 VecAdd DEVICE 示例输入。
- `vecadd_host_for_cpu.mlir`：用于观察 HIVM 到上游 Linalg/LLVM 的 Host 版探索输入。
- `MLIR中端_lowering分析.md`：方言、pipeline 和实际 lowering 分析。
- `交接文档_刘昀皓_进阶部分.md`：分工及后续工作说明。
- `Makefile`：复现实验。
- `check_environment.sh`：检查 MLIR 工具和可选的设备运行环境。
- `artifacts/`：实际生成的 MLIR、pass pipeline 和环境记录。

## 快速开始

```bash
make check
make -B all
make verify
```

## 任务边界

本次进阶要求只要求观察 AI 编译器的 MLIR 中端处理过程和逐层 lowering，不要求真实 NPU、CANN 或设备端运行。

因此，本目录以 `bishengir-opt` 产生的 IR 变化作为主要证据。`hivmc`、CANN 和设备运行属于后续可选验证，不属于本任务的完成条件。
