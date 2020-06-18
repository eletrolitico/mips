`timescale 1ns/10ps
module extend_TB();

	reg [15:0] in;
	wire [31:0] out;

	extend DUT(.in(in),.out(out));

	initial 
	begin
		in = 16'h0;
		#10 in = 16'hDE12;
		#10 in = 16'd1239;
		#10 $stop;
	end

endmodule 