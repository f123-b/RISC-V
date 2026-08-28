/*
 * Minimal CV32E40P architectural smoke program.
 *
 * Purpose: execute real code on the pinned CORE-V Verilator testbench without
 * depending on the 2021 example program's stdio/newlib ABI. Output goes through
 * the testbench's MMIO stdout register, while pass/fail is returned to crt0.
 */
#define STDOUT_REG (*(volatile unsigned int *)0x10000000u)
#define EXP_MISA   0x40001104u

static void puts_mmio(const char *s)
{
    while (*s) {
        STDOUT_REG = (unsigned int)(unsigned char)*s++;
    }
}

int main(void)
{
    unsigned int misa;
    unsigned int mvendorid;
    unsigned int marchid;
    unsigned int mimpid;

    __asm__ volatile("csrr %0, 0xF11" : "=r"(mvendorid));
    __asm__ volatile("csrr %0, 0x301" : "=r"(misa));
    __asm__ volatile("csrr %0, 0xF12" : "=r"(marchid));
    __asm__ volatile("csrr %0, 0xF13" : "=r"(mimpid));

    if (mvendorid != 0x00000602u) return 1;
    if (misa      != EXP_MISA)    return 2;
    if (marchid   != 0x00000004u) return 3;
    if (mimpid    != 0x00000000u) return 4;

    puts_mmio("CV32E40P SMOKE PASS\n");
    return 0;
}
