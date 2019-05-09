//module programcounter(PC, PC4, in, PS, clk, reset);
//	input [63:0]in;
//	input[1:0]PS;
//	//PS
//	input clk, reset;
//	output [63:0]PC;
//	output [63:0]PC4;
//
//	wire [63:0] PC_in;
//	wire [63:0]AdderOut;
//	wire load_PC;
//
//	assign load_PC = 1'b1;	assign PC4 = PC + 4; //+4 adderOut
//
//	assign AdderOut = PC4 + {in[61:0], 2'b00};
//	MUX4to1Nbit PC_Mux (PC_in, PS, PC, PC4, in, AdderOut);
//	defparam PC_Mux.N = 64;
//	RegisterNbit PC_Reg (PC, PC_in, load_PC, reset, clock);
//	defparam PC_Reg.N = 64;
//
//endmodule

module programcounter(PC, PC4, in, PS, clock, reset);
input [63:0]in;
input [1:0]PS; 

// Program counter function Select bits
// PS
// 00 - PC <= PC
// 01 - PC <= PC+4
// 10 - PC <= in
// 11 - PC <= PC+in*4
input clock, reset;
output [63:0]PC;
output[63:0]PC4;
wire load_PC;
wire [63:0] PC_in; // input to program counter / output from mux
wire [63:0] AdderOut; // output of offeset adderwire load_PC;

assign load_PC = 1'b1;
assign PC4 = PC + 4096; // +4 adder
assign AdderOut = PC + {in[51:0], 12'b0}; //branch to PC = 1 + K
Mux4to1Nbit PC_Mux (PC_in, PS, PC, PC4, in, AdderOut);
defparam PC_Mux.N = 64;

RegisterPC PC_Reg (PC, PC_in, load_PC, reset, clock);

endmodule

module RegisterPC(Q, D, L, R, clock);
	output reg [63:0]Q; // registered output
	input [63:0]D; // data input
	input L; // load
	input R; // positive edge reset
	input clock;
	
	always @(posedge clock or negedge R) begin
		if(~R)
			Q <= 64'hFFF;
		else if(L)
			Q <= D;
		else
			Q <= Q;
	end
endmodule


