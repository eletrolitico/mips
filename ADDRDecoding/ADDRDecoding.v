module ADDRDecoding(
	input [31:0] addr,
	output cs
	);
	
	//faixa da mem interna 0xC000 a 0xC3FF
	//0x0000_C000 a 0x0000_C3ff
	assign c1 = addr[31:12] == 20'hC;
	assign c2 = ~addr[11]&~addr[10];
	assign cs = c1&c2;
	
endmodule 