module datamemory(
	input  clk, we, cs,
	input  [31:0] data_in,
	input  [9:0] address,
	output reg [31:0] data_out
	);
	
	reg [31:0] memory [0:1023];
	
	always @(posedge clk) begin
		if (we && cs) 
			memory[address] <= data_in;
		data_out <= memory[address];
	end
	
	initial begin
		memory[0]=32'd2001;
		memory[1]=32'd4001;
		memory[2]=32'd5001;
		memory[3]=32'd3001;
	end

endmodule 
