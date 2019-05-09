module ALU_LEGv8(
      input [63:0] Ain, Bin,
	   input carryIn,
      input [4:0] ALUCtl,
      output logic [63:0] ALUOut,
      output logic [3:0] status
   );
   logic [63:0] A, B;
   logic [64:0] sum;

   always_comb begin
      A = ALUCtl[1] ? ~Ain : Ain;
      B = ALUCtl[0] ? ~Bin : Bin;
      sum = A + B + carryIn;
      case(ALUCtl[4:2])
         0: ALUOut = A & B;
         1: ALUOut = A | B;
         2: ALUOut = sum[63:0];
         3: ALUOut = A ^ B;
         4: ALUOut = Ain << Bin[5:0];
         5: ALUOut = Ain >> Bin[5:0];
         default: ALUOut = 0;
      endcase    //overflow, carry, negative, zero 
      status = {~(A[63] ^ B[63]) & (ALUOut[63] ^ A[63]), 1'b0, ALUOut[63], ALUOut == 0};
			  
   end
endmodule



/*module alu(A, B, cin, select, out, status);
	input [63:0] A, B;
	input cin;
	input [4:0] select;
	output [63:0] out;
	output [3:0] status;
	
	// SELECT CODES
	// xxxx1 Invert A
	// xxx1x Invert B
	// 000xx A AND B
	// 001xx A OR B
	// 010xx A XOR B
	// 011xx ADD A B
	// 100xx A << B
	// 101xx A >> B
	// 110xx 0
	// 111xx 0
	
	wire [63:0] ASignal, BSignal;
	inversion inv(A, B, select[1:0], ASignal, BSignal);
	
	wire [63:0] andAB, orAB, xorAB, addAB, left, right;
	wire overflow, cout, negative, zero;
	assign status = {overflow, cout, negative, zero};
	logicOut log(ASignal, BSignal, andAB, orAB, xorAB);
	adder add(ASignal, BSignal, cin, addAB, cout);
	shift shifter(A, B, left, right);
	
	muxOut mux(select[4:2], out, andAB, orAB, xorAB, addAB, left, right);
	
	assign negative = out[63];
	assign overflow = ~(ASignal[63] ^ BSignal[63]) & (out[63] ^ ASignal[63]);
	assign zero = (out == 64'b0) ? 1'b1 : 1'b0;
endmodule

module inversion(A, B, select, AOut, BOut);
	input [63:0] A, B;
	input [1:0] select;
	output [63:0] AOut, BOut;
	
	assign AOut = select[0] ? ~A : A;
	assign BOut = select[1] ? ~B : B;
endmodule

module logicOut(A, B, andAB, orAB, xorAB);
	input [63:0] A, B;
	output [63:0] andAB, orAB, xorAB;
	
	assign andAB = A & B;
	assign orAB = A | B;
	assign xorAB = A ^ B;
endmodule

module adder(A, B, cin, sum, cout);
	input [63:0] A, B;
	input cin;
	output [63:0] sum;
	output cout;
	
	wire [64:0] carry;
	assign carry[0] = cin;
	assign cout = carry[64];
	
	genvar i;
	generate
		for (i = 0; i < 64; i = i + 1) begin: fullAdders
			fullAdder adder(A[i], B[i], carry[i], sum[i], carry[i+1]);
		end
	endgenerate
endmodule

module fullAdder(A, B, cin, sum, cout);
	input A, B, cin;
	output sum, cout;
	
	assign sum = A ^ B ^ cin;
	assign cout = (A & B) | (A & cin) | (B & cin);
endmodule

module shift(A, B, left, right);
	input [63:0] A, B;
	output [63:0] left, right;
	
	assign left = A << B[5:0];
	assign right = A >> B[5:0];
endmodule

module muxOut(select, out, andAB, orAB, xorAB, addAB, shiftLA, shiftRA);
	input [2:0] select;
	output reg [63:0] out;
	input [63:0] andAB, orAB, xorAB, addAB, shiftLA, shiftRA;
	
	always @(*) begin
	case (select)
		3'b000: out <= andAB;
		3'b001: out <= orAB;
		3'b010: out <= xorAB;
		3'b011: out <= addAB;
		3'b100: out <= shiftLA;
		3'b101: out <= shiftRA;
		default: out <= 64'b0;
	endcase
	end
endmodule*/





/*module ALU_LEGv8(A, B, FS, C0, F, status);
	input [63:0] A, B;
	input [4:0]FS;
	// FS0 - b invert
	// FS1 - a invert
	// FS4:2 - op. select
	//   000 - AND
	//   001 - OR
	//   010 - ADD
	//   011 - XOR
	//   100 - shift left
	//   101 - shift right
	//   110 - none / 0
	//   111 - none / 0
	input C0;
	output [63:0]F;
	output [3:0]status;
	
	wire Z, N, C, V;
	assign status = {V, C, N, Z};
	
	wire [63:0] A_Signal, B_Signal;
	// A Mux
	assign A_Signal = FS[1] ? ~A : A;
	// B Mux
	assign B_Signal = FS[0] ? ~B : B;
	
	assign N = F[63];
	
	assign Z = (F == 64'b0) ? 1'b1 : 1'b0;
	
	assign V = ~(A_Signal[63] ^ B_Signal[63]) &  (F[63] ^ A_Signal[63]);
	
	wire [63:0]and_output, or_output, xor_output, add_output, shift_left, shift_right;
	assign and_output = A_Signal & B_Signal;
	assign or_output = A_Signal | B_Signal;
	assign xor_output = A_Signal ^ B_Signal;
	Adder adder_inst (add_output, C, A_Signal, B_Signal, C0);
	Shifter shift_inst (shift_left, shift_right, A, B[5:0]);
	
	Mux8to1Nbit main_mux (F, FS[4:2], and_output, or_output, add_output, xor_output, shift_left, shift_right, 64'b0, 64'b0);
endmodule

module Shifter(left, right, A, shift_amount);
	input [63:0] A;
	input [5:0] shift_amount;
	output[63:0] left, right;
	
	assign left = A << shift_amount;
	assign right = A >> shift_amount;
endmodule

module Adder(S, Cout, A, B, Cin);
	input [63:0] A, B;
	input Cin;
	output [63:0] S;
	output Cout;
	
	wire [64:0]carry;
	assign carry[0] = Cin;
	assign Cout = carry[64];
	// use generate block to instantiate 64 full adders
	genvar i;
	generate
	for (i=0; i<64; i=i+1) begin: full_adders // blocks within a generate block need to be named
		FullAdder adder_inst (S[i], carry[i+1], A[i], B[i], carry[i]);	
	end
	endgenerate
	// this will generate the following code:
	// FullAdder full_adders[0].adder_inst (S[0], carry[1], A[0], B[0], carry[0]);
	// FullAdder full_adders[1].adder_inst (S[1], carry[2], A[1], B[1], carry[1]);
	// ...
	// FullAdder full_adders[63].adder_inst (S[63], carry[64], A[63], B[63], carry[63]);
endmodule

module FullAdder(S, Cout, A, B, Cin);
	input A, B, Cin;
	output S, Cout;
	
	assign S = A ^ B ^ Cin;
	assign Cout = A&B | A&Cin | B&Cin;
endmodule*/
