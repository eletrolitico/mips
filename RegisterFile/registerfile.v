module registerfile (
	input [4:0]	rs,rt,rd,
	input	[31:0] in,
	input write,clk,rst,
   output reg [31:0] A,B
	);

	integer k;
	
	reg [31:0] M [0:15];
	
	always@(negedge clk, negedge rst) begin
		if(~rst)
			for(k = 0; k < 16; k = k+1) 
			begin
				M[k] = 32'b0;
			end
		else if (write) 
			M[rd] <= in;
	end
	
	always@(posedge clk) begin
			A <= M[rs];
			B <= M[rt];
	end
	
endmodule
