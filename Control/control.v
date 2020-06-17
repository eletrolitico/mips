module control(
	input [31:0] instruction,
	output [22:0] ctrl
);


reg mem_wr;
reg rf_wr;
reg [1:0] alu_op;
reg [4:0] rd;
reg [4:0] rs;
reg [4:0] rt;
reg [5:0] op;
reg [5:0] opcode;
reg mux_alu_in;
reg mux_alu_out;
reg start;
reg mux_writeback;

assign ctrl = {rs, rt, rd, rf_wr, mux_writeback, mem_wr, mux_alu_out, start, alu_op, mux_alu_in};
/*					5	 5	  5	1		 1					 1			1				 1		  2	 	 1            = 23			*/

/* INSTRUÇÕES */
/*
		OPCODE	RS			RT			OFFSET
	LW 001101	00000		00000		0000000000000000
	SW	001110	00000		00000		0000000000000000
	
		OPCODE	RS       RT			RD			OP       
  ADD	001100	00000		00000		00000		01010	100000
  SUB 001100	00000		00000		00000		01010	100010
  MUL 001100	00000		00000		00000		01010	110010
  AND	001100	00000		00000		00000		01010	100100
   OR 001100	00000		00000		00000		01010	100101
*/

initial begin
	rs = 5'b0;
	rt = 5'b0;
	rd = 5'b0;
	rf_wr = 0;
	mux_writeback = 0;
	mem_wr = 0;
	mux_alu_out = 1;
	start = 0;
	alu_op = 0;
	mux_alu_in = 0;
end

always@(instruction) begin
	opcode = instruction[31:26];
	rs = instruction[25:21];
	rt = instruction[20:16];
	op = instruction[5:0];
	case(opcode)
		5'd13: begin //LW
			alu_op = 2'b0;     //Soma
			rd = rt;           //Rt como destino
			rf_wr = 1;         //Escreve no register file
			mem_wr = 0;        //lê da memória
			mux_alu_in = 1;    //Usa extend como entrada
			mux_alu_out = 1; 	 //Usa a saida da alu
			start = 0;         //Desabilita o multiplicador
			mux_writeback = 1; //Seleciona o pagefile para writeback
		end
		5'd14: begin //SW
			alu_op = 2'b0;     //Soma
			rd = rt;           //Rt como destino
			rf_wr = 0;         //Não escreve no register file
			mem_wr = 1;        //Escreve na memória
			mux_alu_in = 1;    //Usa extend como entrada
			mux_alu_out = 1;   //Usa a saida da alu
			start = 0;         //Desabilita o multiplicador
			mux_writeback = 1; //Seleciona o pagefile para writeback
		end
		5'd12: begin  //Operação aritmética
			rd = instruction[15:11]; //Rd como destino
			rf_wr = 1;               //Escreve no register file
			mux_alu_in = 0;          //Usa B como entrada
			start = 0;               //Inica o multiplicador desabilitado
			mux_writeback = 0;       //Seleciona o registro D para writeback
			case(op)
				6'd32: begin //Soma
							alu_op = 2'b0;
							mux_alu_out = 1; //Usa a saida da ALU
						 end
				6'd34: begin //Subtração
							alu_op = 2'b1;
							mux_alu_out = 1; //Usa a saida da ALU
						 end
				6'd50: begin //Multiplicação
							alu_op = 2'b0;
							mux_alu_out = 0; //Usa a saida do multiplicador
							start = 1; //Inicia o multiplicador
						 end
				6'd36: begin //AND
							alu_op = 2'd2;
							mux_alu_out = 1; //Usa a saida da ALU
						 end
				6'd37: begin //OR
							alu_op = 2'd3;
							mux_alu_out = 1; //Usa a saida da ALU
						 end
			endcase
		end
		default: begin
			rs = 5'b0;
			rt = 5'b0;
			rd = 5'b0;
			rf_wr = 0;
			mux_writeback = 0;
			mem_wr = 0;
			mux_alu_out = 1;
			start = 0;
			alu_op = 0;
			mux_alu_in = 0;
		end 
	endcase
	
end

endmodule 