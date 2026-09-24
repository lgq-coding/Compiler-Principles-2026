module {
  llvm.func @free(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr
  llvm.func @closeFileHandle(!llvm.ptr) attributes {sym_visibility = "private"}
  llvm.func private @printDataI16(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(i64, ptr)>
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(i64, ptr)>
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.alloca %3 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %2, %4 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    llvm.call @_mlir_ciface_printDataI16(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_printDataI16(!llvm.ptr, !llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func @getFileHandle(!llvm.ptr) -> !llvm.ptr attributes {sym_visibility = "private"}
  llvm.func private @getDataI16(%arg0: i64, %arg1: !llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"} {
    %0 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(i64, ptr)>
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(i64, ptr)>
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.alloca %3 x !llvm.struct<(i64, ptr)> : (i64) -> !llvm.ptr
    llvm.store %2, %4 : !llvm.struct<(i64, ptr)>, !llvm.ptr
    llvm.call @_mlir_ciface_getDataI16(%4) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_getDataI16(!llvm.ptr) attributes {llvm.emit_c_interface, sym_visibility = "private"}
  llvm.func @vecadd_host(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> attributes {hacc.function_kind = #hacc.function_kind<HOST>, hacc.host_func_type = #hacc.host_func_type<host_entry>} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg5, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg6, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg7, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg8, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg9, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg0, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg1, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg2, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg3, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg4, %10[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.mlir.constant(16 : index) : i64
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.mlir.constant(16 : index) : i64
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.mlir.zero : !llvm.ptr
    %18 = llvm.getelementptr %17[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %19 = llvm.ptrtoint %18 : !llvm.ptr to i64
    %20 = llvm.mlir.constant(64 : index) : i64
    %21 = llvm.add %19, %20 : i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.sub %20, %24 : i64
    %26 = llvm.add %23, %25 : i64
    %27 = llvm.urem %26, %20  : i64
    %28 = llvm.sub %26, %27 : i64
    %29 = llvm.inttoptr %28 : i64 to !llvm.ptr
    %30 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %31 = llvm.insertvalue %22, %30[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %32 = llvm.insertvalue %29, %31[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = llvm.mlir.constant(0 : index) : i64
    %34 = llvm.insertvalue %33, %32[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %35 = llvm.insertvalue %15, %34[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %36 = llvm.insertvalue %16, %35[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%14 : i64)
  ^bb1(%37: i64):  // 2 preds: ^bb0, ^bb2
    %38 = llvm.icmp "slt" %37, %13 : i64
    llvm.cond_br %38, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %39 = llvm.extractvalue %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %40 = llvm.getelementptr %39[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %41 = llvm.load %40 : !llvm.ptr -> i16
    %42 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %43 = llvm.getelementptr %42[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %44 = llvm.load %43 : !llvm.ptr -> i16
    %45 = llvm.add %41, %44 : i16
    %46 = llvm.extractvalue %36[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.getelementptr %46[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    llvm.store %45, %47 : i16, !llvm.ptr
    %48 = llvm.add %37, %12 : i64
    llvm.br ^bb1(%48 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return %36 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
  }
  llvm.func @main_wrapper(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(16 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.getelementptr %6[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr
    %10 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.insertvalue %9, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %4, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = llvm.insertvalue %5, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = llvm.mlir.constant(16 : index) : i64
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.getelementptr %19[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.call @malloc(%21) : (i64) -> !llvm.ptr
    %23 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.insertvalue %22, %23[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %25 = llvm.insertvalue %22, %24[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.mlir.constant(0 : index) : i64
    %27 = llvm.insertvalue %26, %25[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.insertvalue %17, %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = llvm.insertvalue %18, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.mlir.constant(1 : index) : i64
    %31 = llvm.alloca %30 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %16, %31 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %34 = llvm.insertvalue %32, %33[0] : !llvm.struct<(i64, ptr)>
    %35 = llvm.insertvalue %31, %34[1] : !llvm.struct<(i64, ptr)>
    %36 = llvm.mlir.constant(1 : index) : i64
    %37 = llvm.alloca %36 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %29, %37 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %40 = llvm.insertvalue %38, %39[0] : !llvm.struct<(i64, ptr)>
    %41 = llvm.insertvalue %37, %40[1] : !llvm.struct<(i64, ptr)>
    %42 = llvm.extractvalue %35[0] : !llvm.struct<(i64, ptr)>
    %43 = llvm.extractvalue %35[1] : !llvm.struct<(i64, ptr)>
    llvm.call @getDataI16(%42, %43) : (i64, !llvm.ptr) -> ()
    %44 = llvm.extractvalue %41[0] : !llvm.struct<(i64, ptr)>
    %45 = llvm.extractvalue %41[1] : !llvm.struct<(i64, ptr)>
    llvm.call @getDataI16(%44, %45) : (i64, !llvm.ptr) -> ()
    %46 = llvm.call @getFileHandle(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %47 = llvm.extractvalue %35[0] : !llvm.struct<(i64, ptr)>
    %48 = llvm.extractvalue %35[1] : !llvm.struct<(i64, ptr)>
    llvm.call @printDataI16(%46, %47, %48) : (!llvm.ptr, i64, !llvm.ptr) -> ()
    %49 = llvm.extractvalue %41[0] : !llvm.struct<(i64, ptr)>
    %50 = llvm.extractvalue %41[1] : !llvm.struct<(i64, ptr)>
    llvm.call @printDataI16(%46, %49, %50) : (!llvm.ptr, i64, !llvm.ptr) -> ()
    llvm.call @closeFileHandle(%46) : (!llvm.ptr) -> ()
    %51 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %52 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.extractvalue %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %54 = llvm.extractvalue %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %55 = llvm.extractvalue %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %56 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %57 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %58 = llvm.extractvalue %29[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %59 = llvm.extractvalue %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %60 = llvm.extractvalue %29[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %61 = llvm.call @vecadd_host(%51, %52, %53, %54, %55, %56, %57, %58, %59, %60) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %62 = llvm.mlir.constant(1 : index) : i64
    %63 = llvm.alloca %62 x !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> : (i64) -> !llvm.ptr
    llvm.store %61, %63 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr
    %64 = llvm.mlir.constant(1 : index) : i64
    %65 = llvm.mlir.undef : !llvm.struct<(i64, ptr)>
    %66 = llvm.insertvalue %64, %65[0] : !llvm.struct<(i64, ptr)>
    %67 = llvm.insertvalue %63, %66[1] : !llvm.struct<(i64, ptr)>
    %68 = llvm.call @getFileHandle(%arg1) : (!llvm.ptr) -> !llvm.ptr
    %69 = llvm.extractvalue %67[0] : !llvm.struct<(i64, ptr)>
    %70 = llvm.extractvalue %67[1] : !llvm.struct<(i64, ptr)>
    llvm.call @printDataI16(%68, %69, %70) : (!llvm.ptr, i64, !llvm.ptr) -> ()
    llvm.call @closeFileHandle(%68) : (!llvm.ptr) -> ()
    %71 = llvm.extractvalue %61[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %72 = llvm.extractvalue %61[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %73 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64)>
    %74 = llvm.insertvalue %71, %73[0] : !llvm.struct<(ptr, ptr, i64)>
    %75 = llvm.insertvalue %72, %74[1] : !llvm.struct<(ptr, ptr, i64)>
    %76 = llvm.mlir.constant(0 : index) : i64
    %77 = llvm.insertvalue %76, %75[2] : !llvm.struct<(ptr, ptr, i64)>
    %78 = llvm.extractvalue %61[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %79 = llvm.extractvalue %61[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %80 = llvm.extractvalue %61[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %81 = llvm.mlir.constant(3 : index) : i64
    %82 = llvm.mlir.constant(1 : index) : i64
    %83 = llvm.mlir.zero : !llvm.ptr
    %84 = llvm.getelementptr %83[%81] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %85 = llvm.ptrtoint %84 : !llvm.ptr to i64
    %86 = llvm.call @malloc(%85) : (i64) -> !llvm.ptr
    %87 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %88 = llvm.insertvalue %86, %87[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %89 = llvm.insertvalue %86, %88[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %90 = llvm.mlir.constant(0 : index) : i64
    %91 = llvm.insertvalue %90, %89[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %92 = llvm.insertvalue %81, %91[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %93 = llvm.insertvalue %82, %92[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %94 = llvm.mlir.constant(3 : index) : i64
    %95 = llvm.mlir.constant(1 : index) : i64
    %96 = llvm.mlir.zero : !llvm.ptr
    %97 = llvm.getelementptr %96[%94] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %98 = llvm.ptrtoint %97 : !llvm.ptr to i64
    %99 = llvm.call @malloc(%98) : (i64) -> !llvm.ptr
    %100 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %101 = llvm.insertvalue %99, %100[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %102 = llvm.insertvalue %99, %101[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %103 = llvm.mlir.constant(0 : index) : i64
    %104 = llvm.insertvalue %103, %102[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %105 = llvm.insertvalue %94, %104[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %106 = llvm.insertvalue %95, %105[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %107 = llvm.mlir.constant(0 : index) : i64
    %108 = llvm.mlir.constant(1 : index) : i64
    %109 = llvm.mlir.zero : !llvm.ptr
    %110 = llvm.getelementptr %109[%108] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %111 = llvm.ptrtoint %110 : !llvm.ptr to i64
    %112 = llvm.call @malloc(%111) : (i64) -> !llvm.ptr
    %113 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %114 = llvm.insertvalue %112, %113[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %115 = llvm.insertvalue %112, %114[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %116 = llvm.mlir.constant(0 : index) : i64
    %117 = llvm.insertvalue %116, %115[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %118 = llvm.insertvalue %107, %117[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %119 = llvm.insertvalue %108, %118[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %120 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %121 = llvm.ptrtoint %120 : !llvm.ptr to i64
    %122 = llvm.extractvalue %93[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %123 = llvm.getelementptr %122[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %121, %123 : i64, !llvm.ptr
    %124 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %125 = llvm.ptrtoint %124 : !llvm.ptr to i64
    %126 = llvm.extractvalue %93[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %127 = llvm.getelementptr %126[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %125, %127 : i64, !llvm.ptr
    %128 = llvm.extractvalue %61[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %129 = llvm.ptrtoint %128 : !llvm.ptr to i64
    %130 = llvm.extractvalue %93[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %131 = llvm.getelementptr %130[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %129, %131 : i64, !llvm.ptr
    %132 = llvm.extractvalue %106[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %133 = llvm.getelementptr %132[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %3, %133 : i1, !llvm.ptr
    %134 = llvm.extractvalue %106[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %135 = llvm.getelementptr %134[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %3, %135 : i1, !llvm.ptr
    %136 = llvm.extractvalue %106[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %137 = llvm.getelementptr %136[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %3, %137 : i1, !llvm.ptr
    %138 = llvm.mlir.constant(3 : index) : i64
    %139 = llvm.mlir.constant(1 : index) : i64
    %140 = llvm.mlir.zero : !llvm.ptr
    %141 = llvm.getelementptr %140[%138] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %142 = llvm.ptrtoint %141 : !llvm.ptr to i64
    %143 = llvm.call @malloc(%142) : (i64) -> !llvm.ptr
    %144 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %145 = llvm.insertvalue %143, %144[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %146 = llvm.insertvalue %143, %145[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %147 = llvm.mlir.constant(0 : index) : i64
    %148 = llvm.insertvalue %147, %146[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %149 = llvm.insertvalue %138, %148[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %150 = llvm.insertvalue %139, %149[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %151 = llvm.mlir.constant(0 : index) : i64
    %152 = llvm.mlir.constant(1 : index) : i64
    %153 = llvm.mlir.zero : !llvm.ptr
    %154 = llvm.getelementptr %153[%152] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %155 = llvm.ptrtoint %154 : !llvm.ptr to i64
    %156 = llvm.call @malloc(%155) : (i64) -> !llvm.ptr
    %157 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %158 = llvm.insertvalue %156, %157[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %159 = llvm.insertvalue %156, %158[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %160 = llvm.mlir.constant(0 : index) : i64
    %161 = llvm.insertvalue %160, %159[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %162 = llvm.insertvalue %151, %161[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %163 = llvm.insertvalue %152, %162[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %164 = llvm.extractvalue %93[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %165 = llvm.extractvalue %93[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %166 = llvm.extractvalue %93[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %167 = llvm.extractvalue %93[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %168 = llvm.extractvalue %93[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %169 = llvm.extractvalue %119[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %170 = llvm.extractvalue %119[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %171 = llvm.extractvalue %119[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %172 = llvm.extractvalue %119[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %173 = llvm.extractvalue %119[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %174 = llvm.extractvalue %106[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %175 = llvm.extractvalue %106[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %176 = llvm.extractvalue %106[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %177 = llvm.extractvalue %106[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %178 = llvm.extractvalue %106[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %179 = llvm.extractvalue %150[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %180 = llvm.extractvalue %150[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %181 = llvm.extractvalue %150[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %182 = llvm.extractvalue %150[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %183 = llvm.extractvalue %150[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %184 = llvm.extractvalue %163[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %185 = llvm.extractvalue %163[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %186 = llvm.extractvalue %163[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %187 = llvm.extractvalue %163[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %188 = llvm.extractvalue %163[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @dealloc_helper(%164, %165, %166, %167, %168, %169, %170, %171, %172, %173, %174, %175, %176, %177, %178, %179, %180, %181, %182, %183, %184, %185, %186, %187, %188) : (!llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64) -> ()
    %189 = llvm.extractvalue %150[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %190 = llvm.getelementptr %189[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %191 = llvm.load %190 : !llvm.ptr -> i1
    llvm.cond_br %191, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %192 = llvm.extractvalue %16[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%192) : (!llvm.ptr) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %193 = llvm.extractvalue %150[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %194 = llvm.getelementptr %193[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %195 = llvm.load %194 : !llvm.ptr -> i1
    llvm.cond_br %195, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %196 = llvm.extractvalue %29[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%196) : (!llvm.ptr) -> ()
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %197 = llvm.extractvalue %150[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %198 = llvm.getelementptr %197[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %199 = llvm.load %198 : !llvm.ptr -> i1
    llvm.cond_br %199, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %200 = llvm.extractvalue %77[0] : !llvm.struct<(ptr, ptr, i64)>
    llvm.call @free(%200) : (!llvm.ptr) -> ()
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    %201 = llvm.extractvalue %93[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%201) : (!llvm.ptr) -> ()
    %202 = llvm.extractvalue %119[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%202) : (!llvm.ptr) -> ()
    %203 = llvm.extractvalue %106[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%203) : (!llvm.ptr) -> ()
    %204 = llvm.extractvalue %150[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%204) : (!llvm.ptr) -> ()
    %205 = llvm.extractvalue %163[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.call @free(%205) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @dealloc_helper(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: !llvm.ptr, %arg16: !llvm.ptr, %arg17: i64, %arg18: i64, %arg19: i64, %arg20: !llvm.ptr, %arg21: !llvm.ptr, %arg22: i64, %arg23: i64, %arg24: i64) attributes {sym_visibility = "private"} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg20, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg21, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.insertvalue %arg22, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = llvm.insertvalue %arg23, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg24, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg15, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg16, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = llvm.insertvalue %arg17, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg18, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = llvm.insertvalue %arg19, %10[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %arg10, %12[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %arg11, %13[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %arg12, %14[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = llvm.insertvalue %arg13, %15[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = llvm.insertvalue %arg14, %16[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %19 = llvm.insertvalue %arg5, %18[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = llvm.insertvalue %arg6, %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %21 = llvm.insertvalue %arg7, %20[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = llvm.insertvalue %arg8, %21[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = llvm.insertvalue %arg9, %22[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.mlir.undef : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %25 = llvm.insertvalue %arg0, %24[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %26 = llvm.insertvalue %arg1, %25[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %arg2, %26[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = llvm.insertvalue %arg3, %27[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = llvm.insertvalue %arg4, %28[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = llvm.mlir.constant(0 : index) : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.constant(true) : i1
    %33 = llvm.mlir.constant(false) : i1
    %34 = llvm.extractvalue %29[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %35 = llvm.extractvalue %23[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    llvm.br ^bb1(%30 : i64)
  ^bb1(%36: i64):  // 2 preds: ^bb0, ^bb2
    %37 = llvm.icmp "slt" %36, %35 : i64
    llvm.cond_br %37, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %38 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %39 = llvm.getelementptr %38[%36] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %33, %39 : i1, !llvm.ptr
    %40 = llvm.add %36, %31 : i64
    llvm.br ^bb1(%40 : i64)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%30 : i64)
  ^bb4(%41: i64):  // 2 preds: ^bb3, ^bb13
    %42 = llvm.icmp "slt" %41, %34 : i64
    llvm.cond_br %42, ^bb5, ^bb14
  ^bb5:  // pred: ^bb4
    %43 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %44 = llvm.getelementptr %43[%41] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %45 = llvm.load %44 : !llvm.ptr -> i64
    %46 = llvm.extractvalue %17[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %47 = llvm.getelementptr %46[%41] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %48 = llvm.load %47 : !llvm.ptr -> i1
    llvm.br ^bb6(%30, %32 : i64, i1)
  ^bb6(%49: i64, %50: i1):  // 2 preds: ^bb5, ^bb9
    %51 = llvm.icmp "slt" %49, %35 : i64
    llvm.cond_br %51, ^bb7, ^bb10
  ^bb7:  // pred: ^bb6
    %52 = llvm.extractvalue %23[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %53 = llvm.getelementptr %52[%49] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %54 = llvm.load %53 : !llvm.ptr -> i64
    %55 = llvm.icmp "eq" %54, %45 : i64
    llvm.cond_br %55, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %56 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %57 = llvm.getelementptr %56[%49] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    %58 = llvm.load %57 : !llvm.ptr -> i1
    %59 = llvm.or %58, %48  : i1
    %60 = llvm.extractvalue %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %61 = llvm.getelementptr %60[%49] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %59, %61 : i1, !llvm.ptr
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb7, ^bb8
    %62 = llvm.icmp "ne" %54, %45 : i64
    %63 = llvm.and %50, %62  : i1
    %64 = llvm.add %49, %31 : i64
    llvm.br ^bb6(%64, %63 : i64, i1)
  ^bb10:  // pred: ^bb6
    llvm.br ^bb11(%30, %50 : i64, i1)
  ^bb11(%65: i64, %66: i1):  // 2 preds: ^bb10, ^bb12
    %67 = llvm.icmp "slt" %65, %41 : i64
    llvm.cond_br %67, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    %68 = llvm.extractvalue %29[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %69 = llvm.getelementptr %68[%65] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %70 = llvm.load %69 : !llvm.ptr -> i64
    %71 = llvm.icmp "ne" %70, %45 : i64
    %72 = llvm.and %66, %71  : i1
    %73 = llvm.add %65, %31 : i64
    llvm.br ^bb11(%73, %72 : i64, i1)
  ^bb13:  // pred: ^bb11
    %74 = llvm.and %66, %48  : i1
    %75 = llvm.extractvalue %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %76 = llvm.getelementptr %75[%41] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %74, %76 : i1, !llvm.ptr
    %77 = llvm.add %41, %31 : i64
    llvm.br ^bb4(%77 : i64)
  ^bb14:  // pred: ^bb4
    llvm.return
  }
}
