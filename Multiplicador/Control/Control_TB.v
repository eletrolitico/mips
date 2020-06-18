`timescale 1ns/10ps
module Control_TB ();
	reg M, clk, st, K;
	wire idle, done, load, sh, ad;
	
	Control DUT (
		.M(M),
		.clk(~clk),
		.st(st),
		.K(K),
		.idle(idle),
		.done(done),
		.load(load),
		.sh(sh),
		.ad(ad)
	);
	
	reg [1:0] estadoatual, estadoseguinte;
	
	initial
	begin
		$init_signal_spy("/Control_TB/DUT/estadoatual", "estadoatual", 1);
		$init_signal_spy("/Control_TB/DUT/estadoseguinte", "estadoseguinte", 1);
		st = 0;
		clk = 0;
		M = 0;
		K = 0;
		
		#5 st = 1;
		
		#3 st = 0;
		
		#7 M = 1;
		
		#5 M = 0;
		
		#5 K = 1;
		
		#20 $stop;
	end
	
	always
		begin
		#2 clk = ~clk;
		if (clk)
				$display("Atual: ", estadoatual, " Seguinte: ", estadoseguinte, " Start: ", st, " M: ", M, " K: ", K, " Idle: ", idle, " Done: ", done, " Load: ", load, " Shift: ", sh, " Ad: ", ad);
		end
				
endmodule 