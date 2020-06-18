`timescale 1ns/10ps
module control_TB();

	reg [31:0] instruction;
	wire [22:0] ctrl;

	control DUT(
		.instruction(instruction),
		.ctrl(ctrl)
	);

	initial begin
		instruction = 32'b0;
		#15 instruction = 32'b001101_00000_00001_0011_0000_0000_0000;
		#15 instruction = 32'b001110_00000_00001_0000_0000_0000_0000;
		#15 instruction = 32'b001100_00000_00001_00010_01010_100000;
		#15 instruction = 32'b001100_00000_00001_00010_01010_100010;
		#15 instruction = 32'b001100_00000_00001_00010_01010_110010;
		#15 instruction = 32'b001100_00000_00001_00010_01010_100100;
		#15 instruction = 32'b001100_00000_00001_00010_01010_100101;
		#10 $stop;
	end
	
endmodule 