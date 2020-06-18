`timescale 1ns/10ps

module TB();
	
	reg clkIn,rst;
	reg [31:0] DATA_BUS_READ;
	wire [31:0] ADDR,DATA_BUS_WRITE;
	wire cs,we;
	reg [9:0] pc;
	
	reg clk,clkMul;
	reg [31:0] ALU_A,ALU_B;
	
	cpu DUT(.clkIn(clkIn),.rst(rst),.DATA_BUS_READ(DATA_BUS_READ),.DATA_BUS_WRITE(DATA_BUS_WRITE),.cs(cs),.we(we),.ADDR(ADDR));
	
	initial begin
		$init_signal_spy("DUT/addr_pc","pc",1);
		$init_signal_spy("DUT/clk","clk",1);
		$init_signal_spy("DUT/clkMul","clkMul",1);
		$init_signal_spy("DUT/A","ALU_A",1);
		$init_signal_spy("DUT/alu_in","ALU_B",1);
		
		clkIn = 0;
		rst = 0;
		DATA_BUS_READ = 32'hDEDE_AFAF;
		
		#4 rst = 1;
		#800 rst = 0;
		
		#10000 $stop;
	end
	
	always #2 clkIn = ~clkIn;
	
	
	
endmodule 