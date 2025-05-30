; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Canonicalize vector ge/le comparisons with constants to gt/lt.

; Normal types are ConstantDataVectors. Test the constant values adjacent to the
; min/max values that we're not allowed to transform.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

define <2 x i1> @sge(<2 x i8> %x) {
; CHECK-LABEL: @sge(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], <i8 -128, i8 126>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sge <2 x i8> %x, <i8 -127, i8 -129>
  ret <2 x i1> %cmp
}

define <2 x i1> @uge(<2 x i8> %x) {
; CHECK-LABEL: @uge(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt <2 x i8> [[X:%.*]], <i8 -2, i8 0>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp uge <2 x i8> %x, <i8 -1, i8 1>
  ret <2 x i1> %cmp
}

define <2 x i1> @sle(<2 x i8> %x) {
; CHECK-LABEL: @sle(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], <i8 127, i8 -127>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sle <2 x i8> %x, <i8 126, i8 128>
  ret <2 x i1> %cmp
}

define <2 x i1> @ule(<2 x i8> %x) {
; CHECK-LABEL: @ule(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult <2 x i8> [[X:%.*]], <i8 -1, i8 1>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp ule <2 x i8> %x, <i8 254, i8 0>
  ret <2 x i1> %cmp
}

define <2 x i1> @ult_min_signed_value(<2 x i8> %x) {
; CHECK-LABEL: @ult_min_signed_value(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp ult <2 x i8> %x, <i8 128, i8 128>
  ret <2 x i1> %cmp
}

; Zeros are special: they're ConstantAggregateZero.

define <2 x i1> @sge_zero(<2 x i8> %x) {
; CHECK-LABEL: @sge_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sge <2 x i8> %x, <i8 0, i8 0>
  ret <2 x i1> %cmp
}

define <2 x i1> @uge_zero(<2 x i8> %x) {
; CHECK-LABEL: @uge_zero(
; CHECK-NEXT:    ret <2 x i1> splat (i1 true)
;
  %cmp = icmp uge <2 x i8> %x, <i8 0, i8 0>
  ret <2 x i1> %cmp
}

define <2 x i1> @sle_zero(<2 x i8> %x) {
; CHECK-LABEL: @sle_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[X:%.*]], splat (i8 1)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sle <2 x i8> %x, <i8 0, i8 0>
  ret <2 x i1> %cmp
}

define <2 x i1> @ule_zero(<2 x i8> %x) {
; CHECK-LABEL: @ule_zero(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp ule <2 x i8> %x, <i8 0, i8 0>
  ret <2 x i1> %cmp
}

; Weird types are ConstantVectors, not ConstantDataVectors. For an i3 type:
; Signed min = -4
; Unsigned min = 0
; Signed max = 3
; Unsigned max = 7

define <3 x i1> @sge_weird(<3 x i3> %x) {
; CHECK-LABEL: @sge_weird(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <3 x i3> [[X:%.*]], <i3 -4, i3 2, i3 -1>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp sge <3 x i3> %x, <i3 -3, i3 -5, i3 0>
  ret <3 x i1> %cmp
}

define <3 x i1> @uge_weird(<3 x i3> %x) {
; CHECK-LABEL: @uge_weird(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt <3 x i3> [[X:%.*]], <i3 -2, i3 0, i3 1>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp uge <3 x i3> %x, <i3 -1, i3 1, i3 2>
  ret <3 x i1> %cmp
}

define <3 x i1> @sle_weird(<3 x i3> %x) {
; CHECK-LABEL: @sle_weird(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <3 x i3> [[X:%.*]], <i3 3, i3 -3, i3 1>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp sle <3 x i3> %x, <i3 2, i3 4, i3 0>
  ret <3 x i1> %cmp
}

define <3 x i1> @ule_weird(<3 x i3> %x) {
; CHECK-LABEL: @ule_weird(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult <3 x i3> [[X:%.*]], <i3 -1, i3 1, i3 2>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp ule <3 x i3> %x, <i3 6, i3 0, i3 1>
  ret <3 x i1> %cmp
}

; We can't do the transform if any constants are already at the limits.

define <2 x i1> @sge_min(<2 x i3> %x) {
; CHECK-LABEL: @sge_min(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge <2 x i3> [[X:%.*]], <i3 -4, i3 1>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sge <2 x i3> %x, <i3 -4, i3 1>
  ret <2 x i1> %cmp
}

define <2 x i1> @uge_min(<2 x i3> %x) {
; CHECK-LABEL: @uge_min(
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge <2 x i3> [[X:%.*]], <i3 1, i3 0>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp uge <2 x i3> %x, <i3 1, i3 0>
  ret <2 x i1> %cmp
}

define <2 x i1> @sle_max(<2 x i3> %x) {
; CHECK-LABEL: @sle_max(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle <2 x i3> [[X:%.*]], <i3 1, i3 3>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sle <2 x i3> %x, <i3 1, i3 3>
  ret <2 x i1> %cmp
}

define <2 x i1> @ule_max(<2 x i3> %x) {
; CHECK-LABEL: @ule_max(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule <2 x i3> [[X:%.*]], <i3 -1, i3 1>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp ule <2 x i3> %x, <i3 7, i3 1>
  ret <2 x i1> %cmp
}

define <2 x i1> @PR27756_1(<2 x i8> %a) {
; CHECK-LABEL: @PR27756_1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <2 x i8> [[A:%.*]], <i8 34, i8 1>
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sle <2 x i8> %a, <i8 bitcast (<2 x i4> <i4 1, i4 2> to i8), i8 0>
  ret <2 x i1> %cmp
}

; Undef elements don't prevent the transform of the comparison.

define <3 x i1> @PR27756_2(<3 x i8> %a) {
; CHECK-LABEL: @PR27756_2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt <3 x i8> [[A:%.*]], <i8 43, i8 43, i8 1>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp sle <3 x i8> %a, <i8 42, i8 poison, i8 0>
  ret <3 x i1> %cmp
}

define <3 x i1> @PR27756_3(<3 x i8> %a) {
; CHECK-LABEL: @PR27756_3(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <3 x i8> [[A:%.*]], <i8 0, i8 0, i8 41>
; CHECK-NEXT:    ret <3 x i1> [[CMP]]
;
  %cmp = icmp sge <3 x i8> %a, <i8 poison, i8 1, i8 42>
  ret <3 x i1> %cmp
}

@someglobal = global i32 0

define <2 x i1> @PR27786(<2 x i8> %a) {
; CHECK-LABEL: @PR27786(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle <2 x i8> [[A:%.*]], bitcast (i16 ptrtoint (ptr @someglobal to i16) to <2 x i8>)
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %cmp = icmp sle <2 x i8> %a, bitcast (i16 ptrtoint (ptr @someglobal to i16) to <2 x i8>)
  ret <2 x i1> %cmp
}

; This is similar to a transform for shuffled binops: compare first, shuffle after.

define <4 x i1> @same_shuffle_inputs_icmp(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @same_shuffle_inputs_icmp(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt <4 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <4 x i32> <i32 3, i32 3, i32 2, i32 0>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %shufx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> < i32 3, i32 3, i32 2, i32 0 >
  %shufy = shufflevector <4 x i8> %y, <4 x i8> poison, <4 x i32> < i32 3, i32 3, i32 2, i32 0 >
  %cmp = icmp sgt <4 x i8> %shufx, %shufy
  ret <4 x i1> %cmp
}

; fcmp and size-changing shuffles are ok too.

define <5 x i1> @same_shuffle_inputs_fcmp(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: @same_shuffle_inputs_fcmp(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq <4 x float> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <5 x i32> <i32 0, i32 1, i32 3, i32 2, i32 0>
; CHECK-NEXT:    ret <5 x i1> [[CMP]]
;
  %shufx = shufflevector <4 x float> %x, <4 x float> poison, <5 x i32> < i32 0, i32 1, i32 3, i32 2, i32 0 >
  %shufy = shufflevector <4 x float> %y, <4 x float> poison, <5 x i32> < i32 0, i32 1, i32 3, i32 2, i32 0 >
  %cmp = fcmp oeq <5 x float> %shufx, %shufy
  ret <5 x i1> %cmp
}

declare void @use_v4i8(<4 x i8>)

define <4 x i1> @same_shuffle_inputs_icmp_extra_use1(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @same_shuffle_inputs_icmp_extra_use1(
; CHECK-NEXT:    [[SHUFX:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt <4 x i8> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    call void @use_v4i8(<4 x i8> [[SHUFX]])
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %shufx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> < i32 3, i32 3, i32 3, i32 3 >
  %shufy = shufflevector <4 x i8> %y, <4 x i8> poison, <4 x i32> < i32 3, i32 3, i32 3, i32 3 >
  %cmp = icmp ugt <4 x i8> %shufx, %shufy
  call void @use_v4i8(<4 x i8> %shufx)
  ret <4 x i1> %cmp
}

declare void @use_v2i8(<2 x i8>)

define <2 x i1> @same_shuffle_inputs_icmp_extra_use2(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @same_shuffle_inputs_icmp_extra_use2(
; CHECK-NEXT:    [[SHUFY:%.*]] = shufflevector <4 x i8> [[Y:%.*]], <4 x i8> poison, <2 x i32> <i32 3, i32 2>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <4 x i8> [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <2 x i32> <i32 3, i32 2>
; CHECK-NEXT:    call void @use_v2i8(<2 x i8> [[SHUFY]])
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %shufx = shufflevector <4 x i8> %x, <4 x i8> poison, <2 x i32> < i32 3, i32 2 >
  %shufy = shufflevector <4 x i8> %y, <4 x i8> poison, <2 x i32> < i32 3, i32 2 >
  %cmp = icmp eq <2 x i8> %shufx, %shufy
  call void @use_v2i8(<2 x i8> %shufy)
  ret <2 x i1> %cmp
}

; Negative test: if both shuffles have extra uses, don't transform because that would increase instruction count.

define <2 x i1> @same_shuffle_inputs_icmp_extra_use3(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @same_shuffle_inputs_icmp_extra_use3(
; CHECK-NEXT:    [[SHUFX:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[SHUFY:%.*]] = shufflevector <4 x i8> [[Y:%.*]], <4 x i8> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[SHUFX]], [[SHUFY]]
; CHECK-NEXT:    call void @use_v2i8(<2 x i8> [[SHUFX]])
; CHECK-NEXT:    call void @use_v2i8(<2 x i8> [[SHUFY]])
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %shufx = shufflevector <4 x i8> %x, <4 x i8> poison, <2 x i32> < i32 0, i32 0 >
  %shufy = shufflevector <4 x i8> %y, <4 x i8> poison, <2 x i32> < i32 0, i32 0 >
  %cmp = icmp eq <2 x i8> %shufx, %shufy
  call void @use_v2i8(<2 x i8> %shufx)
  call void @use_v2i8(<2 x i8> %shufy)
  ret <2 x i1> %cmp
}

define <4 x i1> @splat_icmp(<4 x i8> %x) {
; CHECK-LABEL: @splat_icmp(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sgt <4 x i8> [[X:%.*]], splat (i8 42)
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %cmp = icmp sgt <4 x i8> %splatx, <i8 42, i8 42, i8 42, i8 42>
  ret <4 x i1> %cmp
}

define <4 x i1> @splat_icmp_poison(<4 x i8> %x) {
; CHECK-LABEL: @splat_icmp_poison(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult <4 x i8> [[X:%.*]], splat (i8 42)
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <4 x i1> [[TMP1]], <4 x i1> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 2, i32 poison, i32 poison, i32 2>
  %cmp = icmp ult <4 x i8> %splatx, <i8 poison, i8 42, i8 poison, i8 42>
  ret <4 x i1> %cmp
}

define <4 x i1> @splat_icmp_larger_size(<2 x i8> %x) {
; CHECK-LABEL: @splat_icmp_larger_size(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <2 x i8> [[X:%.*]], splat (i8 42)
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <2 x i1> [[TMP1]], <2 x i1> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <2 x i8> %x, <2 x i8> poison, <4 x i32> <i32 1, i32 poison, i32 1, i32 poison>
  %cmp = icmp eq <4 x i8> %splatx, <i8 42, i8 42, i8 poison, i8 42>
  ret <4 x i1> %cmp
}

define <4 x i1> @splat_fcmp_smaller_size(<5 x float> %x) {
; CHECK-LABEL: @splat_fcmp_smaller_size(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp oeq <5 x float> [[X:%.*]], splat (float 4.200000e+01)
; CHECK-NEXT:    [[CMP:%.*]] = shufflevector <5 x i1> [[TMP1]], <5 x i1> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <5 x float> %x, <5 x float> poison, <4 x i32> <i32 1, i32 poison, i32 1, i32 poison>
  %cmp = fcmp oeq <4 x float> %splatx, <float 42.0, float 42.0, float poison, float 42.0>
  ret <4 x i1> %cmp
}

; Negative test

define <4 x i1> @splat_icmp_extra_use(<4 x i8> %x) {
; CHECK-LABEL: @splat_icmp_extra_use(
; CHECK-NEXT:    [[SPLATX:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    call void @use_v4i8(<4 x i8> [[SPLATX]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <4 x i8> [[SPLATX]], splat (i8 42)
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  call void @use_v4i8(<4 x i8> %splatx)
  %cmp = icmp sgt <4 x i8> %splatx, <i8 42, i8 42, i8 42, i8 42>
  ret <4 x i1> %cmp
}

; Negative test

define <4 x i1> @not_splat_icmp(<4 x i8> %x) {
; CHECK-LABEL: @not_splat_icmp(
; CHECK-NEXT:    [[SPLATX:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> <i32 3, i32 2, i32 3, i32 3>
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <4 x i8> [[SPLATX]], splat (i8 42)
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 3, i32 2, i32 3, i32 3>
  %cmp = icmp sgt <4 x i8> %splatx, <i8 42, i8 42, i8 42, i8 42>
  ret <4 x i1> %cmp
}

; Negative test

define <4 x i1> @not_splat_icmp2(<4 x i8> %x) {
; CHECK-LABEL: @not_splat_icmp2(
; CHECK-NEXT:    [[SPLATX:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt <4 x i8> [[SPLATX]], <i8 43, i8 42, i8 42, i8 42>
; CHECK-NEXT:    ret <4 x i1> [[CMP]]
;
  %splatx = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  %cmp = icmp sgt <4 x i8> %splatx, <i8 43, i8 42, i8 42, i8 42>
  ret <4 x i1> %cmp
}

; Check that we don't absorb the compare into the select, which is in the
; canonical form of logical or.
define <2 x i1> @icmp_logical_or_vec(<2 x i64> %x, <2 x i64> %y, <2 x i1> %falseval) {
; CHECK-LABEL: @icmp_logical_or_vec(
; CHECK-NEXT:    [[CMP_NE:%.*]] = icmp ne <2 x i64> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    [[SEL:%.*]] = select <2 x i1> [[CMP_NE]], <2 x i1> splat (i1 true), <2 x i1> [[FALSEVAL:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[SEL]]
;
  %cmp.ne = icmp ne <2 x i64> %x, zeroinitializer
  %sel = select <2 x i1> %cmp.ne, <2 x i1> shufflevector (<2 x i1> insertelement (<2 x i1> poison, i1 true, i32 0), <2 x i1> poison, <2 x i32> zeroinitializer), <2 x i1> %falseval
  ret <2 x i1> %sel
}

; The above, but for scalable vectors. Absorbing the compare into the select
; and breaking the canonical form led to an infinite loop.
define <vscale x 2 x i1> @icmp_logical_or_scalablevec(<vscale x 2 x i64> %x, <vscale x 2 x i64> %y, <vscale x 2 x i1> %falseval) {
; CHECK-LABEL: @icmp_logical_or_scalablevec(
; CHECK-NEXT:    [[CMP_NE:%.*]] = icmp ne <vscale x 2 x i64> [[X:%.*]], zeroinitializer
; CHECK-NEXT:    [[SEL:%.*]] = select <vscale x 2 x i1> [[CMP_NE]], <vscale x 2 x i1> splat (i1 true), <vscale x 2 x i1> [[FALSEVAL:%.*]]
; CHECK-NEXT:    ret <vscale x 2 x i1> [[SEL]]
;
  %cmp.ne = icmp ne <vscale x 2 x i64> %x, zeroinitializer
  %sel = select <vscale x 2 x i1> %cmp.ne, <vscale x 2 x i1> splat (i1 true), <vscale x 2 x i1> %falseval
  ret <vscale x 2 x i1> %sel
}

define i1 @eq_cast_eq-1(<2 x i4> %x, <2 x i4> %y) {
; CHECK-LABEL: @eq_cast_eq-1(
; CHECK-NEXT:    [[X_SCALAR:%.*]] = bitcast <2 x i4> [[X:%.*]] to i8
; CHECK-NEXT:    [[Y_SCALAR:%.*]] = bitcast <2 x i4> [[Y:%.*]] to i8
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[X_SCALAR]], [[Y_SCALAR]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x i4> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp eq i2 %b, -1
  ret i1 %r
}

define i1 @ne_cast_eq-1(<3 x i7> %x, <3 x i7> %y) {
; CHECK-LABEL: @ne_cast_eq-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <3 x i7> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <3 x i1> [[TMP1]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp eq i3 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp ne <3 x i7> %x, %y
  %b = bitcast <3 x i1> %ic to i3
  %r = icmp eq i3 %b, -1
  ret i1 %r
}

define i1 @eq_cast_ne-1(<2 x i7> %x, <2 x i7> %y) {
; CHECK-LABEL: @eq_cast_ne-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne <2 x i7> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i1> [[TMP1]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp ne i2 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x i7> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp ne i2 %b, -1
  ret i1 %r
}

define i1 @eq_cast_ne-1-legal-scalar(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @eq_cast_ne-1-legal-scalar(
; CHECK-NEXT:    [[X_SCALAR:%.*]] = bitcast <2 x i8> [[X:%.*]] to i16
; CHECK-NEXT:    [[Y_SCALAR:%.*]] = bitcast <2 x i8> [[Y:%.*]] to i16
; CHECK-NEXT:    [[R:%.*]] = icmp ne i16 [[X_SCALAR]], [[Y_SCALAR]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x i8> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp ne i2 %b, -1
  ret i1 %r
}

define i1 @ne_cast_ne-1(<3 x i5> %x, <3 x i5> %y) {
; CHECK-LABEL: @ne_cast_ne-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <3 x i5> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <3 x i1> [[TMP1]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp ne i3 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp ne <3 x i5> %x, %y
  %b = bitcast <3 x i1> %ic to i3
  %r = icmp ne i3 %b, -1
  ret i1 %r
}

define i1 @ugt_cast_eq-1(<2 x i4> %x, <2 x i4> %y) {
; CHECK-LABEL: @ugt_cast_eq-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule <2 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i1> [[TMP1]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp eq i2 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp ugt <2 x i4> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp eq i2 %b, -1
  ret i1 %r
}

define i1 @slt_cast_ne-1(<2 x i4> %x, <2 x i4> %y) {
; CHECK-LABEL: @slt_cast_ne-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp sge <2 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i1> [[TMP1]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp ne i2 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp slt <2 x i4> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp ne i2 %b, -1
  ret i1 %r
}

define i1 @ueq_cast_eq-1(<3 x float> %x, <3 x float> %y) {
; CHECK-LABEL: @ueq_cast_eq-1(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp one <3 x float> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <3 x i1> [[TMP1]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp eq i3 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %fc = fcmp ueq <3 x float> %x, %y
  %b = bitcast <3 x i1> %fc to i3
  %r = icmp eq i3 %b, -1
  ret i1 %r
}

define i1 @not_cast_ne-1(<3 x i1> %x) {
; CHECK-LABEL: @not_cast_ne-1(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <3 x i1> [[X:%.*]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp ne i3 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %not = xor <3 x i1> %x, <i1 -1, i1 -1, i1 -1>
  %b = bitcast <3 x i1> %not to i3
  %r = icmp ne i3 %b, -1
  ret i1 %r
}

define i1 @not_cast_ne-1_uses(<3 x i2> %x, ptr %p) {
; CHECK-LABEL: @not_cast_ne-1_uses(
; CHECK-NEXT:    [[NOT:%.*]] = xor <3 x i2> [[X:%.*]], splat (i2 -1)
; CHECK-NEXT:    store <3 x i2> [[NOT]], ptr [[P:%.*]], align 1
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <3 x i2> [[X]] to i6
; CHECK-NEXT:    [[R:%.*]] = icmp ne i6 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %not = xor <3 x i2> %x, <i2 -1, i2 -1, i2 -1>
  store <3 x i2> %not, ptr %p
  %b = bitcast <3 x i2> %not to i6
  %r = icmp ne i6 %b, -1
  ret i1 %r
}

; negative test - need equality pred on 2nd cmp

define i1 @eq_cast_sgt-1(<3 x i4> %x, <3 x i4> %y) {
; CHECK-LABEL: @eq_cast_sgt-1(
; CHECK-NEXT:    [[IC:%.*]] = icmp eq <3 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[B:%.*]] = bitcast <3 x i1> [[IC]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i3 [[B]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <3 x i4> %x, %y
  %b = bitcast <3 x i1> %ic to i3
  %r = icmp sgt i3 %b, -1
  ret i1 %r
}

; negative test - need all-ones constant on 2nd cmp

define i1 @eq_cast_eq1(<2 x i4> %x, <2 x i4> %y) {
; CHECK-LABEL: @eq_cast_eq1(
; CHECK-NEXT:    [[IC:%.*]] = icmp eq <2 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[B:%.*]] = bitcast <2 x i1> [[IC]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp eq i2 [[B]], 1
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x i4> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp eq i2 %b, 1
  ret i1 %r
}

; negative test - extra use

define i1 @eq_cast_eq-1_use1(<2 x i4> %x, <2 x i4> %y, ptr %p) {
; CHECK-LABEL: @eq_cast_eq-1_use1(
; CHECK-NEXT:    [[IC:%.*]] = icmp sgt <2 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    store <2 x i1> [[IC]], ptr [[P:%.*]], align 1
; CHECK-NEXT:    [[B:%.*]] = bitcast <2 x i1> [[IC]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp eq i2 [[B]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp sgt <2 x i4> %x, %y
  store <2 x i1> %ic, ptr %p
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp eq i2 %b, -1
  ret i1 %r
}

; negative test - extra use

define i1 @eq_cast_eq-1_use2(<2 x i4> %x, <2 x i4> %y, ptr %p) {
; CHECK-LABEL: @eq_cast_eq-1_use2(
; CHECK-NEXT:    [[IC:%.*]] = icmp sgt <2 x i4> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[B:%.*]] = bitcast <2 x i1> [[IC]] to i2
; CHECK-NEXT:    store <2 x i1> [[IC]], ptr [[P:%.*]], align 1
; CHECK-NEXT:    [[R:%.*]] = icmp eq i2 [[B]], -1
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp sgt <2 x i4> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  store i2 %b, ptr %p
  %r = icmp eq i2 %b, -1
  ret i1 %r
}

define i1 @ne_cast_sext(<3 x i1> %b) {
; CHECK-LABEL: @ne_cast_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <3 x i1> [[B:%.*]] to i3
; CHECK-NEXT:    [[R:%.*]] = icmp ne i3 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = sext <3 x i1> %b to <3 x i8>
  %bc = bitcast <3 x i8> %e to i24
  %r = icmp ne i24 %bc, 0
  ret i1 %r
}

define i1 @eq_cast_sext(<8 x i3> %b) {
; CHECK-LABEL: @eq_cast_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i3> [[B:%.*]] to i24
; CHECK-NEXT:    [[R:%.*]] = icmp eq i24 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = sext <8 x i3> %b to <8 x i8>
  %bc = bitcast <8 x i8> %e to i64
  %r = icmp eq i64 %bc, 0
  ret i1 %r
}

define i1 @ne_cast_zext(<4 x i1> %b) {
; CHECK-LABEL: @ne_cast_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[B:%.*]] to i4
; CHECK-NEXT:    [[R:%.*]] = icmp ne i4 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = zext <4 x i1> %b to <4 x i8>
  %bc = bitcast <4 x i8> %e to i32
  %r = icmp ne i32 %bc, 0
  ret i1 %r
}

define i1 @eq_cast_zext(<5 x i3> %b) {
; CHECK-LABEL: @eq_cast_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <5 x i3> [[B:%.*]] to i15
; CHECK-NEXT:    [[R:%.*]] = icmp eq i15 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = zext <5 x i3> %b to <5 x i7>
  %bc = bitcast <5 x i7> %e to i35
  %r = icmp eq i35 %bc, 0
  ret i1 %r
}

; negative test - valid for eq/ne only

define i1 @sgt_cast_zext(<5 x i3> %b) {
; CHECK-LABEL: @sgt_cast_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <5 x i3> [[B:%.*]] to i15
; CHECK-NEXT:    [[R:%.*]] = icmp ne i15 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = zext <5 x i3> %b to <5 x i7>
  %bc = bitcast <5 x i7> %e to i35
  %r = icmp sgt i35 %bc, 0
  ret i1 %r
}

; negative test - not valid with non-zero constants
; TODO: We could handle some non-zero constants by checking for bit-loss after casts.

define i1 @eq7_cast_sext(<5 x i3> %b) {
; CHECK-LABEL: @eq7_cast_sext(
; CHECK-NEXT:    [[E:%.*]] = sext <5 x i3> [[B:%.*]] to <5 x i7>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <5 x i7> [[E]] to i35
; CHECK-NEXT:    [[R:%.*]] = icmp eq i35 [[BC]], 7
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = sext <5 x i3> %b to <5 x i7>
  %bc = bitcast <5 x i7> %e to i35
  %r = icmp eq i35 %bc, 7
  ret i1 %r
}

; extra use of extend is ok

define i1 @eq_cast_zext_use1(<5 x i3> %b, ptr %p) {
; CHECK-LABEL: @eq_cast_zext_use1(
; CHECK-NEXT:    [[E:%.*]] = zext <5 x i3> [[B:%.*]] to <5 x i7>
; CHECK-NEXT:    store <5 x i7> [[E]], ptr [[P:%.*]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <5 x i3> [[B]] to i15
; CHECK-NEXT:    [[R:%.*]] = icmp eq i15 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = zext <5 x i3> %b to <5 x i7>
  store <5 x i7> %e, ptr %p
  %bc = bitcast <5 x i7> %e to i35
  %r = icmp eq i35 %bc, 0
  ret i1 %r
}

; negative test - don't create an extra cast

declare void @use35(i35)

define i1 @eq_cast_zext_use2(<5 x i3> %b) {
; CHECK-LABEL: @eq_cast_zext_use2(
; CHECK-NEXT:    [[E:%.*]] = zext <5 x i3> [[B:%.*]] to <5 x i7>
; CHECK-NEXT:    [[BC:%.*]] = bitcast <5 x i7> [[E]] to i35
; CHECK-NEXT:    call void @use35(i35 [[BC]])
; CHECK-NEXT:    [[R:%.*]] = icmp eq i35 [[BC]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %e = zext <5 x i3> %b to <5 x i7>
  %bc = bitcast <5 x i7> %e to i35
  call void @use35(i35 %bc)
  %r = icmp eq i35 %bc, 0
  ret i1 %r
}

define i1 @eq_cast_eq_ptr-1(<2 x ptr> %x, <2 x ptr> %y) {
; CHECK-LABEL: @eq_cast_eq_ptr-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne <2 x ptr> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i1> [[TMP1]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp eq i2 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x ptr> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp eq i2 %b, -1
  ret i1 %r
}

define i1 @eq_cast_ne_ptr-1(<2 x ptr> %x, <2 x ptr> %y) {
; CHECK-LABEL: @eq_cast_ne_ptr-1(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne <2 x ptr> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <2 x i1> [[TMP1]] to i2
; CHECK-NEXT:    [[R:%.*]] = icmp ne i2 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %ic = icmp eq <2 x ptr> %x, %y
  %b = bitcast <2 x i1> %ic to i2
  %r = icmp ne i2 %b, -1
  ret i1 %r
}
