"""Tiny RV32I reference helpers for smoke/regression checking.
Not a full ISA simulator; focused on deterministic decode/ALU checks used by this repo.
"""
MASK32 = 0xFFFFFFFF

def sext(value: int, bits: int) -> int:
    sign = 1 << (bits - 1)
    value &= (1 << bits) - 1
    return (value ^ sign) - sign

def imm_i(insn: int) -> int:
    return sext(insn >> 20, 12)

def imm_u(insn: int) -> int:
    return insn & 0xFFFFF000

def addi(rs1: int, imm: int) -> int:
    return (rs1 + sext(imm, 12)) & MASK32

def lui(imm20: int) -> int:
    return (imm20 << 12) & MASK32

def encode_addi(rd: int, rs1: int, imm: int) -> int:
    return ((imm & 0xFFF) << 20) | ((rs1 & 0x1F) << 15) | ((rd & 0x1F) << 7) | 0b0010011

def encode_lui(rd: int, imm20: int) -> int:
    return ((imm20 & 0xFFFFF) << 12) | ((rd & 0x1F) << 7) | 0b0110111
