module small_tensor_core (
	clock_in,
	tensor_core_register_file_write_enable,
	tensor_core_input1,
	tensor_core_input2,
	tensor_core_output,
	is_done_with_calculation
);
	reg _sv2v_0;
	input wire clock_in;
	input wire tensor_core_register_file_write_enable;
	input wire signed [63:0] tensor_core_input1;
	input wire signed [63:0] tensor_core_input2;
	output reg signed [63:0] tensor_core_output;
	output reg is_done_with_calculation;
	reg [4:0] counter;
	reg signed [3:0] products [0:3];
	always @(*) begin
		if (_sv2v_0)
			;
		begin : sv2v_autoblock_1
			reg signed [31:0] k;
			for (k = 0; k < 4; k = k + 1)
				products[k] = tensor_core_input1[(((3 - (counter / 4)) * 4) + (3 - k)) * 4+:4] * tensor_core_input2[(((3 - k) * 4) + (3 - (counter % 4))) * 4+:4];
		end
		tensor_core_output[(((3 - (counter / 4)) * 4) + (3 - (counter % 4))) * 4+:4] = ((products[0] + products[1]) + products[2]) + products[3];
	end
	always @(negedge clock_in) begin
		if (tensor_core_register_file_write_enable == 1) begin
			counter = 0;
			is_done_with_calculation = 0;
		end
		if ((is_done_with_calculation == 0) && (tensor_core_register_file_write_enable == 0))
			counter = counter + 1;
		if (counter == 5'b10000)
			is_done_with_calculation = 1;
	end
	always @(posedge clock_in) begin
		if (tensor_core_register_file_write_enable == 1) begin
			counter = 0;
			is_done_with_calculation = 0;
		end
		if ((is_done_with_calculation == 0) && (tensor_core_register_file_write_enable == 0))
			counter = counter + 1;
		if (counter == 5'b10000)
			is_done_with_calculation = 1;
	end
	genvar _gv_i_1;
	genvar _gv_j_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : expose_tensor_core
			localparam i = _gv_i_1;
			for (_gv_j_1 = 0; _gv_j_1 < 4; _gv_j_1 = _gv_j_1 + 1) begin : expose_tensor_core2
				localparam j = _gv_j_1;
				wire [7:0] tensor_core_input1_wire = tensor_core_input1[(((3 - i) * 4) + (3 - j)) * 4+:4];
				wire [7:0] tensor_core_input2_wire = tensor_core_input2[(((3 - i) * 4) + (3 - j)) * 4+:4];
				wire [7:0] tensor_core_output_wire = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 4+:4];
			end
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
