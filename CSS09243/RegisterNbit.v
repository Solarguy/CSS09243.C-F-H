module RegisterNbit(Q, D, L, R, clock);
	parameter N = 64;
	output reg [N-1:0]Q; // registered output
	input [N-1:0]D; // data input
	input L; // load
	input R; // positive edge reset
	input clock;
	
	always @(posedge clock or negedge R) begin
		if(~R)
			Q <= 0;
		else if(L)
			Q <= D;
		else
			Q <= Q;
	end
endmodule

