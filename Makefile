test_alu:
	iverilog -g2012 -o alu_test_bench.out alu_test_bench.sv alu.sv
	vvp alu_test_bench.out
	gtkwave alu_test_bench.vcd

alu_transistor_count:
	yosys -p "read_verilog -sv alu.sv; synth; stat -tech cmos"

