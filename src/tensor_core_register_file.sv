// A register file meant to supply values to a tensor core.
// This register file exposes all of the wires to each register, so a tensor core can take each of the values inside the registers in a single clock cycle 
module tensor_core_register_file #(
    parameter NUMBER_OF_REGISTERS = 32
)(
    input logic clock_in,
    input logic write_enable_in,
    input logic [$clog2(NUMBER_OF_REGISTERS)-1:0] write_register_address_in,
    input logic [7:0] write_data_in,
    output logic [7:0] read_data_out [(NUMBER_OF_REGISTERS-1)/16] [4] [4]
);

    reg [7:0] registers [NUMBER_OF_REGISTERS/16] [4] [4];
    assign read_data_out = registers;

    initial begin
        for (int i = 0; i < (NUMBER_OF_REGISTERS-1)/16; i++) begin
            for (int j = 0; j < 4; j++) begin
                for (int k = 0; k < 4; k++) begin
                    registers[i][j][k] <= 8'b0;
                end
            end
        end
    end

    always_ff @(posedge clock_in) begin
        if (write_enable_in) begin
            registers[write_register_address_in/16][(write_register_address_in%16)/4][write_register_address_in%4] <= write_data_in;
        end
    end



    // make the registers visible to gtkwave
    genvar i;
    generate
        for (i = 0; i < NUMBER_OF_REGISTERS/16; i++) begin : expose_regs1
            for (j = 0; j < 4; j++) begin : expose_regs2
                for (k = 0; k < 4; k++) begin : expose_regs3
                    wire [7:0] reg_wire = registers[i][j][k];
                end
            end
        end
    endgenerate


endmodule