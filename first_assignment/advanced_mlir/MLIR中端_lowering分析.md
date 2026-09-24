# 进阶部分：MLIR 中端与 AscendNPU IR Lowering 分析

- 负责人：刘国全
- 阶段：第一次作业进阶要求
- 目标：观察 MLIR 多层方言和渐进式 lowering 过程
- 目标项目：AscendNPU IR / BiShengIR
- 官方版本：`ascendnpu-ir` Python 包 1.1.0
- LLVM 版本：19.1.7
- Python wheel：`ascendnpu_ir-1.1.0-cp312-cp312-manylinux_2_28_x86_64.whl`
- wheel SHA-256：`206b3f9030e3eb8c9807e0fb4e756f5501b548b23670c23dd1bcc579269a1948`

## 一、任务结论

进阶要求要求观察 AI 编译器 MLIR 的中端处理过程，并与基础任务中的 LLVM IR 单层中间表示进行对比。

本阶段已完成：

1. 定位并阅读 AscendNPU IR 官方构建和使用文档。
2. 获取官方源码并分析方言结构、pass pipeline 和 VecAdd 示例。
3. 用户级安装官方 `ascendnpu-ir` Python wheel。
4. 确认 `bishengir-opt` 和 `bishengir-compile` 可以在 WSL 内运行。
5. 对官方 VecAdd 执行多个 HIVM 中端 pass。
6. 实际观察到：
   - VecAdd 被识别为 AIV 核函数；
   - 片上内存分配被转换为偏移地址和缓冲区复用；
   - 自动插入 MTE/V/MTE3 流水同步标志；
   - CPU 观察路径中 `hivm.hir.vadd` 被降低为 `linalg.add`；
   - 完整 CPU lowering pipeline 最终生成 LLVM 方言。

本阶段未进行的部分：

- 不生成设备二进制 `kernel.o`；
- 不进行 CANN Runtime 注册；
- 不进行真实 NPU 上板运行。

这些内容属于设备端执行路线，不是本题“观察 MLIR 中端和逐层 lowering”的必要条件。本题验收重点是方言层次、Pass Pipeline 和 IR 的渐进式变化，而不是硬件执行结果。

## 二、官方资料

### 2.1 正确 URL

作业截图中提供的 URL 少了文件名中的下划线。

正确地址为：

```text
https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/quick_start/installing_guide_zh.html
https://ascendnpu-ir.gitcode.com/zh_cn/sources/introduction/quick_start/examples_zh.html
```

### 2.2 源码版本

浅克隆的官方源码位于：

```text
$HOME/ascendnpu-ir
```

版本：

```text
commit bd212c51c6f996f451f3bb6381472cfc1d9dde9b
```

## 三、MLIR 和 LLVM IR 的中端差异

### 3.1 LLVM IR 路线

基础任务中，我们手写的是 LLVM IR。其主要特点是：

- 只有一种相对固定的中间表示层级；
- 使用 SSA 形式；
- 基本类型和指令较接近机器模型；
- 主要处理函数、基本块、算术、内存访问和调用；
- 优化和代码生成围绕同一个 LLVM IR 展开。

可以用以下链路概括：

```text
SysY
  -> LLVM IR
  -> RISC-V 汇编
  -> RISC-V 目标文件
```

### 3.2 MLIR 路线

MLIR 的核心特点是：

- 一个 Module 中可以同时存在多种 Dialect；
- 不同 Dialect 可以表达不同抽象层次；
- Conversion Pass 可以在保持外部语义的同时逐级改写；
- 高层算子可以保留更多结构化信息，便于融合、切块和调度；
- 后期再逐渐降低到接近硬件的表示。

可以用以下链路概括：

```text
Torch / Triton / TileLang / Linalg
  -> HFusion
  -> HIVM
  -> lower-level HIVM
  -> LLVM IR
  -> NPU device binary
```

