module cpu (input logic clock_in, input logic [31:0] current_instruction, output logic [7:0] cpu_output);

    // TODO add code to support immediate instructions


    logic [7:0] alu_input1, alu_input2, alu_output;
    logic [2:0] alu_opcode;

    logic [7:0] cpu_register_file_read_register_address1, cpu_register_file_read_register_address2;
    logic [7:0] cpu_register_file_read_data1, cpu_register_file_read_data2;
    logic [7:0] cpu_register_file_write_register_address;
    logic [7:0] cpu_register_file_write_data;
    logic cpu_register_file_write_enable;

    logic tensor_core_register_file_write_enable
    logic [7:0] tensor_core_register_file_read_data [4] [4];


    alu main_alu(
        .clock_in(clock_in), .reset_in(1'b0), .enable_in(1'b1), 
        .opcode_in(alu_opcode), .alu_input1(alu_input1), .alu_input2(alu_input2), 
        .alu_output(alu_output)
    );


    cpu_register_file main_cpu_register_file (
        .clock_in(clock_in), .write_enable_in(cpu_register_file_write_enable), 
        .read_register_address1_in(cpu_register_file_read_register_address1), .read_register_address2_in(cpu_register_file_read_register_address2),
        .write_register_address_in(cpu_register_file_write_register_address), .write_data_in(cpu_register_file_write_data), 
        .read_data1_out(cpu_register_file_read_data1), .read_data2_out(cpu_register_file_read_data2)
    );
    

    tensor_core_register_file main_tensor_core_register_file (
        .clock_in(clock_in), .write_enable_in(tensor_core_register_file_write_enable), [$clog2(NUMBER_OF_REGISTERS)-1:0] write_register_address_in, write_data_in, read_data_out [(NUMBER_OF_REGISTERS-1)/16] [4] [4]
    );



    assign cpu_register_file_write_register_address = current_instruction[31:24];
    assign cpu_register_file_read_register_address1 = current_instruction[23:16];
    assign cpu_register_file_read_register_address2 = current_instruction[15:8];
    assign alu_opcode = current_instruction[2:0];

    assign cpu_register_file_write_enable = 1'b1;
    assign alu_input1 = current_instruction[23:16];     // TODO CHANGE THIS BACK TO register_file_read_data1 ONCE ADD IMMEDIATE IS ADDED
    assign alu_input2 = cpu_register_file_read_data2;
    assign cpu_register_file_write_data = alu_output;
  

endmodule