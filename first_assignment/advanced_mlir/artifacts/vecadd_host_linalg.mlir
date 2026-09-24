module {
  func.func @vecadd_host(%arg0: tensor<16xi16>, %arg1: tensor<16xi16>) -> tensor<16xi16> attributes {hacc.function_kind = #hacc.function_kind<HOST>, hacc.host_func_type = #hacc.host_func_type<host_entry>} {
    %0 = tensor.empty() : tensor<16xi16>
    %1 = linalg.add ins(%arg0, %arg1 : tensor<16xi16>, tensor<16xi16>) outs(%0 : tensor<16xi16>) -> tensor<16xi16>
    return %1 : tensor<16xi16>
  }
}
