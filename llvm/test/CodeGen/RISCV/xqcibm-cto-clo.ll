; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefixes=RV32ZBB
; RUN: llc -mtriple=riscv32 -mattr=+zbb,experimental-xqcibm -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZBBXQCIBM

declare i8 @llvm.cttz.i8(i8, i1)
declare i16 @llvm.cttz.i16(i16, i1)
declare i32 @llvm.cttz.i32(i32, i1)
declare i64 @llvm.cttz.i64(i64, i1)
declare i8 @llvm.ctlz.i8(i8, i1)
declare i16 @llvm.ctlz.i16(i16, i1)
declare i32 @llvm.ctlz.i32(i32, i1)
declare i64 @llvm.ctlz.i64(i64, i1)

define i8 @test_cttz_i8(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    zext.b a1, a0
; RV32I-NEXT:    beqz a1, .LBB0_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    li a0, 8
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i8:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    li a1, 256
; RV32ZBB-NEXT:    orn a0, a1, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i8:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    li a1, 256
; RV32ZBBXQCIBM-NEXT:    orn a0, a1, a0
; RV32ZBBXQCIBM-NEXT:    ctz a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i8 %a, -1
  %tmp = call i8 @llvm.cttz.i8(i8 %1, i1 false)
  ret i8 %tmp
}

define i16 @test_cttz_i16(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    beqz a1, .LBB1_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    lui a2, 5
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    addi a1, a2, 1365
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    lui a2, 3
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 15
; RV32I-NEXT:    slli a0, a0, 20
; RV32I-NEXT:    srli a0, a0, 28
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    li a0, 16
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i16:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    lui a1, 16
; RV32ZBB-NEXT:    orn a0, a1, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i16:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    lui a1, 16
; RV32ZBBXQCIBM-NEXT:    orn a0, a1, a0
; RV32ZBBXQCIBM-NEXT:    ctz a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i16 %a, -1
  %tmp = call i16 @llvm.cttz.i16(i16 %1, i1 false)
  ret i16 %tmp
}

define i32 @test_cttz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    beqz a0, .LBB2_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI2_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI2_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i32:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i32 %a, -1
  %tmp = call i32 @llvm.cttz.i32(i32 %1, i1 false)
  ret i32 %tmp
}

define i64 @test_cttz_i64(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    not s3, a1
; RV32I-NEXT:    not s2, a0
; RV32I-NEXT:    or a0, s2, s3
; RV32I-NEXT:    beqz a0, .LBB3_3
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    neg a0, s2
; RV32I-NEXT:    and a0, s2, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi s1, a1, 1329
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    lui s4, %hi(.LCPI3_0)
; RV32I-NEXT:    addi s4, s4, %lo(.LCPI3_0)
; RV32I-NEXT:    neg a0, s3
; RV32I-NEXT:    and a0, s3, a0
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    bnez s2, .LBB3_4
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    add a0, s4, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB3_5
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    li a0, 64
; RV32I-NEXT:    j .LBB3_6
; RV32I-NEXT:  .LBB3_4:
; RV32I-NEXT:    srli s0, s0, 27
; RV32I-NEXT:    add s0, s4, s0
; RV32I-NEXT:    lbu a0, 0(s0)
; RV32I-NEXT:  .LBB3_5: # %cond.false
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:  .LBB3_6: # %cond.end
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    bnez a0, .LBB3_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    not a0, a1
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB3_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i64:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a2, a0
; RV32ZBBXQCIBM-NEXT:    bnez a2, .LBB3_2
; RV32ZBBXQCIBM-NEXT:  # %bb.1:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a1
; RV32ZBBXQCIBM-NEXT:    addi a0, a0, 32
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
; RV32ZBBXQCIBM-NEXT:  .LBB3_2:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i64 %a, -1
  %tmp = call i64 @llvm.cttz.i64(i64 %1, i1 false)
  ret i64 %tmp
}

define i8 @test_cttz_i8_zero_undef(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i8_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i8_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i8 %a, -1
  %tmp = call i8 @llvm.cttz.i8(i8 %1, i1 true)
  ret i8 %tmp
}

define i16 @test_cttz_i16_zero_undef(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a0
; RV32I-NEXT:    lui a2, 5
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    lui a2, 3
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 15
; RV32I-NEXT:    slli a0, a0, 20
; RV32I-NEXT:    srli a0, a0, 28
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i16_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i16_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i16 %a, -1
  %tmp = call i16 @llvm.cttz.i16(i16 %1, i1 true)
  ret i16 %tmp
}

define i32 @test_cttz_i32_zero_undef(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI6_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI6_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i32_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i32_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i32 %a, -1
  %tmp = call i32 @llvm.cttz.i32(i32 %1, i1 true)
  ret i32 %tmp
}

