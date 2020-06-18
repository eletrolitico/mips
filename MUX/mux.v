module mux(A, B, S, out);

	parameter SIZE  = 32;

	input S;
	input [SIZE - 1: 0] A, B;
	output reg [SIZE - 1 : 0] out;

	always @(A or B or S) 
	begin
		if (S) out = B;
		else out = A;
	end

endmodule 