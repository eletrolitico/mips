module ffd(input clk,rst,d,output reg q);

	always @(posedge clk, posedge rst) begin
		if(rst)
			q <= 0;
		else
			q <= d;
	end

endmodule 