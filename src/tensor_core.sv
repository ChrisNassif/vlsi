module tensor_core (
    input logic [7:0] tensor_core_input1 [4][4], 
    input logic [7:0] tensor_core_input2 [4][4],
    output logic [7:0] tensor_core_output [4][4]
);
    always_comb begin
        
        for (int i = 0; i < 4; i++) begin
            for (int j = 0; j < 4; j++) begin

                tensor_core_output[i][j] = 0;
                for (int k = 0; k < 4; k++) begin
                    tensor_core_output[i][j] = tensor_core_output[i][j] + (tensor_core_input1[i][k] * tensor_core_input2[k][j]);
                end
            end
        end
    end


    // Expose the internals of this module to gtkwave
    genvar i, j;
    generate
        for (i = 0; i < 4; i++) begin : expose_tensor_core
            for (j = 0; j < 4; j++) begin: expose_tensor_core2
                wire [7:0] tensor_core_input1_wire = tensor_core_input1[i][j];
                wire [7:0] tensor_core_input2_wire = tensor_core_input2[i][j];
                wire [7:0] tensor_core_output_wire = tensor_core_output[i][j];
            end
        end
    endgenerate
endmodule
