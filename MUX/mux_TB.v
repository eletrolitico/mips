module mux_TB();

	parameter SIZE  = 32;

	reg S;
	reg [SIZE - 1: 0] A, B;
	wire [SIZE - 1 : 0] out;

	mux DUT(
		.A(A),
		.B(B),
		.S(S),
		.out(out)
	);
	
	
	initial 
	begin
		A = 24;
		B = 30;
		S = 0;
		
		#10;
		
		S = 1;
		
		#10 $stop;
	end
	

endmodule 