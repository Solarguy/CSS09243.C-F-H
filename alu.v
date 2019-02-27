module alu(A, B, cin, select, out, status);
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
endmodule
