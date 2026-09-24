// Exploratory CPU-lowering input only.
// The official NPU device example is vecadd.mlir.
module {
  func.func @vecadd_host(%a: tensor<16xi16>, %b: tensor<16xi16>) -> tensor<16xi16>
      attributes {
        hacc.function_kind = #hacc.function_kind<HOST>,
        hacc.host_func_type = #hacc.host_func_type<host_entry>
      } {
    %out = tensor.empty() : tensor<16xi16>
    %sum = hivm.hir.vadd ins(%a, %b : tensor<16xi16>, tensor<16xi16>)
                            outs(%out : tensor<16xi16>) -> tensor<16xi16>
    return %sum : tensor<16xi16>
  }
}
