module multiplicador (
	input [15:0] Multiplicador, Multiplicando,
	input St, Clk,
	output [31:0] Produto,
	output Idle, Done);

	wire K;
	wire Load, Sh, Ad;
	wire [16:0] Soma;
	wire [32:0] saidaacc;

	ACC acc0 (.Clk(Clk), .Load(Load), .Sh(Sh), .Ad(Ad), .Saidas(saidaacc), .Entradas({Soma, Multiplicador}));
	assign Produto = saidaacc[31:0];
	
	Adder adder0 (.OperandoA(Multiplicando), .OperandoB(Produto[31:16]), .Soma(Soma));
	
	Counter counter0 (.Load(Load), .Clk(Clk), .K(K));
	
	Control control0 (.M(saidaacc[0]), .St(St), .Clk(Clk), .K(K), .Ad(Ad), .Sh(Sh), .Load(Load), .Idle(Idle), .Done(Done));
	
endmodule 