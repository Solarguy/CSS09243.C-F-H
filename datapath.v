module datapath(clock, cin, Bselect, reset, write, EN_B, EN_ALU, FS, K, AA, BA, DA, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	input clock, cin, reset, write, Bselect, EN_B, EN_ALU;
	input [4:0] FS, AA, BA, DA;
	input [63:0] K;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	
	wire [3:0] status;
	wire [63:0] regA, regB, aluB, aluF, bus;
	
	registerfile register (write, clock, reset, bus, DA, AA, BA, regA, regB, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	alu logicUnit (regA, aluB, cin, FS, aluF, status);
	
	mux_2to1_by64 Bmux (aluB, regB, K, Bselect);
	tribuf64 B (bus, regB, EN_B);
	tribuf64 ALU (bus, aluF, EN_ALU);
endmodule

module tribuf64(out, in, control);
	input [63:0] in;
	input control;
	output [63:0]out;

	assign out = control ? in : 64'bz;
endmodule

module mux_2to1_by64(out, inA, inB, select);
	input [63:0] inA, inB;
	input select;
	output reg [63:0] out;
	
	always @(select or inA or inB)
	begin
		case (select)
			1'b0 : out = inA;
			1'b1 : out = inB;
			default : out = 1'bx;
		endcase
	end
endmodule
