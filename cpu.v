module cpu(
	input clkIn,rst,
	input [31:0] DATA_BUS_READ,
	output [31:0] ADDR,DATA_BUS_WRITE,
	output cs,we
);

	
	/* 
	
		a) Qual a latência do sistema?
			5 pulsos de clock
		
		b) Qual o throughput do sistema?
			1 instrução por clock quando a pipeline está cheia
		
		c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)
			A FPGA utilizada foi a EP4CGX150DF31I7AD
			Para o Multiplicador foi 250MHz
			Para o Sistema foi 120.02MHz
		
		d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
			A FPGA utilizada foi a EP4CGX150DF31I7AD
			Já que a operação de multiplicação leva 34 pulsos de clock
			a frequência do sistema deverá ser 34 vezes menor, ou seja, 7.35MHz
			
		e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência ininterrupta)?
		Por quê? O que pode ser feito para que a expressão seja calculada corretamente?
			Não, pois ocorre pipeline hazard, ou seja, nas operações aritméticas o valor não estará presente nas
			entradas da ALU ou do multiplicador. Para resolver esse problema basta inserir 3 bolhas após as instruções de load na pipeline
		
		f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com	metaestabilidade? Por que?
			Não, pois os clocks são multiplos inteiros e a PLL sincroniza a fase.
			
		g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?
			Não, pois esse multiplicador possui pipeline enrolada, não há paralelismo e a multiplicação demora pra ser feita
			
		h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de
		operação maior). Para cada modificação sugerida, qual a nova latência e throughput do sistema?
			Substituir o multiplicador por um mais eficiente, por exemplo, o já implementado na FPGA. Desse modo, o sistema poderia
			operar em uma frequência bem maior. A latência e o throughput seriam mantidos.
			
	
	*/
	
	
	


//Clocks
wire clk,clkMul;

PLL1 pll1(.areset(rst),.inclk0(clkIn),.c0(clkMul),.c1(clk));


wire [31:0] inst,ext_out,imm;
wire [22:0] ct1,ct2,ct3;
wire [31:0] wb_mux_out;

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
	Register #(23)ctrl1(.clk(clk),.rst(rst),.D({9'b0,ctrl_out}),.Q(ct1));
	Register IMM(.clk(clk),.rst(rst),.D(ext_out),.Q(imm));
	
//terceiro estágio
	wire [31:0] alu_out,alu_in,mux_mul_out,mul_out;
	
	mux mux_alu(.A(B),.B(imm),.S(ct1[0]),.out(alu_in));
	alu alu(.A(A),.B(alu_in),.ALU_Sel(ct1[2:1]),.ALU_Out(alu_out));
	multiplicador mul1(.Multiplicador(A[15:0]),.Multiplicando(B[15:0]),.Clk(clkMul),.St(ct1[3]),.Produto(mul_out));
	mux mux_mult(.A(mul_out),.B(alu_out),.S(ct1[4]),.out(mux_mul_out));
	
	
//EX/MEM
	Register D1(.clk(clk),.rst(rst),.D(mux_mul_out),.Q(ADDR));
	Register #(23)ctrl2(.clk(clk),.rst(rst),.D(ct1),.Q(ct2));
	Register B1(.clk(clk),.rst(rst),.D(B),.Q(DATA_BUS_WRITE));
	
	
//Quarto estágio

	wire [31:0] mem_out,M;
	assign we = ct2[5];
	ADDRDecoding decoder(.addr(ADDR),.cs(cs));
	datamemory m2(.clk(clk),.address(ADDR[9:0]),.data_in(DATA_BUS_WRITE),.data_out(mem_out),.we(we),.cs(cs));
	
	Register #(1)CS(.clk(clk),.rst(rst),.D(cs),.Q(cs_a));
	
	mux mux_mem(.A(DATA_BUS_READ),.B(mem_out),.S(cs_a),.out(M));
	
//MEM/WB
	wire [31:0] d2;
	Register #(23)ctrl3(.clk(clk),.rst(rst),.D(ct2),.Q(ct3));
	Register D2(.clk(clk),.rst(rst),.D(ADDR),.Q(d2));

//Quinto estágio

	mux mux_wb(.A(d2),.B(M),.S(ct3[6]),.out(wb_mux_out));
	
	
endmodule 