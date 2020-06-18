module Counter(
	input Load, Clk,
	output K
	);
	 
	reg [5:0] cont;
	
	assign K = (cont == 5'd30);
	
	always @ (posedge Clk)
	begin
		if (Load)
			cont <= 0;
		else
			if (cont != 5'd30)
				cont <= cont + 5'd1;
	end
	 
endmodule
