`timescale 1ns/10ps
module ACC_TB ();
	reg clk, load, sh, ad;
	reg [8:0] entrada;
	wire [8:0] saida;

	ACC DUT (
		.clk(clk),
		.load(load),
		.sh(sh),
		.ad(ad),
		.entrada(entrada),
		.saida(saida)
	);
	
	initial
	begin
		clk = 0;
		load = 0;
		ad = 0;
		sh = 0;
		entrada = 8'b1010_1100;
		
		#10 load = 1;
		
		#3 load = 0;
		
		#10 sh = 1;
		
		#20 sh = 0;
		
		#3 ad = 1;
		
		#3 ad = 0;
		sh = 1;
		
		#10 sh = 0;
		
		#10 $stop;
	end
	
	always
	begin
		#2 clk = ~clk;
		if (clk)
			$display("Load: ", load, " Shift: ", sh, " Ad: ", ad, " Entrada: %b", entrada, " Saida: %b", saida);
	end

endmodule 