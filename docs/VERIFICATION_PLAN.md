# CV32E40P / CORE-V Verification Plan

## Scope
Use OpenHW `core-v-verif` as the upstream verification environment and CV32E40P as the DUT. Open-source CI focuses on the Verilator core testbench; UVM/VCS/Questa expansion is documented as the next stage.

## Testpoints
| Feature | Tests | Checker | Coverage idea |
|---|---|---|---|
| RV32I arithmetic/immediate | ADDI/LUI plus directed programs | architectural result | opcode × operand class |
| branch/jump | taken/not-taken/forward/backward | PC trace | branch outcome |
| load/store | aligned/misaligned | memory scoreboard | size × alignment |
| CSR | legal/illegal CSR access | CSR reference | CSR class × privilege |
| exception | illegal instruction/ecall/ebreak | trap cause/PC | cause |
| interrupt | timing/randomized injection | trap entry/return | irq id × timing |
| memory stalls | randomized grant/rvalid delay | retirement trace | delay bins |

## Debug flow
Fail seed/test → reproduce → inspect simulator log/VCD → compare architectural state → trace RTL cone → classify DUT/TB/reference-model issue.
