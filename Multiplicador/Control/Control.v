module Control (
	input M, Clk, St, K,
	output reg Idle, Done, Load, Sh, Ad
	);

	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	(* syn_encoding = "safe" *) reg [1:0] estadoatual, estadoseguinte;
	
	initial
		estadoatual <= 0;
	
	always @ (estadoatual, St, M, K)
		case (estadoatual)
			S0: if (St) estadoseguinte <= S1; else estadoseguinte <= S0;
			S1: estadoseguinte <= S2;
			S2: if (K) estadoseguinte <= S3; else estadoseguinte <= S1;
			S3: estadoseguinte <= S0;
			default: estadoseguinte <= S0;
		endcase
		
	always @ (posedge Clk)
		estadoatual <= estadoseguinte;
		
	always @ (estadoatual, M, St, K)
	begin
		Idle <= 0;
		Done <= 0;
		Load <= 0;
		Sh <= 0;
		Ad <= 0;
		case (estadoatual)
			S0: 
			begin
				Idle <= 1;
				if (St)
					Load <= 1;
			end
			S1: Ad <= M;
			S2: Sh <= 1;
			S3: Done <= 1;
		endcase
	end

endmodule 