define i64 @test_cttz_i64_zero_undef(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    not s3, a1
; RV32I-NEXT:    not s4, a0
; RV32I-NEXT:    neg a0, s4
; RV32I-NEXT:    and a0, s4, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi s1, a1, 1329
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    lui s2, %hi(.LCPI7_0)
; RV32I-NEXT:    addi s2, s2, %lo(.LCPI7_0)
; RV32I-NEXT:    neg a0, s3
; RV32I-NEXT:    and a0, s3, a0
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    bnez s4, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    add a0, s2, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB7_3
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    srli s0, s0, 27
; RV32I-NEXT:    add s0, s2, s0
; RV32I-NEXT:    lbu a0, 0(s0)
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i64_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    bnez a0, .LBB7_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    not a0, a1
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB7_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_cttz_i64_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a2, a0
; RV32ZBBXQCIBM-NEXT:    bnez a2, .LBB7_2
; RV32ZBBXQCIBM-NEXT:  # %bb.1:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a1
; RV32ZBBXQCIBM-NEXT:    addi a0, a0, 32
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
; RV32ZBBXQCIBM-NEXT:  .LBB7_2:
; RV32ZBBXQCIBM-NEXT:    qc.cto a0, a0
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i64 %a, -1
  %tmp = call i64 @llvm.cttz.i64(i64 %1, i1 true)
  ret i64 %tmp
}

define i8 @test_ctlz_i8(i8 %a) nounwind {
; RV32I-LABEL: test_ctlz_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    zext.b a1, a0
; RV32I-NEXT:    beqz a1, .LBB8_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 25
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 26
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 28
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB8_2:
; RV32I-NEXT:    li a0, 8
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i8:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    slli a0, a0, 24
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i8:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    slli a0, a0, 24
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i8 %a, -1
  %tmp = call i8 @llvm.ctlz.i8(i8 %1, i1 false)
  ret i8 %tmp
}

define i16 @test_ctlz_i16(i16 %a) nounwind {
; RV32I-LABEL: test_ctlz_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    beqz a1, .LBB9_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    srli a1, a1, 17
; RV32I-NEXT:    lui a2, 5
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    addi a1, a2, 1365
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 18
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 20
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 24
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    lui a2, 3
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 15
; RV32I-NEXT:    slli a0, a0, 20
; RV32I-NEXT:    srli a0, a0, 28
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB9_2:
; RV32I-NEXT:    li a0, 16
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i16:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    slli a0, a0, 16
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i16:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    slli a0, a0, 16
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i16 %a, -1
  %tmp = call i16 @llvm.ctlz.i16(i16 %1, i1 false)
  ret i16 %tmp
}

define i32 @test_ctlz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_ctlz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    beqz a0, .LBB10_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    addi a1, a2, 1365
; RV32I-NEXT:    srli a2, a0, 2
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 4
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 8
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 16
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    lui a2, 209715
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    lui a2, 61681
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    addi a1, a2, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB10_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i32:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i32 %a, -1
  %tmp = call i32 @llvm.ctlz.i32(i32 %1, i1 false)
  ret i32 %tmp
}

define i64 @test_ctlz_i64(i64 %a) nounwind {
; RV32I-LABEL: test_ctlz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a3, a1
; RV32I-NEXT:    not a4, a0
; RV32I-NEXT:    or a0, a4, a3
; RV32I-NEXT:    beqz a0, .LBB11_3
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    lui a0, 349525
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    lui a5, 61681
; RV32I-NEXT:    addi a2, a0, 1365
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    addi a0, a5, -241
; RV32I-NEXT:    bnez a3, .LBB11_4
; RV32I-NEXT:  # %bb.2: # %cond.false
; RV32I-NEXT:    srli a3, a4, 1
; RV32I-NEXT:    or a3, a4, a3
; RV32I-NEXT:    srli a4, a3, 2
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 4
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 8
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 16
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    srli a4, a3, 1
; RV32I-NEXT:    and a2, a4, a2
; RV32I-NEXT:    sub a3, a3, a2
; RV32I-NEXT:    and a2, a3, a1
; RV32I-NEXT:    srli a3, a3, 2
; RV32I-NEXT:    and a1, a3, a1
; RV32I-NEXT:    add a1, a2, a1
; RV32I-NEXT:    srli a2, a1, 4
; RV32I-NEXT:    add a1, a1, a2
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB11_3:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    li a0, 64
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB11_4:
; RV32I-NEXT:    srli a4, a3, 1
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 2
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 4
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 8
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    srli a4, a3, 16
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    srli a4, a3, 1
; RV32I-NEXT:    and a2, a4, a2
; RV32I-NEXT:    sub a3, a3, a2
; RV32I-NEXT:    and a2, a3, a1
; RV32I-NEXT:    srli a3, a3, 2
; RV32I-NEXT:    and a1, a3, a1
; RV32I-NEXT:    add a1, a2, a1
; RV32I-NEXT:    srli a2, a1, 4
; RV32I-NEXT:    add a1, a1, a2
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a1, a1
; RV32ZBB-NEXT:    bnez a1, .LBB11_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB11_2:
; RV32ZBB-NEXT:    clz a0, a1
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i64:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a2, a1
; RV32ZBBXQCIBM-NEXT:    bnez a2, .LBB11_2
; RV32ZBBXQCIBM-NEXT:  # %bb.1:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    addi a0, a0, 32
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
; RV32ZBBXQCIBM-NEXT:  .LBB11_2:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a1
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i64 %a, -1
  %tmp = call i64 @llvm.ctlz.i64(i64 %1, i1 false)
  ret i64 %tmp
}

