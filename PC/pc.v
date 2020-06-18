module pc(rst, clk, count);

	parameter SZ = 10;

	input clk, rst;
	output reg [SZ - 1 : 0] count;

	always @(posedge clk, posedge rst) 
	begin
		if (rst)
			count = 0;
		else 
			count = count + 1;
	end

endmodule