与 LLVM IR 相比，MLIR 不只是“另一种 IR”，而是“可以承载多层 IR 的框架”。

## 四、AscendNPU IR 的逻辑层次

根据官方架构文档，AscendNPU IR 的主要自研方言包括：

| 方言或组件 | 主要作用 |
| --- | --- |
| HFusion | 基于 Linalg 扩展，表达硬件相对无关的高层计算和融合 |
| HIVM | 对昇腾的计算、搬运和同步进行 Tile 级抽象 |
| HACC | 表达 Host/Device 异构程序、入口和 launch 语义 |
| Annotation | 给 Operation 或 Operand 添加编译提示 |
| Scope | 表达作用域和流水区域等结构信息 |
| MathExt | 补充数学相关扩展 Operation |
| MemRefExt | 补充内存相关扩展 Operation |

### 4.1 HFusion

HFusion 是从高层框架进入 AscendNPU IR 的关键接口层。

主要职责：

1. 接收 Arith、Math、Linalg、Tensor、Torch 等方言；
2. 保留 Linalg named operation 的高层语义；
3. 进行类型合法化、Tensor 化简和复杂算子分解；
4. 进行算子融合；
5. 自动生成 Device Kernel；
6. 进行 AutoSchedule、切块和 Host tiling。

HFusion 处理的是“硬件相对无关”的结构化计算。

### 4.2 HIVM

HIVM 面向昇腾硬件，是 Tile 级虚拟指令模型。

主要职责：

1. 表达 GM 到 UB、UB 到 GM 的数据搬运；
2. 表达向量和 Cube 计算；
3. 推断 AIC/AIV/MIX 核类型；
4. 进行 CV 核融合和切分；
5. 推导片上内存大小、布局和偏移；
6. 进行内存复用规划；
7. 插入核内和核间同步；
8. 将逻辑内存地址映射到 UB、L1、L0A、L0B、L0C 等硬件空间。

### 4.3 HACC

HACC 主要描述：

- Host/Device 函数属性；
- Device entry；
- 核函数类型；
- 设备规格；
- launch 相关语义；
- AI Core、Cube Core、Vector Core 和各级片上缓存大小。

VecAdd 输入函数带有：

```mlir
attributes {
  hacc.entry,
  hacc.function_kind = #hacc.function_kind<DEVICE>
}
```

说明 `add` 是设备侧入口函数。

## 五、VecAdd 示例

官方输入文件已复制到：

```text
vecadd.mlir
```

其核心 Operation 为：

```text
memref.alloc
hivm.hir.load
hivm.hir.vadd
hivm.hir.store
return
```

数据流为：

```text
GM 中的 arg0
  -> hivm.hir.load
  -> UB 缓冲区 alloc

GM 中的 arg1
  -> hivm.hir.load
  -> UB 缓冲区 alloc_0

UB 中的 alloc + alloc_0
  -> hivm.hir.vadd
  -> UB 缓冲区 alloc_1

UB 中的 alloc_1
  -> hivm.hir.store
  -> GM 中的 arg2
```

地址空间含义：

- `#hivm.address_space<gm>`：Global Memory；
- `#hivm.address_space<ub>`：Unified Buffer，片上缓冲区。

该程序已经是 HIVM 层的设备函数，不再包含高层 Linalg 计算。

## 六、实际执行的 HIVM 中端 Pass

### 6.1 推断核心类型

命令：

```bash
bishengir-opt vecadd.mlir \
  --hivm-infer-func-core-type \
  -o artifacts/vecadd_hivm-infer-func-core-type.mlir
```

观察结果：

```mlir
module attributes {
  hivm.module_core_type = #hivm.module_core_type<AIV>
}

func.func @add(...)
    attributes {
      hacc.entry,
      hacc.function_kind = #hacc.function_kind<DEVICE>,
      hivm.func_core_type = #hivm.func_core_type<AIV>
    }
```

解释：

