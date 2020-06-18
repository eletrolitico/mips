module mux_TB();

	reg S;
	reg [31:0] A, B;
	wire [31:0] out;

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