module datamemory(data_in, address, clk, we, data_out);
	
	parameter DATA_IN_SZ  = 32;
	parameter DATA_OUT_SZ = 32;
	parameter ADDRESS_SZ  = 10; // 2 ^ 10 = 1024
	
	input  clk, we;
	input  [DATA_IN_SZ   - 1:0 ] data_in;
	input  [ADDRESS_SZ   - 1:0 ] address;
	output reg [DATA_OUT_SZ  - 1:0 ] data_out;
	
	reg [DATA_IN_SZ - 1: 0] memory[(1 << ADDRESS_SZ) - 1 : 0];
	
	always @(posedge clk) begin
		if (we) 
			memory[address] <= data_in;
		else 
			data_out <= memory[address];
	end

endmodule 
