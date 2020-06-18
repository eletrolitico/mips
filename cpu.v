module cpu(
	input clk,rst;
	input [31:0] Data_BUS_READ;
	output [31:0] ADDR,data_BUS_WRITE;
	output cs,we;
);

wire [31:0] inst,ext_out,imm,ct1,ct2,ct3;

wire[31:0] wb_mux_out;


//primeiro estágio
	wire [31:0]addr_pc;

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
	registerfile	regs(.A(A),.B(A),.clk(clk),.rst(rst),.rs(ctrl_out[22:18]),.rt(ctrl_out[17:13]),.in(wb_mux_out),.write(ct3[7]),.rd(ct3[12:8]));
	control			ctrl(inst,ctrl_out);
	extend			ext(inst[15:0],ext_out);
	
	
//ID/EX
	Register ctrl1(.clk(clk),.rst(rst),.D({9'b0,ctrl_out}),.Q(ct1))
	Register IMM(.clk(clk),.rst(rst),.D(ext_out),.Q(imm))
	
//terceiro estágio
	wire [31:0] alu_out,alu_in;
	
	mux mux_alu(.A(B),.B(imm),.S(ct1[0]),.out(alu_in))
	alu alu(.A(A),.B(alu_in),.ALU_Sel(ct1[2:1]),.ALU_Out(alu_out));
	multiplicador mul(.Multiplicador(A),.Multiplicando(B),.clk(clkMul),.St(ct1[3]),.Produto(mul_out))
	mux mux_mult(.A(),.B(),.S(ct1[4]),.out())
endmodule 