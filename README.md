# RISC-V CPU Verification Lab — OpenHW CORE-V

面向数字 IC / CPU / SoC 验证岗位的可复现学习项目。上游采用 OpenHW Group `core-v-verif`，目标核心为 CV32E40P；本仓库增加 verification plan、RV32I reference helpers、SVA 示例、回归测试和 CI，并明确保留上游归属。

## 上游固定版本
- `openhwgroup/core-v-verif`
- commit `f3b1f971e0e6b94deae46d279cc50ca390785369`

## 已实现
- RV32I immediate/ALU reference helpers
- pytest directed regression
- CORE-V 验证 testplan
- instruction/data request bounded-progress SVA 示例
- GitHub Actions 固定并检查 OpenHW Verilator flow

## 本地运行
```bash
make test
make fetch-upstream
```

## OpenHW 官方 core testbench
上游 `cv32e40p/sim/core` 支持 Verilator，典型入口是 `make` / `make veri-test TEST=<program>`。完整 RTL 仿真需要 Verilator 和 RISC-V GCC toolchain。

## 下一阶段
1. CI 安装 RISC-V toolchain + Verilator，直接执行 `sanity-veri-run`。
2. 增加 CSR / exception / interrupt / memory-stall directed tests。
3. 加入 fail-seed replay、coverage parsing、waveform artifact。
4. 有 VCS/Questa 环境时进入 `core-v-verif` UVM flow，补 sequence / scoreboard / covergroup。

详见 `docs/VERIFICATION_PLAN.md` 与 `UPSTREAM.md`。
