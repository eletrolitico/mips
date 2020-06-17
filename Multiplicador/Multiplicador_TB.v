`timescale 1ns/10ps
module Multiplicador_TB ();
	reg St, Clk;
	reg [15:0] Multiplicando, Multiplicador;
	wire Idle, Done;
	wire [31:0] Produto;
	
	Multiplicador DUT (
		.St(St),
		.Clk(Clk),
		.Multiplicando(Multiplicando),
		.Multiplicador(Multiplicador),
		.Idle(Idle),
		.Done(Done),
		.Produto(Produto)
	);

	initial
	begin	
		Clk = 0;
		
		#5 St = 1;
		Multiplicando = 16'd12;
		Multiplicador = 16'd0;
		#5 St = 0;
		
		#150 St = 1;
		Multiplicando = 16'd12;
		Multiplicador = 16'd10;
		#5 St = 0;
		
		#150 St = 1;
		Multiplicando = 16'd200;
		Multiplicador = 16'd3;
		#5 St = 0;
		
		
		#150 $stop;		
	end

	always 
	begin
		#2 Clk = ~Clk;
		if (Clk)
			$display("Multiplicando: ", Multiplicando, " Multiplicador: ", Multiplicador, " Produto: ", Produto, " Idle: ", Idle, " Done: ", Done);
	end
endmodule 