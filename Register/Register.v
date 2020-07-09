module Register
#(parameter DATA_WIDTH=32)
(
	input rst, clk,
	input [DATA_WIDTH-1:0] D,
	output reg  [DATA_WIDTH-1:0] Q
);
	
	always @(posedge clk or posedge rst) 
	begin
		if (rst)
			Q <= 0;
		else 
			Q <= D;
	end
	
endmodule 
	
	
	