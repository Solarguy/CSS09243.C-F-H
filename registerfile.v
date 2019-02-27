module registerfile(write, clock, reset, dataIn, dataSelect, outputASelect, outputBSelect, outputA, outputB, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	input write, clock, reset;
	input [63:0] dataIn;
	input [4:0] dataSelect, outputASelect, outputBSelect;
	output [63:0] outputA, outputB;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	
	wire [31:0] dataDecoded;
	wire [63:0] reg0Out, reg1Out, reg2Out, reg3Out, reg4Out, reg5Out, reg6Out, reg7Out, reg8Out, reg9Out, reg10Out, reg11Out, reg12Out, reg13Out, reg14Out, reg15Out, reg16Out, reg17Out, reg18Out, reg19Out, reg20Out, reg21Out, reg22Out, reg23Out, reg24Out, reg25Out, reg26Out, reg27Out, reg28Out, reg29Out, reg30Out, reg31Out;
	
	decoder5to32 loadDecoder(dataSelect, dataDecoded);
	
	register64 reg0(write & dataDecoded[0], clock, reset, dataIn, reg0Out);
	register64 reg1(write & dataDecoded[1], clock, reset, dataIn, reg1Out);
	register64 reg2(write & dataDecoded[2], clock, reset, dataIn, reg2Out);
	register64 reg3(write & dataDecoded[3], clock, reset, dataIn, reg3Out);
	register64 reg4(write & dataDecoded[4], clock, reset, dataIn, reg4Out);
	register64 reg5(write & dataDecoded[5], clock, reset, dataIn, reg5Out);
	register64 reg6(write & dataDecoded[6], clock, reset, dataIn, reg6Out);
	register64 reg7(write & dataDecoded[7], clock, reset, dataIn, reg7Out);
	register64 reg8(write & dataDecoded[8], clock, reset, dataIn, reg8Out);
	register64 reg9(write & dataDecoded[9], clock, reset, dataIn, reg9Out);
	register64 reg10(write & dataDecoded[10], clock, reset, dataIn, reg10Out);
	register64 reg11(write & dataDecoded[11], clock, reset, dataIn, reg11Out);
	register64 reg12(write & dataDecoded[12], clock, reset, dataIn, reg12Out);
	register64 reg13(write & dataDecoded[13], clock, reset, dataIn, reg13Out);
	register64 reg14(write & dataDecoded[14], clock, reset, dataIn, reg14Out);
	register64 reg15(write & dataDecoded[15], clock, reset, dataIn, reg15Out);
	register64 reg16(write & dataDecoded[16], clock, reset, dataIn, reg16Out);
	register64 reg17(write & dataDecoded[17], clock, reset, dataIn, reg17Out);
	register64 reg18(write & dataDecoded[18], clock, reset, dataIn, reg18Out);
	register64 reg19(write & dataDecoded[19], clock, reset, dataIn, reg19Out);
	register64 reg20(write & dataDecoded[20], clock, reset, dataIn, reg20Out);
	register64 reg21(write & dataDecoded[21], clock, reset, dataIn, reg21Out);
	register64 reg22(write & dataDecoded[22], clock, reset, dataIn, reg22Out);
	register64 reg23(write & dataDecoded[23], clock, reset, dataIn, reg23Out);
	register64 reg24(write & dataDecoded[24], clock, reset, dataIn, reg24Out);
	register64 reg25(write & dataDecoded[25], clock, reset, dataIn, reg25Out);
	register64 reg26(write & dataDecoded[26], clock, reset, dataIn, reg26Out);
	register64 reg27(write & dataDecoded[27], clock, reset, dataIn, reg27Out);
	register64 reg28(write & dataDecoded[28], clock, reset, dataIn, reg28Out);
	register64 reg29(write & dataDecoded[29], clock, reset, dataIn, reg29Out);
	register64 reg30(write & dataDecoded[30], clock, reset, dataIn, reg30Out);
	assign reg31Out = 64'b0;
	
	mux32x64to1x64 aMux(outputASelect, reg0Out, reg1Out, reg2Out, reg3Out, reg4Out, reg5Out, reg6Out, reg7Out, reg8Out, reg9Out, reg10Out, reg11Out, reg12Out, reg13Out, reg14Out, reg15Out, reg16Out, reg17Out, reg18Out, reg19Out, reg20Out, reg21Out, reg22Out, reg23Out, reg24Out, reg25Out, reg26Out, reg27Out, reg28Out, reg29Out, reg30Out, reg31Out, outputA);
	mux32x64to1x64 bMux(outputBSelect, reg0Out, reg1Out, reg2Out, reg3Out, reg4Out, reg5Out, reg6Out, reg7Out, reg8Out, reg9Out, reg10Out, reg11Out, reg12Out, reg13Out, reg14Out, reg15Out, reg16Out, reg17Out, reg18Out, reg19Out, reg20Out, reg21Out, reg22Out, reg23Out, reg24Out, reg25Out, reg26Out, reg27Out, reg28Out, reg29Out, reg30Out, reg31Out, outputB);
	
	assign r0 = reg0Out[15:0];
	assign r1 = reg1Out[15:0];
	assign r2 = reg2Out[15:0];
	assign r3 = reg3Out[15:0];
	assign r4 = reg4Out[15:0];
	assign r5 = reg5Out[15:0];
	assign r6 = reg6Out[15:0];
	assign r7 = reg7Out[15:0];
	assign r8 = reg8Out[15:0];
	assign r9 = reg9Out[15:0];
	assign r10 = reg10Out[15:0];
	assign r11 = reg11Out[15:0];
	assign r12 = reg12Out[15:0];
	assign r13 = reg13Out[15:0];
	assign r14 = reg14Out[15:0];
	assign r15 = reg15Out[15:0];
	assign r16 = reg16Out[15:0];
	assign r17 = reg17Out[15:0];
	assign r18 = reg18Out[15:0];
	assign r19 = reg19Out[15:0];
	assign r20 = reg20Out[15:0];
	assign r21 = reg21Out[15:0];
	assign r22 = reg22Out[15:0];
	assign r23 = reg23Out[15:0];
	assign r24 = reg24Out[15:0];
	assign r25 = reg25Out[15:0];
	assign r26 = reg26Out[15:0];
	assign r27 = reg27Out[15:0];
	assign r28 = reg28Out[15:0];
	assign r29 = reg29Out[15:0];
	assign r30 = reg30Out[15:0];
	assign r31 = reg31Out[15:0];
endmodule

module decoder5to32(select, result);
	input [4:0] select;
	output reg [31:0] result;

	always @(select) begin
		case (select)
			5'd0  : result = 32'b00000000000000000000000000000001;
			5'd1  : result = 32'b00000000000000000000000000000010;
			5'd2  : result = 32'b00000000000000000000000000000100;
			5'd3  : result = 32'b00000000000000000000000000001000;
			5'd4  : result = 32'b00000000000000000000000000010000;
			5'd5  : result = 32'b00000000000000000000000000100000;
			5'd6  : result = 32'b00000000000000000000000001000000;
			5'd7  : result = 32'b00000000000000000000000010000000;
			5'd8  : result = 32'b00000000000000000000000100000000;
			5'd9  : result = 32'b00000000000000000000001000000000;
			5'd10 : result = 32'b00000000000000000000010000000000;
			5'd11 : result = 32'b00000000000000000000100000000000;
			5'd12 : result = 32'b00000000000000000001000000000000;
			5'd13 : result = 32'b00000000000000000010000000000000;
			5'd14 : result = 32'b00000000000000000100000000000000;
			5'd15 : result = 32'b00000000000000001000000000000000;
			5'd16 : result = 32'b00000000000000010000000000000000;
			5'd17 : result = 32'b00000000000000100000000000000000;
			5'd18 : result = 32'b00000000000001000000000000000000;
			5'd19 : result = 32'b00000000000010000000000000000000;
			5'd20 : result = 32'b00000000000100000000000000000000;
			5'd21 : result = 32'b00000000001000000000000000000000;
			5'd22 : result = 32'b00000000010000000000000000000000;
			5'd23 : result = 32'b00000000100000000000000000000000;
			5'd24 : result = 32'b00000001000000000000000000000000;
			5'd25 : result = 32'b00000010000000000000000000000000;
			5'd26 : result = 32'b00000100000000000000000000000000;
			5'd27 : result = 32'b00001000000000000000000000000000;
			5'd28 : result = 32'b00010000000000000000000000000000;
			5'd29 : result = 32'b00100000000000000000000000000000;
			5'd30 : result = 32'b01000000000000000000000000000000;
			5'd31 : result = 32'b10000000000000000000000000000000;
			default:result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		endcase
	end
endmodule

module mux32x64to1x64(select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, out);
	input [4:0] select;
	input [63:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
	output reg [63:0] out;

	always @(*) begin
		case (select)
			5'd0  : out = in0;
			5'd1  : out = in1;
			5'd2  : out = in2;
			5'd3  : out = in3;
			5'd4  : out = in4;
			5'd5  : out = in5;
			5'd6  : out = in6;
			5'd7  : out = in7;
			5'd8  : out = in8;
			5'd9  : out = in9;
			5'd10 : out = in10;
			5'd11 : out = in11;
			5'd12 : out = in12;
			5'd13 : out = in13;
			5'd14 : out = in14;
			5'd15 : out = in15;
			5'd16 : out = in16;
			5'd17 : out = in17;
			5'd18 : out = in18;
			5'd19 : out = in19;
			5'd20 : out = in20;
			5'd21 : out = in21;
			5'd22 : out = in22;
			5'd23 : out = in23;
			5'd24 : out = in24;
			5'd25 : out = in25;
			5'd26 : out = in26;
			5'd27 : out = in27;
			5'd28 : out = in28;
			5'd29 : out = in29;
			5'd30 : out = in30;
			5'd31 : out = in31;
		endcase
	end
endmodule

module register64(load, clock, reset, in, out);
	input load, clock, reset;
	input [63:0] in;
	output reg [63:0] out;

	always @(posedge clock or negedge reset) begin
		if (~reset)
			out <= 64'h0000000000000000;
		else if (load)
			out <= in;
	end
endmodule

