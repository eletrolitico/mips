module extend(
	input [15:0] i,
	output [31:0] out
	);

	assign out = {16'b0,in};
	
endmodule 