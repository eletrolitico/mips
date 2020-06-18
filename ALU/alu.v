module alu(	
	input [31:0] A, B,
	input [1:0] ALU_Sel,
	output reg [31:0] ALU_Out
	);
	
	always @(*) 
	begin
		case(ALU_Sel)
			4'd0: begin ALU_Out <= A + B; end											//add
			4'd1: begin ALU_Out <= A - B; end											//sub
			4'd2: begin ALU_Out <= A & B; end											//and
			4'd3: begin ALU_Out <= A | B; end											//or
			default: ALU_Out <= A & B;
		endcase
	end
	
endmodule 
	
		