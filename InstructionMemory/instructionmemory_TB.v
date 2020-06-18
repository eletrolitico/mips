`timescale 1ns/10ps
module instructionmemory_TB();
	reg clk;
	reg [10:0] addr;
	wire [31:0] data_out;
	
	instructionmemory DUT(
		.clk(clk),
		.addr(addr),
		.data_out(data_out)
	);
	
	integer i;
	
	initial begin
		clk = 0;
	end
	
	initial begin
		addr = 0;
		for (i = 0; i < 1024; i = i + 1) begin 
			#10 addr = addr + 1;
		end
	end
	
	always #5 clk = ~clk;
	
	initial begin
		#10000 $stop;
	end
endmodule

