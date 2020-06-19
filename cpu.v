module cpu(
	input clkIn,rst,
	input [31:0] DATA_BUS_READ,
	output [31:0] ADDR,DATA_BUS_WRITE,
	output cs,we
);


//Clocks
wire clk,clkMul;

PLL1 pll1(.areset(rst),.inclk0(clkIn),.c0(clkMul),.c1(clk));


wire [31:0] inst,ext_out,imm,ct1,ct2,ct3;
wire[31:0] wb_mux_out;

//primeiro estágio
	wire [9:0]addr_pc;

	instructionmemory m1(.clk(clk),.addr(addr_pc),.data_out(inst));
	pc pc(.rst(rst),.clk(clk),.count(addr_pc));

	
//segundo estágio

	wire [22:0]ctrl_out;
	/* mux_alu_in [0]
		alu_op [2:1]
		start[3]
		mux_alu_out[4]
		mem_wr[5]
		mux_writeback[6]
		rf_wr[7]
		rd[12:8]
		rt[17:13]
		rs[22:18]        */
	wire [31:0] A,B;
	registerfile	regs(.A(A),.B(B),.clk(clk),.rst(~rst),.rs(ctrl_out[22:18]),.rt(ctrl_out[17:13]),.in(wb_mux_out),.write(ct3[7]),.rd(ct3[12:8]));
	control			ctrl(inst,ctrl_out);
	extend			ext(inst[15:0],ext_out);
	
	
//ID/EX
	Register ctrl1(.clk(clk),.rst(rst),.D({9'b0,ctrl_out}),.Q(ct1));
	Register IMM(.clk(clk),.rst(rst),.D(ext_out),.Q(imm));
	
//terceiro estágio
	wire [31:0] alu_out,alu_in,mux_mul_out,mul_out;
	
	mux mux_alu(.A(B),.B(imm),.S(ct1[0]),.out(alu_in));
	alu alu(.A(A),.B(alu_in),.ALU_Sel(ct1[2:1]),.ALU_Out(alu_out));
	multiplicador mul1(.Multiplicador(A[15:0]),.Multiplicando(B[15:0]),.Clk(clkMul),.St(ct1[3]),.Produto(mul_out));
	mux mux_mult(.A(mul_out),.B(alu_out),.S(ct1[4]),.out(mux_mul_out));
	
	
//EX/MEM
	Register D1(.clk(clk),.rst(rst),.D(mux_mul_out),.Q(ADDR));
	Register ctrl2(.clk(clk),.rst(rst),.D(ct1),.Q(ct2));
	Register B1(.clk(clk),.rst(rst),.D(B),.Q(DATA_BUS_WRITE));
	
	
//Quarto estágio

	wire [31:0] mem_out,M;
	assign we = ct2[5];
	ADDRDecoding decoder(.addr(ADDR),.cs(cs));
	datamemory m2(.clk(clk),.address(ADDR[9:0]),.data_in(DATA_BUS_WRITE),.data_out(mem_out),.we(we),.cs(cs));
	
	Register CS(.clk(clk),.rst(rst),.D(cs),.Q(cs_a));
	
	mux mux_mem(.A(DATA_BUS_READ),.B(mem_out),.S(cs_a),.out(M));
	
//MEM/WB
	wire [31:0] d2;
	Register ctrl3(.clk(clk),.rst(rst),.D(ct2),.Q(ct3));
	Register D2(.clk(clk),.rst(rst),.D(ADDR),.Q(d2));

//Quinto estágio

	mux mux_wb(.A(d2),.B(M),.S(ct3[6]),.out(wb_mux_out));
	
	
	
	
	/* 
		FMul = 250MHz
		FSis = FMul/34 = 
	
	*/
	
	
	
	
	
	
	
	
endmodule 