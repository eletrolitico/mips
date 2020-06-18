module pc(
	input clk, rst,
	output reg [9:0] count
	);

	always @(posedge clk, posedge rst) 
	begin
		if (rst)
			count = 0;
		else 
			count = count + 1;
	end

endmodule
