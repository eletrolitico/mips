`timescale 1ns/10ps
module alu_TB();
	
	reg [31:0] A, B;
	reg [3:0] ALU_Sel;
	wire [31:0] ALU_Out;
	
	integer i;
	
	alu DUT(
		.A(A), .B(B),
		.ALU_Sel(ALU_Sel),
		.ALU_Out(ALU_Out)
	);
	
	initial begin
		B = 8'h03; //0011
		A = 8'h04; //0100
		
		for(i = 0; i < 4; i = i + 1)
		begin
			ALU_Sel = i;
			#10;
		end
	
		#10 $stop;
	end
	
endmodule
