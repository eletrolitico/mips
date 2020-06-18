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
/*					5	 5	  5	1		 1					 1			1				 1		  2	 	 1            = 23			
   INSTRUÇÕES 
		OPCODE	RS			RT			OFFSET
	LW 001101	00000		00000		XXXXXXXXXXXXXXXX
	SW	001110	00000		00000		XXXXXXXXXXXXXXXX
		OPCODE	RS       RT			RD			OP       
  ADD	001100	00000		00000		00000		01010	100000
  SUB 001100	00000		00000		00000		01010	100010
  MUL 001100	00000		00000		00000		01010	110010
  AND	001100	00000		00000		00000		01010	100100
   OR 001100	00000		00000		00000		01010	100101
*/


	always @ (instruction) 
	begin
		opcode = instruction[31:26];
		rs = instruction[25:21];
		rt = instruction[20:16];
		op = instruction[5:0];
		case(opcode)
			5'd13: 				 //LW
			begin 
				alu_op = 2'b0;     //Soma
				rd = rt;           //Rt como destino
				rf_wr = 1;         //Escreve no register file
				mem_wr = 0;        //lê da memória
				mux_alu_in = 1;    //Usa extend como entrada
				mux_alu_out = 1; 	 //Usa a saida da alu
				start = 0;         //Desabilita o multiplicador
				mux_writeback = 1; //Seleciona o M para writeback
			end
			5'd14: 				 //SW
			begin 
				alu_op = 2'b0;     //Soma
				rd = rt;           //Rt como destino
				rf_wr = 0;         //Não escreve no register file
				mem_wr = 1;        //Escreve na memória
				mux_alu_in = 1;    //Usa extend como entrada
				mux_alu_out = 1;   //Usa a saida da alu
				start = 0;         //Desabilita o multiplicador
				mux_writeback = 1; //Seleciona o M para writeback
			end
			5'd12: 						 //Operação aritmética
			begin  
				rd = instruction[15:11]; //Rd como destino
				rf_wr = 1;               //Escreve no register file
				mux_alu_in = 0;          //Usa B como entrada
				start = 0;               //Inica o multiplicador desabilitado
				mux_writeback = 0;       //Seleciona o registro D para writeback
				mem_wr = 0;
				case(op)
					6'd32: //Soma 
					begin 
						alu_op = 2'b0;
						mux_alu_out = 1; //Usa a saida da ALU
					end
					6'd34: //Subtração
					begin
						alu_op = 2'b1;
						mux_alu_out = 1; //Usa a saida da ALU
					end
					6'd50: //Multiplicação
					begin
						alu_op = 2'b0;
						mux_alu_out = 0; //Usa a saida do multiplicador
						start = 1; //Inicia o multiplicador
					end
					6'd36: //AND
					begin
						alu_op = 2'd2;
						mux_alu_out = 1; //Usa a saida da ALU
					end
					6'd37: //OR
					begin
						alu_op = 2'd3;
						mux_alu_out = 1; //Usa a saida da ALU
					end
					default:
					begin
						alu_op = 2'd0;
						mux_alu_out = 1;
					end
				endcase
			end
			default: 
			begin
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