/*
 * Minimal freestanding handlers for the CV32E40P CI smoke test.
 *
 * The architectural smoke program does not intentionally exercise interrupts
 * or exceptions. If one occurs, report a deterministic non-zero failure code
 * through the CORE-V testbench EXIT_REG and stop. This keeps the smoke path
 * independent of the legacy BSP's puts()/syscall/newlib dependencies.
 */

.section .text.handlers, "ax"

.global __no_irq_handler
.global u_sw_irq_handler
.global m_software_irq_handler
.global m_timer_irq_handler
.global m_external_irq_handler
.global m_fast0_irq_handler
.global m_fast1_irq_handler
.global m_fast2_irq_handler
.global m_fast3_irq_handler
.global m_fast4_irq_handler
.global m_fast5_irq_handler
.global m_fast6_irq_handler
.global m_fast7_irq_handler
.global m_fast8_irq_handler
.global m_fast9_irq_handler
.global m_fast10_irq_handler
.global m_fast11_irq_handler
.global m_fast12_irq_handler
.global m_fast13_irq_handler
.global m_fast14_irq_handler
.global m_fast15_irq_handler

/* Any unexpected trap is a smoke-test failure. */
__no_irq_handler:
    li t0, 0x20000004
    li t1, 0x7f
    sw t1, 0(t0)
1:
    wfi
    j 1b

u_sw_irq_handler:
m_software_irq_handler:
m_timer_irq_handler:
m_external_irq_handler:
m_fast0_irq_handler:
m_fast1_irq_handler:
m_fast2_irq_handler:
m_fast3_irq_handler:
m_fast4_irq_handler:
m_fast5_irq_handler:
m_fast6_irq_handler:
m_fast7_irq_handler:
m_fast8_irq_handler:
m_fast9_irq_handler:
m_fast10_irq_handler:
m_fast11_irq_handler:
m_fast12_irq_handler:
m_fast13_irq_handler:
m_fast14_irq_handler:
m_fast15_irq_handler:
    j __no_irq_handler
