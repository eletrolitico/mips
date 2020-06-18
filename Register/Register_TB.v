module Register_TB();

	parameter SZ = 32;

	reg rst, clk;
	reg  [SZ - 1: 0] D;
	wire [SZ - 1: 0] Q;
	
	integer i;
	
	Register DUT(
		.rst(rst),
		.clk(clk),
		.D(D),
		.Q(Q)
	);
	
	always
		#2 clk = ~clk;
	
	initial 
	begin
		rst = 1;
		clk = 0;
		
		#10;
		
		rst = 0;
		
		for(i = 0; i < 15; i = i + 1) begin
			D = i * 2;
			#10;
		end

		#10 $stop;
	end
	
endmodule
	
	