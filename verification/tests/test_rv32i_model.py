from verification.ref_model.rv32i_model import *

def test_addi_positive():
    insn = encode_addi(1, 2, 7)
    assert imm_i(insn) == 7
    assert addi(10, imm_i(insn)) == 17

def test_addi_negative_sign_extension():
    insn = encode_addi(1, 2, -1)
    assert imm_i(insn) == -1
    assert addi(0, imm_i(insn)) == 0xFFFFFFFF

def test_lui():
    insn = encode_lui(5, 0xABCDE)
    assert imm_u(insn) == 0xABCDE000
    assert lui(0xABCDE) == 0xABCDE000