- 该程序只包含向量加法，不含 Cube/矩阵计算；
- 编译器推断其应运行在 AIV 向量核；
- 不需要进入 AIC/AIV 混合核拆分流程。

### 6.2 自动片上内存规划

命令：

```bash
bishengir-opt artifacts/vecadd_hivm-infer-func-core-type.mlir \
  --hivm-plan-memory \
  -o artifacts/vecadd_hivm_core_plan.mlir
```

规划前：

```mlir
%alloc = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
%alloc_0 = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
%alloc_1 = memref.alloc() : memref<16xi16, #hivm.address_space<ub>>
```

规划后：

```mlir
%c32_i64 = arith.constant 32 : i64
%c0_i64 = arith.constant 0 : i64

%0 = hivm.hir.pointer_cast(%c0_i64) : memref<16xi16, #hivm.address_space<ub>>
%1 = hivm.hir.pointer_cast(%c32_i64) : memref<16xi16, #hivm.address_space<ub>>
%2 = hivm.hir.pointer_cast(%c0_i64) : memref<16xi16, #hivm.address_space<ub>>
```

解释：

1. `memref.alloc` 被转换成 UB 内的显式地址；
2. 第一路输入使用偏移 `0`；
3. 第二路输入使用偏移 `32`；
4. 输出缓冲区也使用偏移 `0`；
5. 输出可以复用第一路输入，因为其生命周期已经结束；
6. 这体现了内存规划和缓冲区复用，而不仅是简单的内存分配转换。

### 6.3 自动同步插入

命令：

```bash
bishengir-opt artifacts/vecadd_hivm_core_plan.mlir \
  --hivm-inject-sync \
  -o artifacts/vecadd_hivm_sync.mlir
```

插入的同步主要包括：

```mlir
hivm.hir.set_flag[<PIPE_MTE2>, <PIPE_V>, <EVENT_ID0>]
hivm.hir.wait_flag[<PIPE_MTE2>, <PIPE_V>, <EVENT_ID0>]

hivm.hir.set_flag[<PIPE_V>, <PIPE_MTE3>, <EVENT_ID0>]
hivm.hir.wait_flag[<PIPE_V>, <PIPE_MTE3>, <EVENT_ID0>]

hivm.hir.pipe_barrier[<PIPE_ALL>]
```

解释：

1. `MTE2 -> V`：
   - 保证两路输入从 GM 搬运到 UB 后，向量计算才开始；
2. `V -> MTE3`：
   - 保证向量加法完成后，结果才写回 GM；
3. `PIPE_ALL`：
   - 在函数结束前增加全局流水屏障。

该结果说明编译器会根据数据依赖自动产生异步流水同步，而不是由程序员手工编写所有同步指令。

## 七、CPU Runner 观察路径

官方 VecAdd 是 DEVICE 函数，直接进行 CPU Runner 测试还需要一个 Host 入口。

因此增加了：

```text
vecadd_host_for_cpu.mlir
```

该文件仅用于观察 MLIR 的降级过程，不是官方 NPU 上板程序。

### 7.1 HIVM 到上游 Linalg

命令：

```bash
bishengir-opt vecadd_host_for_cpu.mlir \
  --execution-engine-convert-hivm-to-upstream \
  -o artifacts/vecadd_host_linalg.mlir
```

降低前：

```mlir
%sum = hivm.hir.vadd ins(%a, %b : tensor<16xi16>, tensor<16xi16>)
                        outs(%out : tensor<16xi16>) -> tensor<16xi16>
```

降低后：

```mlir
%1 = linalg.add ins(%arg0, %arg1 : tensor<16xi16>, tensor<16xi16>)
                outs(%0 : tensor<16xi16>) -> tensor<16xi16>
```

这直接展示了“翻译到上游等价方言”的 lowering 过程。

### 7.2 完整 CPU Runner Pipeline

命令：

