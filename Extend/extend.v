module extend(
	input [15:0] in,
	output [31:0] out
	);

	wire [15:0] rep;
	assign rep = {16{in[15]}};
	assign out = {rep,in};
	
endmodule 