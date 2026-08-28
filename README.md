# RISC-V CPU Verification Lab — OpenHW CORE-V

面向数字 IC / CPU / SoC 验证岗位的可复现学习项目。上游采用 OpenHW Group `core-v-verif`，目标核心为 CV32E40P；本仓库增加 verification plan、RV32I reference helpers、SVA 示例、回归测试和 CI，并明确保留上游归属。

## 当前验证状态

GitHub Actions 已完整跑通以下三条路径：

- `reference-model`：Python/pytest directed regression
- `upstream-provenance`：拉取并校验固定版本 `core-v-verif`
- `core-verilator-smoke`：实际编译 CV32E40P RTL + Verilator testbench，交叉编译仓库内 CSR smoke firmware，并在 RTL 仿真中得到 `EXIT SUCCESS`

RISC-V smoke firmware 会在真实 CV32E40P RTL 上读取并检查 `mvendorid`、`misa`、`marchid`、`mimpid`。任何 CSR 不匹配或意外 trap 都会通过 testbench MMIO exit path 返回非零状态。

## 上游固定版本

- `openhwgroup/core-v-verif`
- commit `f3b1f971e0e6b94deae46d279cc50ca390785369`
- CI 中由上游 flow 拉取 CV32E40P RTL commit `fcd5968`

## 已实现

- RV32I immediate/ALU reference helpers
- pytest directed regression
- CORE-V 验证 testplan
- instruction/data request bounded-progress SVA 示例
- GitHub Actions 固定并检查 OpenHW Verilator flow
- CV32E40P CSR architectural smoke program
- Ubuntu 24.04 / GCC 13 兼容层
- libc-free smoke startup 与异常处理路径
- Verilator RTL compile + firmware execution smoke test

## 本地运行

基础 reference regression：

```bash
make test
make fetch-upstream
```

复现 CI 中的 CV32E40P RTL smoke flow，可按 `.github/workflows/ci.yml` 安装 Verilator 与 RISC-V bare-metal toolchain 后执行：

```bash
bash scripts/fetch_upstream.sh
# 应用 verification/compat 下的 CI 兼容层并安装 smoke program 后：
cd .deps/core-v-verif/cv32e40p/sim/core
make sanity-veri-run
```

成功时 Verilator testbench 会结束于：

```text
EXIT SUCCESS
```

## 为什么有 compatibility 层

固定的 `core-v-verif` revision 使用较早期的 newlib/BSP 假设，而当前 GitHub Actions 使用 Ubuntu 24.04、GCC 13 和现代 bare-metal C library 布局。本仓库没有修改上游来源，而是在 `verification/compat/` 中显式维护可审查的兼容层，使旧验证环境可以在现代 CI 中稳定复现。

## 下一阶段

1. 增加 CSR / exception / interrupt / memory-stall directed tests。
2. 加入 fail-seed replay、coverage parsing、waveform artifact。
3. 增加 cache / bus / pipeline stall 等更接近 CPU verification 岗位的 directed verification。
4. 有 VCS/Questa 环境时进入 `core-v-verif` UVM flow，补 sequence / scoreboard / covergroup。

详见 `docs/VERIFICATION_PLAN.md` 与 `UPSTREAM.md`。
