module datamemory_TB();

	parameter DATA_IN_SZ  = 32;
	parameter DATA_OUT_SZ = 32;
	parameter ADDRESS_SZ  = 10; // 2 ^ 10
	
	reg  clk, we;
	reg  [DATA_IN_SZ   - 1:0 ] data_in;
	reg  [ADDRESS_SZ   - 1:0 ] address;
	wire [DATA_OUT_SZ  - 1:0 ] data_out;
	
	integer i;
	
	datamemory DUT(
		.data_in(data_in),
		.address(address),
		.clk(clk),
		.we(we),
		.data_out(data_out)
	);

	always 
		#2 clk = ~clk;
	
	initial 
	begin
		
		clk = 0;
		we = 0;
		data_in = 0;
		address = 0;
	
		#10;
		
		we = 1;
		
		for(i = 0; i < 5; i = i + 1)
		begin
			#10;
			address = i;
			data_in = i * 2;
		end
		
		#10
		
		we = 0;
		data_in = 0;
		
		for(i = 0; i < 5; i = i + 1)	
		begin
			#10;
			address = i;
		end
		
		
		#10 $stop;
	
	end

endmodule 