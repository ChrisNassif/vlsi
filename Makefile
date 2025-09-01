test_alu:
	iverilog -g2012 -o alu_test_bench.out alu_test_bench.sv alu.sv
	vvp alu_test_bench.out
	gtkwave alu_test_bench.vcd

alu_transistor_count:
	yosys -p "read_verilog -sv alu.sv; synth; stat -tech cmos"



test_cpu:
	iverilog -g2012 -o cpu_test_bench.out cpu_test_bench.sv cpu.sv
	vvp cpu_test_bench.out
	gtkwave cpu_test_bench.vcd

cpu_transistor_count:
	yosys -p "read_verilog -sv cpu.sv; synth; stat -tech cmos"