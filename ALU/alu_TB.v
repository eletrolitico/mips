`timescale 1ns/10ps
module alu_TB();

	parameter width_SZ 	= 32;
	parameter op_sz 		= 4;
	
	reg [width_SZ - 1:0] A, B;
	reg [op_sz - 1:0] ALU_Sel;
	wire [width_SZ - 1:0] ALU_Out;
	
	integer i;
	
	alu DUT(
		.A(A), .B(B),
		.ALU_Sel(ALU_Sel),
		.ALU_Out(ALU_Out)
	);
	
	initial begin
		B = 8'h03; //0011
		A = 8'h04; //0100
		ALU_Sel = 0;
		
		for(i = 0; i < 9; i = i + 1)
		begin
			#10;
			ALU_Sel = ALU_Sel + 1'b1;
		end
	
		#10 $stop;
	end
	
endmodule
