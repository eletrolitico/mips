`timescale 1ns/10ps
module ADDRDecoding_TB();

	reg [31:0] addr;
	wire cs;
	ADDRDecoding DUT(
		.addr(addr),
		.cs(cs)
	);

	integer i;

	initial begin
		for(i=0;i<16'hffff;i=i+1)begin
			addr = i;
			#10;
		end
	end

endmodule 