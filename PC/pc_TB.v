`timescale 1ns/10ps
module pc_TB();

	reg clk, rst;
	wire [9:0] count;

	pc DUT(
		.rst(rst),
		.clk(clk),
		.count(count)
	);
	
	always 
		#2 clk = ~clk;
		
	initial 
	begin
		rst = 1;
		clk = 0;
		
		#10
		
		rst = 0;
		
		#100 $stop;
	end

endmodule 