; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

%printf_t.3 = type { i64 }
%printf_t.2 = type { i64 }
%printf_t.1 = type { i64 }
%printf_t.0 = type { i64 }
%printf_t = type { i64 }

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @BEGIN(i8* %0) section "s_BEGIN_1" !dbg !4 {
entry:
  %key48 = alloca i32, align 4
  %printf_args42 = alloca %printf_t.3, align 8
  %key35 = alloca i32, align 4
  %printf_args29 = alloca %printf_t.2, align 8
  %key22 = alloca i32, align 4
  %printf_args16 = alloca %printf_t.1, align 8
  %key9 = alloca i32, align 4
  %printf_args3 = alloca %printf_t.0, align 8
  %key = alloca i32, align 4
  %printf_args = alloca %printf_t, align 8
  %"@i_val" = alloca i64, align 8
  %"@i_key" = alloca i64, align 8
  %1 = bitcast i64* %"@i_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %1)
  store i64 0, i64* %"@i_key", align 8
  %2 = bitcast i64* %"@i_val" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %2)
  store i64 0, i64* %"@i_val", align 8
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 0)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, i64*, i64)*)(i64 %pseudo, i64* %"@i_key", i64* %"@i_val", i64 0)
  %3 = bitcast i64* %"@i_val" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %3)
  %4 = bitcast i64* %"@i_key" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %4)
  %5 = bitcast %printf_t* %printf_args to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %5)
  %6 = bitcast %printf_t* %printf_args to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %6, i8 0, i64 8, i1 false)
  %7 = getelementptr %printf_t, %printf_t* %printf_args, i32 0, i32 0
  store i64 0, i64* %7, align 8
  %pseudo1 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %ringbuf_output = call i64 inttoptr (i64 130 to i64 (i64, %printf_t*, i64, i64)*)(i64 %pseudo1, %printf_t* %printf_args, i64 8, i64 0)
  %ringbuf_loss = icmp slt i64 %ringbuf_output, 0
  br i1 %ringbuf_loss, label %event_loss_counter, label %counter_merge

event_loss_counter:                               ; preds = %entry
  %8 = bitcast i32* %key to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %8)
  store i32 0, i32* %key, align 4
  %pseudo2 = call i64 @llvm.bpf.pseudo(i64 1, i64 2)
  %lookup_elem = call i8* inttoptr (i64 1 to i8* (i64, i32*)*)(i64 %pseudo2, i32* %key)
  %map_lookup_cond = icmp ne i8* %lookup_elem, null
  br i1 %map_lookup_cond, label %lookup_success, label %lookup_failure

counter_merge:                                    ; preds = %lookup_merge, %entry
  %9 = bitcast %printf_t* %printf_args to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %9)
  %10 = bitcast %printf_t.0* %printf_args3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %10)
  %11 = bitcast %printf_t.0* %printf_args3 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %11, i8 0, i64 8, i1 false)
  %12 = getelementptr %printf_t.0, %printf_t.0* %printf_args3, i32 0, i32 0
  store i64 0, i64* %12, align 8
  %pseudo4 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %ringbuf_output5 = call i64 inttoptr (i64 130 to i64 (i64, %printf_t.0*, i64, i64)*)(i64 %pseudo4, %printf_t.0* %printf_args3, i64 8, i64 0)
  %ringbuf_loss8 = icmp slt i64 %ringbuf_output5, 0
  br i1 %ringbuf_loss8, label %event_loss_counter6, label %counter_merge7

lookup_success:                                   ; preds = %event_loss_counter
  %13 = bitcast i8* %lookup_elem to i64*
  %14 = atomicrmw add i64* %13, i64 1 seq_cst
  br label %lookup_merge

lookup_failure:                                   ; preds = %event_loss_counter
  br label %lookup_merge

lookup_merge:                                     ; preds = %lookup_failure, %lookup_success
  %15 = bitcast i32* %key to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %15)
  br label %counter_merge

