module Register(
	input rst, clk,
	input [31:0] D,
	output reg  [31:0] Q
	);
	
	always @(posedge clk or posedge rst) 
	begin
		if (rst)
			Q <= 0;
		else 
			Q <= D;
	end
	
endmodule 
	
	
	