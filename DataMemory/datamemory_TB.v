`timescale 1ns/1ps
module datamemory_TB();
	
	reg  clk, we;
	reg  [31:0 ] data_in;
	reg  [9:0 ] address;
	wire [31:0 ] data_out;
	
	integer i;
	
	datamemory DUT(
		.data_in(data_in),
		.address(address),
		.clk(clk),
		.we(we),
		.data_out(data_out)
	);

	always 
		#2 clk = ~clk;

	initial 
	begin
		clk = 0;
		we = 0;
		data_in = 0;
		address = 0;

		#10
		we = 1;
		
		for(i = 0; i < 5; i = i + 1)
		begin
			#10;
			address = i;
			data_in = i * 2;
		end
		
		#10
		we = 0;
		data_in = 0;
		
		for(i = 0; i < 5; i = i + 1)	
		begin
			#10;
			address = i;
		end
		
		#10 $stop;
	end

endmodule 