event_loss_counter6:                              ; preds = %counter_merge
  %16 = bitcast i32* %key9 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %16)
  store i32 0, i32* %key9, align 4
  %pseudo10 = call i64 @llvm.bpf.pseudo(i64 1, i64 2)
  %lookup_elem11 = call i8* inttoptr (i64 1 to i8* (i64, i32*)*)(i64 %pseudo10, i32* %key9)
  %map_lookup_cond15 = icmp ne i8* %lookup_elem11, null
  br i1 %map_lookup_cond15, label %lookup_success12, label %lookup_failure13

counter_merge7:                                   ; preds = %lookup_merge14, %counter_merge
  %17 = bitcast %printf_t.0* %printf_args3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %17)
  %18 = bitcast %printf_t.1* %printf_args16 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %18)
  %19 = bitcast %printf_t.1* %printf_args16 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %19, i8 0, i64 8, i1 false)
  %20 = getelementptr %printf_t.1, %printf_t.1* %printf_args16, i32 0, i32 0
  store i64 0, i64* %20, align 8
  %pseudo17 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %ringbuf_output18 = call i64 inttoptr (i64 130 to i64 (i64, %printf_t.1*, i64, i64)*)(i64 %pseudo17, %printf_t.1* %printf_args16, i64 8, i64 0)
  %ringbuf_loss21 = icmp slt i64 %ringbuf_output18, 0
  br i1 %ringbuf_loss21, label %event_loss_counter19, label %counter_merge20

lookup_success12:                                 ; preds = %event_loss_counter6
  %21 = bitcast i8* %lookup_elem11 to i64*
  %22 = atomicrmw add i64* %21, i64 1 seq_cst
  br label %lookup_merge14

lookup_failure13:                                 ; preds = %event_loss_counter6
  br label %lookup_merge14

lookup_merge14:                                   ; preds = %lookup_failure13, %lookup_success12
  %23 = bitcast i32* %key9 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %23)
  br label %counter_merge7

event_loss_counter19:                             ; preds = %counter_merge7
  %24 = bitcast i32* %key22 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %24)
  store i32 0, i32* %key22, align 4
  %pseudo23 = call i64 @llvm.bpf.pseudo(i64 1, i64 2)
  %lookup_elem24 = call i8* inttoptr (i64 1 to i8* (i64, i32*)*)(i64 %pseudo23, i32* %key22)
  %map_lookup_cond28 = icmp ne i8* %lookup_elem24, null
  br i1 %map_lookup_cond28, label %lookup_success25, label %lookup_failure26

counter_merge20:                                  ; preds = %lookup_merge27, %counter_merge7
  %25 = bitcast %printf_t.1* %printf_args16 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %25)
  %26 = bitcast %printf_t.2* %printf_args29 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %26)
  %27 = bitcast %printf_t.2* %printf_args29 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %27, i8 0, i64 8, i1 false)
  %28 = getelementptr %printf_t.2, %printf_t.2* %printf_args29, i32 0, i32 0
  store i64 0, i64* %28, align 8
  %pseudo30 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %ringbuf_output31 = call i64 inttoptr (i64 130 to i64 (i64, %printf_t.2*, i64, i64)*)(i64 %pseudo30, %printf_t.2* %printf_args29, i64 8, i64 0)
  %ringbuf_loss34 = icmp slt i64 %ringbuf_output31, 0
  br i1 %ringbuf_loss34, label %event_loss_counter32, label %counter_merge33

lookup_success25:                                 ; preds = %event_loss_counter19
  %29 = bitcast i8* %lookup_elem24 to i64*
  %30 = atomicrmw add i64* %29, i64 1 seq_cst
  br label %lookup_merge27

lookup_failure26:                                 ; preds = %event_loss_counter19
  br label %lookup_merge27

lookup_merge27:                                   ; preds = %lookup_failure26, %lookup_success25
  %31 = bitcast i32* %key22 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %31)
  br label %counter_merge20

