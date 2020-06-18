module alu(	
	input [31:0] A, B,
	input [3:0] ALU_Sel,
	output reg [31:0] ALU_Out
	);
	
	always @(*) 
	begin
		case(ALU_Sel)
			4'd0: begin ALU_Out <= A + B; end											//add
			4'd1: begin ALU_Out <= A + B; end											//add_u
			4'd2: begin ALU_Out <= A - B; end											//sub
			4'd3: begin ALU_Out <= A - B; end											//sub_u
			4'd4: begin ALU_Out <= A & B; end											//and
			4'd5: begin ALU_Out <= A | B; end											//or
			4'd6: begin ALU_Out <= A ^ B; end											//xor
			4'd7: begin ALU_Out <= (A < B ? 1 : 0); end								//slt
			4'd8: begin ALU_Out <= ($signed(A) < $signed(B) ? 1 : 0); end		//slt_u
			default: ALU_Out <= A & B;
		endcase
	end
	
endmodule 
	
		