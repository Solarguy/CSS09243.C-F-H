module registerfile(input clock,
input write,
input reset,
input [4:0] wrAddr,
input [63:0] wrData,
input [4:0] rdAddrA,
output [63:0] rdDataA,
input [4:0] rdAddrB,
output [63:0] rdDataB,                          //only NEED r0-r7
output[63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30,r31); //outputs for visualization

wire [31:0] decoderout;

wire [63:0]Q0;
wire [63:0]Q1;
wire [63:0]Q2;
wire [63:0]Q3;
wire [63:0]Q4;
wire [63:0]Q5;
wire [63:0]Q6;
wire [63:0]Q7;
wire [63:0]Q8;
wire [63:0]Q9;
wire [63:0]Q10;
wire [63:0]Q11;
wire [63:0]Q12;
wire [63:0]Q13;
wire [63:0]Q14;
wire [63:0]Q15;
wire [63:0]Q16;
wire [63:0]Q17;
wire [63:0]Q18;
wire [63:0]Q19;
wire [63:0]Q20;
wire [63:0]Q21;
wire [63:0]Q22;
wire [63:0]Q23;
wire [63:0]Q24;
wire [63:0]Q25;
wire [63:0]Q26;
wire [63:0]Q27;
wire [63:0]Q28;
wire [63:0]Q29;
wire [63:0]Q30;
wire [63:0]Q31;

decoder5x32 decoder1(wrAddr, decoderout);

RegisterNbit R0 (Q0, wrData, write & decoderout[0], reset, clock); //32 64-bit registers
RegisterNbit R1 (Q1, wrData, write & decoderout[1], reset, clock);
RegisterNbit R2 (Q2, wrData, write & decoderout[2], reset, clock);
RegisterNbit R3 (Q3, wrData, write & decoderout[3], reset, clock);
RegisterNbit R4 (Q4, wrData, write & decoderout[4], reset, clock);
RegisterNbit R5 (Q5, wrData, write & decoderout[5], reset, clock);
RegisterNbit R6 (Q6, wrData, write & decoderout[6], reset, clock);
RegisterNbit R7 (Q7, wrData, write & decoderout[7], reset, clock);
RegisterNbit R8 (Q8, wrData, write & decoderout[8], reset, clock);
RegisterNbit R9 (Q9, wrData, write & decoderout[9], reset, clock);
RegisterNbit R10 (Q10, wrData, write & decoderout[10], reset, clock);
RegisterNbit R11 (Q11, wrData, write & decoderout[11], reset, clock);
RegisterNbit R12 (Q12, wrData, write & decoderout[12], reset, clock);
RegisterNbit R13 (Q13, wrData, write & decoderout[13], reset, clock);
RegisterNbit R14 (Q14, wrData, write & decoderout[14], reset, clock);
RegisterNbit R15 (Q15, wrData, write & decoderout[15], reset, clock);
RegisterNbit R16 (Q16, wrData, write & decoderout[16], reset, clock);
RegisterNbit R17 (Q17, wrData, write & decoderout[17], reset, clock);
RegisterNbit R18 (Q18, wrData, write & decoderout[18], reset, clock);
RegisterNbit R19 (Q19, wrData, write & decoderout[19], reset, clock);
RegisterNbit R20 (Q20, wrData, write & decoderout[20], reset, clock);
RegisterNbit R21 (Q21, wrData, write & decoderout[21], reset, clock);
RegisterNbit R22 (Q22, wrData, write & decoderout[22], reset, clock);
RegisterNbit R23 (Q23, wrData, write & decoderout[23], reset, clock);
RegisterNbit R24 (Q24, wrData, write & decoderout[24], reset, clock);
RegisterNbit R25 (Q25, wrData, write & decoderout[25], reset, clock);
RegisterNbit R26 (Q26, wrData, write & decoderout[26], reset, clock);
RegisterNbit R27 (Q27, wrData, write & decoderout[27], reset, clock);
RegisterNbit R28 (Q28, wrData, write & decoderout[28], reset, clock);
RegisterNbit R29 (Q29, wrData, write & decoderout[29], reset, clock);
RegisterNbit R30 (Q30, wrData, write & decoderout[30], reset, clock);
assign Q31 = 64'b0;

Mux32to1Nbit MuxA(rdDataA,rdAddrA, Q0, Q1, Q2, Q3, Q4, Q5, Q6,
										Q7, Q8, Q9, Q10, Q11, Q12,
										Q13, Q14, Q15, Q16, Q17,
										Q18, Q19, Q20, Q21, Q22, 
										Q23, Q24, Q25, Q26, Q27, 
										Q28, Q29, Q30, Q31);
										
Mux32to1Nbit MuxB(rdDataB, rdAddrB, Q0, Q1, Q2, Q3, Q4, Q5,
										Q6, Q7, Q8, Q9, Q10, Q11,
										Q12, Q13, Q14, Q15, Q16,
										Q17, Q18, Q19, Q20, Q21, 
										Q22, Q23, Q24, Q25, Q26, 
										Q27, Q28, Q29, Q30, Q31);

//outputs to visualize lower 16-bits of lower 8 registers on the DE0
assign r0 = Q0;//[15:0];
assign r1 = Q1;//[15:0];
assign r2 = Q2;//[15:0];
assign r3 = Q3;//[15:0];
assign r4 = Q4;//[15:0];
assign r5 = Q5;//[15:0];
assign r6 = Q6;//[15:0];
assign r7 = Q7;//[15:0];
assign r8 = Q8;//[15:0];
assign r9 = Q9;//[15:0];
assign r10 = Q10;//[15:0];
assign r11 = Q11;//[15:0];
assign r12 = Q12;//[15:0];
assign r13 = Q13;//[15:0];
assign r14 = Q14;//[15:0];
assign r15 = Q15;//[15:0];
assign r16 = Q16;//[15:0];
assign r17 = Q17;//[15:0];
assign r18 = Q18;//[15:0];
assign r19 = Q19;//[15:0];
assign r20 = Q20;//[15:0];
assign r21 = Q21;//[15:0];
assign r22 = Q22;//[15:0];
assign r23 = Q23;//[15:0];
assign r24 = Q24;//[15:0];
assign r25 = Q25;//[15:0];
assign r26 = Q26;//[15:0];
assign r27 = Q27;//[15:0];
assign r28 = Q28;//[15:0];
assign r29 = Q29;//[15:0];
assign r30 = Q30;//[15:0];
assign r31 = Q31;


endmodule
