`default_nettype wire
module alu_test_bench;
	reg clock;
	reg reset;
	reg signed [3:0] alu_opcode;
	reg signed [3:0] alu_input1;
	reg signed [3:0] alu_input2;
	wire signed [3:0] alu_output;
	reg signed [3:0] alu_expected_output;
	alu main_alu(
		.reset_in(reset),
		.enable_in(1'b1),
		.opcode_in(alu_opcode),
		.alu_input1(alu_input1),
		.alu_input2(alu_input2),
		.alu_output(alu_output)
	);
	always #(5) clock = !clock;
	initial begin
		$dumpfile("build/alu_test_bench.vcd");
		$dumpvars(0, alu_test_bench);
		clock = 0;
		reset = 0;
		alu_input1 = 0;
		alu_input2 = 0;
		#(10) reset = 1;
		#(10) reset = 0;
		$display("  alu_input1    alu_input2   opcode       alu_output");
		begin : sv2v_autoblock_1
			integer i;
			for (i = 0; i < 256; i = i + 1)
				begin : sv2v_autoblock_2
					integer j;
					for (j = 0; j < 256; j = j + 1)
						begin
							alu_input1 = i;
							alu_input2 = j;
							alu_opcode = 8'b00000000;
							#(30)
								;
							alu_expected_output = alu_input1 + alu_input2;
							if (alu_output != alu_expected_output)
								$display("Error [%0t] src/alu_test_bench.sv:53:17 - alu_test_bench.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>\n msg: ", $time, "Mismatch: Expected %h, Got %h at time %0t", alu_expected_output, alu_output, $time);
						end
				end
		end
		begin : sv2v_autoblock_3
			integer i;
			for (i = 0; i < 256; i = i + 1)
				begin : sv2v_autoblock_4
					integer j;
					for (j = 0; j < 256; j = j + 1)
						begin
							alu_input1 = i;
							alu_input2 = j;
							alu_opcode = 8'b00000001;
							#(30)
								;
							alu_expected_output = alu_input1 - alu_input2;
							if (alu_output != alu_expected_output)
								$display("Error [%0t] src/alu_test_bench.sv:71:17 - alu_test_bench.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>\n msg: ", $time, "Mismatch: Expected %h, Got %h at time %0t", alu_expected_output, alu_output, $time);
						end
				end
		end
		begin : sv2v_autoblock_5
			integer i;
			for (i = 0; i < 256; i = i + 1)
				begin : sv2v_autoblock_6
					integer j;
					for (j = 0; j < 256; j = j + 1)
						begin
							alu_input1 = i;
							alu_input2 = j;
							alu_opcode = 8'b00000010;
							#(30)
								;
							alu_expected_output = alu_input1 * alu_input2;
							if (alu_output != alu_expected_output)
								$display("Error [%0t] src/alu_test_bench.sv:90:17 - alu_test_bench.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>\n msg: ", $time, "Mismatch: Expected %h, Got %h at time %0t", alu_expected_output, alu_output, $time);
						end
				end
		end
		begin : sv2v_autoblock_7
			integer i;
			for (i = 0; i < 256; i = i + 1)
				begin : sv2v_autoblock_8
					integer j;
					for (j = 0; j < 256; j = j + 1)
						begin
							alu_input1 = i;
							alu_input2 = j;
							alu_opcode = 8'b00000011;
							#(30)
								;
							alu_expected_output = alu_input1 == alu_input2;
							if (alu_output != alu_expected_output)
								$display("Error [%0t] src/alu_test_bench.sv:109:17 - alu_test_bench.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>\n msg: ", $time, "Mismatch: Expected %h, Got %h at time %0t", alu_expected_output, alu_output, $time);
						end
				end
		end
		begin : sv2v_autoblock_9
			integer i;
			for (i = 0; i < 256; i = i + 1)
				begin : sv2v_autoblock_10
					integer j;
					for (j = 0; j < 256; j = j + 1)
						begin
							alu_input1 = i;
							alu_input2 = j;
							alu_opcode = 8'b00000100;
							#(30)
								;
							alu_expected_output = alu_input1 > alu_input2;
							if (alu_output != alu_expected_output)
								$display("Error [%0t] src/alu_test_bench.sv:128:21 - alu_test_bench.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>.<unnamed_block>\n msg: ", $time, "Mismatch: Expected %h, Got %h at time %0t", alu_expected_output, alu_output, $time);
						end
				end
		end
		$display("Finishing Sim");
		$finish;
	end
endmodule
