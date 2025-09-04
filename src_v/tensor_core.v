module small_tensor_core (
	clock_in,
	tensor_core_register_file_write_enable,
	tensor_core_input1,
	tensor_core_input2,
	tensor_core_output,
	is_done_with_calculation
);
	input wire clock_in;
	input wire tensor_core_register_file_write_enable;
	input wire [127:0] tensor_core_input1;
	input wire [127:0] tensor_core_input2;
	output reg [127:0] tensor_core_output;
	output reg is_done_with_calculation;
	reg [4:0] counter1;
	reg [4:0] counter2;
	always @(posedge clock_in) begin
		if (tensor_core_register_file_write_enable == 1) begin
			counter1 = 0;
			counter2 = 0;
			is_done_with_calculation = 0;
		end
		if (is_done_with_calculation == 0) begin
			if (counter2 == 0)
				tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] = 0;
			tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] = tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] + (tensor_core_input1[(((3 - (counter1 / 4)) * 4) + (3 - counter2)) * 8+:8] * tensor_core_input2[(((3 - counter2) * 4) + (3 - (counter1 % 4))) * 8+:8]);
			if (counter2 == 3) begin
				counter1 = counter1 + 1;
				counter2 = 0;
			end
			else
				counter2 = counter2 + 1;
		end
		if (counter1 == 5'b10000)
			is_done_with_calculation = 1;
	end
	genvar _gv_i_1;
	genvar _gv_j_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : expose_tensor_core
			localparam i = _gv_i_1;
			for (_gv_j_1 = 0; _gv_j_1 < 4; _gv_j_1 = _gv_j_1 + 1) begin : expose_tensor_core2
				localparam j = _gv_j_1;
				wire [7:0] tensor_core_input1_wire = tensor_core_input1[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_input2_wire = tensor_core_input2[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_output_wire = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8];
			end
		end
	endgenerate
endmodule