event_loss_counter32:                             ; preds = %counter_merge20
  %32 = bitcast i32* %key35 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %32)
  store i32 0, i32* %key35, align 4
  %pseudo36 = call i64 @llvm.bpf.pseudo(i64 1, i64 2)
  %lookup_elem37 = call i8* inttoptr (i64 1 to i8* (i64, i32*)*)(i64 %pseudo36, i32* %key35)
  %map_lookup_cond41 = icmp ne i8* %lookup_elem37, null
  br i1 %map_lookup_cond41, label %lookup_success38, label %lookup_failure39

counter_merge33:                                  ; preds = %lookup_merge40, %counter_merge20
  %33 = bitcast %printf_t.2* %printf_args29 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %33)
  %34 = bitcast %printf_t.3* %printf_args42 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %34)
  %35 = bitcast %printf_t.3* %printf_args42 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %35, i8 0, i64 8, i1 false)
  %36 = getelementptr %printf_t.3, %printf_t.3* %printf_args42, i32 0, i32 0
  store i64 0, i64* %36, align 8
  %pseudo43 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %ringbuf_output44 = call i64 inttoptr (i64 130 to i64 (i64, %printf_t.3*, i64, i64)*)(i64 %pseudo43, %printf_t.3* %printf_args42, i64 8, i64 0)
  %ringbuf_loss47 = icmp slt i64 %ringbuf_output44, 0
  br i1 %ringbuf_loss47, label %event_loss_counter45, label %counter_merge46

lookup_success38:                                 ; preds = %event_loss_counter32
  %37 = bitcast i8* %lookup_elem37 to i64*
  %38 = atomicrmw add i64* %37, i64 1 seq_cst
  br label %lookup_merge40

lookup_failure39:                                 ; preds = %event_loss_counter32
  br label %lookup_merge40

lookup_merge40:                                   ; preds = %lookup_failure39, %lookup_success38
  %39 = bitcast i32* %key35 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %39)
  br label %counter_merge33

event_loss_counter45:                             ; preds = %counter_merge33
  %40 = bitcast i32* %key48 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %40)
  store i32 0, i32* %key48, align 4
  %pseudo49 = call i64 @llvm.bpf.pseudo(i64 1, i64 2)
  %lookup_elem50 = call i8* inttoptr (i64 1 to i8* (i64, i32*)*)(i64 %pseudo49, i32* %key48)
  %map_lookup_cond54 = icmp ne i8* %lookup_elem50, null
  br i1 %map_lookup_cond54, label %lookup_success51, label %lookup_failure52

counter_merge46:                                  ; preds = %lookup_merge53, %counter_merge33
  %41 = bitcast %printf_t.3* %printf_args42 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %41)
  ret i64 0

lookup_success51:                                 ; preds = %event_loss_counter45
  %42 = bitcast i8* %lookup_elem50 to i64*
  %43 = atomicrmw add i64* %42, i64 1 seq_cst
  br label %lookup_merge53

lookup_failure52:                                 ; preds = %event_loss_counter45
  br label %lookup_merge53

lookup_merge53:                                   ; preds = %lookup_failure52, %lookup_success51
  %44 = bitcast i32* %key48 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %44)
  br label %counter_merge46
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly %0, i8 %1, i64 %2, i1 immarg %3) #2

attributes #0 = { nounwind }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn writeonly }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "bpftrace", isOptimized: false, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "bpftrace.bpf.o", directory: ".")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = distinct !DISubprogram(name: "BEGIN", linkageName: "BEGIN", scope: !1, file: !1, type: !5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !10)
!5 = !DISubroutineType(types: !6)
!6 = !{!7, !8}
!7 = !DIBasicType(name: "int64", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int8", size: 8, encoding: DW_ATE_signed)
!10 = !{!11, !12}
!11 = !DILocalVariable(name: "var0", scope: !4, file: !1, type: !7)
!12 = !DILocalVariable(name: "var1", arg: 1, scope: !4, file: !1, type: !8)
