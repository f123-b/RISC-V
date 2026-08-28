/*
 * Minimal CV32E40P architectural smoke program.
 *
 * The CORE-V testbench observes the process exit value through the BSP exit
 * path, so this test deliberately avoids stdio and all hosted-C library calls.
 * Returning zero means all architectural identity CSRs matched the pinned core.
 */
#define EXP_MISA 0x40001104u

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

    return 0;
}
