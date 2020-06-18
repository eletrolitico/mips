module ACC(
    input Clk, Load, Sh, Ad,
    input [32:0] Entradas,
    output reg [32:0] Saidas
	);
	
   always @ (posedge Clk)
   begin
		if(Load) 
			Saidas <= {17'b0, Entradas[15:0]};
      if(Ad) 
			Saidas <= {Entradas[32:16], Saidas[15:0]};
		if(Sh) 
			Saidas <= {1'b0, Saidas[32:1]};
    end

endmodule 