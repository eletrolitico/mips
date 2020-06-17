module Register(rst, clk, D, Q);

	parameter SZ = 32;

	input rst, clk;
	input  [SZ - 1: 0] D;
	output reg [SZ - 1: 0] Q;
	
	
	always @(posedge clk or posedge rst) begin
		if (rst)
			Q <= 0;
		else 
			Q <= D;
	end
	
endmodule 
	
	
	