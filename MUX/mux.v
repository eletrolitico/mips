module mux(
	input S,
	input [31:0] A, B,
	output reg [31:0] out
	);

	always @(A or B or S) 
	begin
		if (S) out = B;
		else out = A;
	end

endmodule 