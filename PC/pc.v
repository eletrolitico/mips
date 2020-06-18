module pc(
	input clk, rst,
	output reg [9:0] count
	);

	always @(posedge clk, posedge rst) 
	begin
		if (rst)
			count = 9'b0;
		else 
			count = count + 9'b1;
	end

endmodule
