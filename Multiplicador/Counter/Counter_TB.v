`timescale 1ns/10ps
module Counter_TB ();
	reg load, clk;
	wire K;
	
	reg [2:0] cont;
	
	Counter DUT (
		.load(load),
		.clk(clk),
		.K(K)
	);
	
	initial
	begin
		$init_signal_spy("/Counter_TB/DUT/cont", "cont", 1);
		clk = 0;
		load = 0;
		
		#5 load = 1;
		
		#3 load = 0;
		
		#50 $stop;
	end
	
	always 
	begin
		#2 clk = ~clk;
		if (clk)
			$display("Contagem: ", cont, " Load: ", load," K: ", K);
	end


endmodule 