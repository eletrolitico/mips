`timescale 1ns/10ps

module TB();
	
	reg clkIn,rst;
	reg [31:0] DATA_BUS_READ;
	wire [31:0] ADDR,DATA_BUS_WRITE;
	wire cs,we;
	reg [9:0] pc;
	
	reg clk,clkMul;
	reg [31:0] ALU_A,ALU_B;
	reg [31:0] r [0:15];
	
	cpu DUT(.clkIn(clkIn),.rst(rst),.DATA_BUS_READ(DATA_BUS_READ),.DATA_BUS_WRITE(DATA_BUS_WRITE),.cs(cs),.we(we),.ADDR(ADDR));
	
	
	integer cont;
	initial begin
		$init_signal_spy("DUT/addr_pc","pc",1);
		$init_signal_spy("DUT/clk","clk",1);
		$init_signal_spy("DUT/clkMul","clkMul",1);
		$init_signal_spy("DUT/A","ALU_A",1);
		$init_signal_spy("DUT/alu_in","ALU_B",1);
		$init_signal_spy("DUT/regs/M","r",1);
		
		cont = 0;
		
		clkIn = 0;
		rst = 0;
		DATA_BUS_READ = 32'hDEDE_AFAF;
		
		#4 rst = 1;
		#800 rst = 0;
		
		#10000 $stop;
	end
	
	always #2 clkIn = ~clkIn;
	
	
	always @ (posedge clk) begin
		$display(cont,": ","r0:",r[0]," ","r1:",r[1]," ","r2:",r[2]," ","r3:",r[3]," ","r4:",r[4]," ","r5:",r[5]," ","r6:",r[6]," ","r7:",r[7]," ","r8:",r[8]," ","r9:",r[9]," ","r10:",r[10]," ","r11:",r[11]," ","r12:",r[12]," ","r13:",r[13]," ","r14:",r[14]," ","r15:",r[15]);
		cont = cont+1;
	end
	
	
	
endmodule 