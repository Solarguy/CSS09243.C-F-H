module Mux4to1Nbit(F, S, I0, I1, I2, I3);
	parameter N = 64;
	input [N-1:0]I0, I1, I2, I3;
	input [1:0]S;
	output [N-1:0]F;
	
	assign F = S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0);
endmodule

module Mux8to1Nbit(F, S, I0, I1, I2, I3, I4, I5, I6, I7);
	parameter N = 64;
	input [N-1:0]I0, I1, I2, I3, I4, I5, I6, I7;
	input [2:0]S;
	output [N-1:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule

// this is here only to make into a block
module mux2to1_64bit(F, S, I0, I1);
	input [63:0] I0, I1;
	input S;
	output [63:0] F;
	
	assign F = S ? I1 : I0;
endmodule
