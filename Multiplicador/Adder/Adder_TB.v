`timescale 1ns/10ps
module Adder_TB ();
	reg [3:0] A,B;
	wire [4:0] saida;
	
	Adder DUT (
		.A(A),
		.B(B),
		.saida(saida)
	);
	
	initial 
	begin
		A = 4'd10;
		B = 4'd5;
		#1 $display("A: ", A, " B: ", B, " Saida: ", saida);
		
		#5 A = 4'd8;
		#1 $display("A: ", A, " B: ", B, " Saida: ", saida);
		
		#5 B = 4'd6;
		#1 $display("A: ", A, " B: ", B, " Saida: ", saida);
		
		#5 A = 4'd9;
		B = 4'd10;
		#1 $display("A: ", A, " B: ", B, " Saida: ", saida);		
	end


endmodule 