`timescale 1ns/10ps
module registerfile_TB();

	reg [4:0] rs, rt, rd; 
	reg write, clk,rst;
	reg [31:0] in; 
	wire [31:0] A,B; 
	
	registerfile DUT(
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.in(in),
		.clk(clk),
		.A(A),
		.B(B),
		.write(write),
		.rst(rst)
	);
	
	
	initial 
	begin
		clk = 0;
		rst=0;
		write = 0;
		rs = 10;
		rt = 10;
		#5 rst=1;
		
		#20;
		in = 32'd11;
		rd = 5'd0;
		#2 write = 1;
		#8 write = 0;
		
		#20;
		in = 32'd22;
		rd = 5'd2;
		#2 write = 1;
		#8 write = 0;
		
		#20;
		in = 32'd33;
		rd = 5'd3;
		#2 write = 1;
		#8 write = 0;
		
		#20;
		in = 32'd44;
		rd = 5'd5;
		#2 write = 1;
		#8 write = 0;
		
		#20 rd=0;
		#5;
		rs = 5'd0;
		rt = 5'd2;
		#30;
		rs = 5'd3;
		rt = 5'd5;
		#30 $stop;
	end
	
	always #15 clk = ~clk;
	
endmodule