```bash
bishengir-opt vecadd_host_for_cpu.mlir \
  --lower-for-cpu-runner-pipeline='wrapper-name=main_wrapper' \
  -o artifacts/vecadd_host_cpu_pipeline.mlir
```

该 pipeline 共包含 30 个 pass，主要阶段包括：

```text
execution-engine-create-host-main
execution-engine-convert-hivm-to-upstream
one-shot-bufferize
buffer-deallocation
convert-linalg-to-loops
convert-scf-to-cf
lower-affine
convert-vector-to-llvm
convert-math-to-llvm
finalize-memref-to-llvm
convert-func-to-llvm
convert-cf-to-llvm
convert-arith-to-llvm
reconcile-unrealized-casts
```

最终输出中已经出现：

```text
llvm.func
llvm.call
llvm.load
llvm.store
llvm.getelementptr
llvm.cond_br
```

完整 pass 列表保存在：

```text
artifacts/cpu_runner_pipeline.txt
```

这说明一个高层 Operation 可以依次经历：

```text
HIVM
  -> Linalg
  -> Loops
  -> SCF/CF
  -> LLVM dialect
```

这是 MLIR 渐进式 lowering 最直观的证据。

## 八、源代码层面的主 Pipeline

根据 AscendNPU IR 源码中的 `buildBiShengHIRPipeline`，主流程可概括为：

```text
canonicalize-module
  -> hacc-append-device-spec
  -> 可选 Torch Conversion
  -> HFusion Pipeline
  -> HFusionToHIVM Conversion
  -> TensorToHIVM Conversion
  -> ConvertToHIVMOp
  -> HIVM Optimize Pipeline
  -> hivmc
  -> 设备端二进制
```

其中 `ConvertToHIVM` 的关键 pass 为：

```text
convert-hfusion-to-hivm
convert-tensor-to-hivm
convert-to-hivm-op
```

本次 `bishengir-compile` 实验也实际打印出了这三步。继续调用 `hivmc` 生成设备二进制属于本次观察任务之后的可选下游流程。

## 九、当前环境与任务边界

任务所需工具已经配置：

```text
bishengir-opt     1.1.0
bishengir-compile 1.1.0
LLVM              19.1.7
Ninja             1.13.2
Python binding    1.1.0
```

已经完成：

- MLIR 解析和验证；
- 官方 VecAdd 的 HIVM 中端 Pass 实验；
- HIVM 到 Linalg 的降低；
- 30-pass CPU lowering pipeline；
- 从结构化方言到 LLVM dialect 的观察。

未配置的 `hivmc`、CANN 和 NPU 设备只影响“设备端二进制生成与硬件执行”，不影响本次进阶要求的中端 lowering 观察。因此它们不是本任务的阻塞项。

## 十、与基础任务的对比结论

| 对比项 | LLVM IR 路线 | AscendNPU IR 路线 |
| --- | --- | --- |
| 中间表示层数 | 单层 LLVM IR | 多种 Dialect 多层表示 |
| 高层语义 | 较接近机器和 SSA | HFusion 保留结构化计算语义 |
| 硬件抽象 | 后端才绑定目标 | HIVM 显式表达 Tile、GM/UB 和流水 |
| 优化方式 | LLVM Pass | 方言转换、融合、切分、内存规划、同步插入 |
| 最终后端 | RISC-V 代码生成 | hivmc 转 LLVM IR 并生成 NPU 二进制 |
| 本机可验证程度 | 已通过 QEMU 完整验证 | 已完成本题所需的中端 lowering 观察 |

结论：

MLIR 相比 LLVM IR 更强调多层抽象和逐级降低。AscendNPU IR 在 HFusion 层保留高层计算语义，在 HIVM 层逐渐引入 GM/UB、AIV、同步流水和地址分配等硬件信息，最终再交给 `hivmc` 和 LLVM 后端生成设备二进制。这种结构比单层 LLVM IR 更适合 AI 编译器中的算子融合、内存规划和硬件调度。
