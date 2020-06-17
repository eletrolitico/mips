module registerfile(rs,rt,rd,in,write,clk,A,B);

	input [4:0]	rs,rt,rd;
	input	[31:0] in;
	input write,clk;
   output reg [31:0] A,B;

	integer k;
	
	reg [31:0] M [0:15];

	initial begin
		for(k = 0; k < 16; k = k+1) M[k] = 0;
	end
	
	always@(negedge clk) begin
		if (write) 
			M[rd] <= in;
		
	end
	
	always@(posedge clk) begin
			A <= M[rs];
			B <= M[rt];
	end
	
	
	endmodule
