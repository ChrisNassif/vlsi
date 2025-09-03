module tensor_core (
	tensor_core_input1,
	tensor_core_input2,
	tensor_core_output
);
	reg _sv2v_0;
	input wire [127:0] tensor_core_input1;
	input wire [127:0] tensor_core_input2;
	output reg [127:0] tensor_core_output;
	always @(*) begin
		if (_sv2v_0)
			;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < 4; i = i + 1)
				begin : sv2v_autoblock_2
					reg signed [31:0] j;
					for (j = 0; j < 4; j = j + 1)
						begin
							tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] = 0;
							begin : sv2v_autoblock_3
								reg signed [31:0] k;
								for (k = 0; k < 4; k = k + 1)
									tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] + (tensor_core_input1[(((3 - i) * 4) + (3 - k)) * 8+:8] * tensor_core_input2[(((3 - k) * 4) + (3 - j)) * 8+:8]);
							end
						end
				end
		end
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
	initial _sv2v_0 = 0;
endmodule
module tensor_core_mma (
	tensor_core_input1,
	tensor_core_input2,
	tensor_core_output
);
	reg _sv2v_0;
	input wire [127:0] tensor_core_input1;
	input wire [127:0] tensor_core_input2;
	output reg [127:0] tensor_core_output;
	always @(*) begin
		if (_sv2v_0)
			;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < 4; i = i + 1)
				begin : sv2v_autoblock_2
					reg signed [31:0] j;
					for (j = 0; j < 4; j = j + 1)
						begin
							tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] = tensor_core_input1[(((3 - i) * 4) + (3 - j)) * 8+:8];
							begin : sv2v_autoblock_3
								reg signed [31:0] k;
								for (k = 0; k < 4; k = k + 1)
									tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8] + (tensor_core_input1[(((3 - i) * 4) + (3 - k)) * 8+:8] * tensor_core_input2[(((3 - k) * 4) + (3 - j)) * 8+:8]);
							end
						end
				end
		end
	end
	genvar _gv_i_2;
	genvar _gv_j_2;
	generate
		for (_gv_i_2 = 0; _gv_i_2 < 4; _gv_i_2 = _gv_i_2 + 1) begin : expose_tensor_core
			localparam i = _gv_i_2;
			for (_gv_j_2 = 0; _gv_j_2 < 4; _gv_j_2 = _gv_j_2 + 1) begin : expose_tensor_core2
				localparam j = _gv_j_2;
				wire [7:0] tensor_core_input1_wire = tensor_core_input1[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_input2_wire = tensor_core_input2[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_output_wire = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8];
			end
		end
	endgenerate
	initial _sv2v_0 = 0;
endmodule
module small_tensor_core_mma (
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
	always @(posedge clock_in) begin
		if (tensor_core_register_file_write_enable == 1) begin
			counter1 = 0;
			is_done_with_calculation = 0;
		end
		if (is_done_with_calculation == 0) begin
			$display("%d   %d", counter1 / 4, counter1 % 4);
			tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] = 0;
			begin : sv2v_autoblock_1
				reg signed [31:0] k;
				for (k = 0; k < 4; k = k + 1)
					tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] = tensor_core_output[(((3 - (counter1 / 4)) * 4) + (3 - (counter1 % 4))) * 8+:8] + (tensor_core_input1[(((3 - (counter1 / 4)) * 4) + (3 - k)) * 8+:8] * tensor_core_input2[(((3 - k) * 4) + (3 - (counter1 % 4))) * 8+:8]);
			end
			counter1 = counter1 + 1;
		end
		if (counter1 == 5'b10000)
			is_done_with_calculation = 1;
	end
	genvar _gv_i_3;
	genvar _gv_j_3;
	generate
		for (_gv_i_3 = 0; _gv_i_3 < 4; _gv_i_3 = _gv_i_3 + 1) begin : expose_tensor_core
			localparam i = _gv_i_3;
			for (_gv_j_3 = 0; _gv_j_3 < 4; _gv_j_3 = _gv_j_3 + 1) begin : expose_tensor_core2
				localparam j = _gv_j_3;
				wire [7:0] tensor_core_input1_wire = tensor_core_input1[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_input2_wire = tensor_core_input2[(((3 - i) * 4) + (3 - j)) * 8+:8];
				wire [7:0] tensor_core_output_wire = tensor_core_output[(((3 - i) * 4) + (3 - j)) * 8+:8];
			end
		end
	endgenerate
endmodule