define i8 @test_ctlz_i8_zero_undef(i8 %a) nounwind {
; RV32I-LABEL: test_ctlz_i8_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 25
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 26
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 24
; RV32I-NEXT:    srli a1, a1, 28
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i8_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    slli a0, a0, 24
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i8_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a0, a0
; RV32ZBBXQCIBM-NEXT:    slli a0, a0, 24
; RV32ZBBXQCIBM-NEXT:    clz a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i8 %a, -1
  %tmp = call i8 @llvm.ctlz.i8(i8 %1, i1 true)
  ret i8 %tmp
}

define i16 @test_ctlz_i16_zero_undef(i16 %a) nounwind {
; RV32I-LABEL: test_ctlz_i16_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    lui a1, 5
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    srli a2, a2, 17
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 18
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 20
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    slli a2, a0, 16
; RV32I-NEXT:    srli a2, a2, 24
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    lui a2, 3
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 15
; RV32I-NEXT:    slli a0, a0, 20
; RV32I-NEXT:    srli a0, a0, 28
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i16_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    slli a0, a0, 16
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i16_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a0, a0
; RV32ZBBXQCIBM-NEXT:    slli a0, a0, 16
; RV32ZBBXQCIBM-NEXT:    clz a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i16 %a, -1
  %tmp = call i16 @llvm.ctlz.i16(i16 %1, i1 true)
  ret i16 %tmp
}

define i32 @test_ctlz_i32_zero_undef(i32 %a) nounwind {
; RV32I-LABEL: test_ctlz_i32_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    addi a1, a1, 1365
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 2
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 4
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 8
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    srli a2, a0, 16
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    and a1, a2, a1
; RV32I-NEXT:    lui a2, 209715
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    lui a2, 61681
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    addi a1, a2, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i32_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i32_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i32 %a, -1
  %tmp = call i32 @llvm.ctlz.i32(i32 %1, i1 true)
  ret i32 %tmp
}

define i64 @test_ctlz_i64_zero_undef(i64 %a) nounwind {
; RV32I-LABEL: test_ctlz_i64_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a4, a1
; RV32I-NEXT:    lui a1, 349525
; RV32I-NEXT:    lui a2, 209715
; RV32I-NEXT:    lui a5, 61681
; RV32I-NEXT:    addi a3, a1, 1365
; RV32I-NEXT:    addi a2, a2, 819
; RV32I-NEXT:    addi a1, a5, -241
; RV32I-NEXT:    bnez a4, .LBB15_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a4, a0, 1
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 2
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 4
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 8
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 16
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a4, a0, 1
; RV32I-NEXT:    and a3, a4, a3
; RV32I-NEXT:    sub a0, a0, a3
; RV32I-NEXT:    and a3, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a3, a0
; RV32I-NEXT:    srli a2, a0, 4
; RV32I-NEXT:    add a0, a0, a2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB15_2:
; RV32I-NEXT:    srli a0, a4, 1
; RV32I-NEXT:    or a0, a4, a0
; RV32I-NEXT:    srli a4, a0, 2
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 4
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 8
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    srli a4, a0, 16
; RV32I-NEXT:    or a0, a0, a4
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a4, a0, 1
; RV32I-NEXT:    and a3, a4, a3
; RV32I-NEXT:    sub a0, a0, a3
; RV32I-NEXT:    and a3, a0, a2
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    add a0, a3, a0
; RV32I-NEXT:    srli a2, a0, 4
; RV32I-NEXT:    add a0, a0, a2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i64_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    not a1, a1
; RV32ZBB-NEXT:    bnez a1, .LBB15_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    not a0, a0
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB15_2:
; RV32ZBB-NEXT:    clz a0, a1
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV32ZBBXQCIBM-LABEL: test_ctlz_i64_zero_undef:
; RV32ZBBXQCIBM:       # %bb.0:
; RV32ZBBXQCIBM-NEXT:    not a2, a1
; RV32ZBBXQCIBM-NEXT:    bnez a2, .LBB15_2
; RV32ZBBXQCIBM-NEXT:  # %bb.1:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a0
; RV32ZBBXQCIBM-NEXT:    addi a0, a0, 32
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
; RV32ZBBXQCIBM-NEXT:  .LBB15_2:
; RV32ZBBXQCIBM-NEXT:    qc.clo a0, a1
; RV32ZBBXQCIBM-NEXT:    li a1, 0
; RV32ZBBXQCIBM-NEXT:    ret
  %1 = xor i64 %a, -1
  %tmp = call i64 @llvm.ctlz.i64(i64 %1, i1 true)
  ret i64 %tmp
}
