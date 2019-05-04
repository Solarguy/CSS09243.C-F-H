module datapath(SFR1Out, SFR2Out, SFR3Out, SFR4Out, SFR5Out, SFR6Out, SFR7Out, SFR8Out, SFR9Out, SFR10Out, SFR11Out, SFR12Out, SFRV1O, SFRV2O, reset, clock, controlWord, /*write, AA, BA, DA, K, FS, Bselect, Cin,*/ status, /*loadStatus, ramWrite, pcSelect, PS, loadIR,*/ IRout,/* AS, DS,*/ dataBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	input clock;//, Cin, write, Bselect, ramWrite, AS, loadIR, loadStatus, pcSelect;
	//input [4:0] FS, AA, BA, DA;
	//input [1:0] PS, DS;
	//input [63:0] K;
	output reg reset;
	input [95:0] controlWord;
	wire Cin, write, Bselect, ramWrite, AS, loadIR, loadStatus, pcSelect;
	wire [4:0] FS, AA, BA, DA;
	wire [1:0] PS, DS;
	wire [63:0] K;
	
	assign {write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} = controlWord;
	
	output [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	output [31:0] IRout;
	wire EN_B, EN_ALU, EN_ALU_ADDRESS, EN_PC, EN_PC_ADDRESS, memRead;
	
	output [3:0] status;
	wire [3:0] statusIn;
	wire [63:0] regA, regB, aluB, aluF, pcIn, pcOut, pc4Out;
	wire [31:0] memA;
	output [63:0] dataBus;

	registerfile register (.clock(clock), .write(write), .reset(reset), .wrAddr(DA), .wrData(dataBus), .rdAddrA(AA), .rdDataA(regA), .rdAddrB(BA), .rdDataB(regB), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r16(r16), .r17(r17), .r18(r18), .r19(r19), .r20(r20), .r21(r21), .r22(r22), .r23(r23), .r24(r24), .r25(r25), .r26(r26), .r27(r27), .r28(r28), .r29(r29), .r30(r30), .r31(r31));
	
	ALU_LEGv8 logicUnit (regA, aluB, Cin, FS, aluF, statusIn);	
	statusRegister statusBits (loadStatus, clock, reset, statusIn, status);
	defparam statusBits.n = 4;
	wire [31:0]romout;
	
	RAM randomAccess (~clock, memA, dataBus, 1'b1, ramWrite, memRead);
	rom programMemory (romout, memA);
	programcounter PC (pcOut, pc4Out, pcIn, PS, clock, reset);
	instruction instructionRegister (loadIR, clock, reset, romout, IRout);
	defparam instructionRegister.n = 32;
	
	decoder_2to1 address (AS, EN_ALU_ADDRESS, EN_PC_ADDRESS);
	decoder_4to1 data (DS, EN_ALU, EN_B, EN_PC, memRead);
	mux_2to1_by64 Bmux (aluB, regB, K, Bselect);
	mux_2to1_by64 PCmux (pcIn, regA, K, pcSelect);
	assign dataBus = EN_B ? regB : 64'bz;
	assign dataBus = EN_ALU ? aluF : 64'bz;
	assign dataBus = EN_PC ? {32'b0, pc4Out[31:0]} : 64'bz;
	assign memA = EN_ALU_ADDRESS ? aluF[31:0] : 32'bz;
	assign memA = EN_PC_ADDRESS ? pcOut[31:0] : 32'bz;
	
	reg state;
	initial begin
		state = 1'b0;
		reset = 1'b1;
	end
	
	always @(posedge clock) begin
		case (state)
			1'b0: begin
				reset = 1'b0;
				state = 1'b1;
			end
			1'b1: reset = 1'b1;
		endcase
	end
	
	
	//SFR Design

wire SFRL1, SFRL2, SFRL3, SFRL4, SFRL5, SFRL6, SFRL7, SFRL8, SFRL9, SFRL10, SFRL11, SFRL12, SFRL13, SFRL14;
output [63:0]SFR1Out, SFR2Out, SFR3Out, SFR4Out, SFR5Out, SFR6Out, SFR7Out, SFR8Out, SFR9Out, SFR10Out, SFR11Out, SFR12Out;

SFRDecoder SFRcode(clock, ramWrite, memA, SFRL1, SFRL2, SFRL3, SFRL4, SFRL5, SFRL6, SFRL7, SFRL8, SFRL9, SFRL10, SFRL11, SFRL12, SFRL13, SFRL14);

	//CHARACTER SFR
SFR SFR1(SFRL1, clock, reset, dataBus, SFR1Out); //register for 'c'

SFR SFR2(SFRL2, clock, reset, dataBus, SFR2Out); //register for 'u'

SFR SFR3(SFRL3, clock, reset, dataBus, SFR3Out); //register for 'r'

SFR SFR4(SFRL4, clock, reset, dataBus, SFR4Out); //register for 's'

SFR SFR5(SFRL5, clock, reset, dataBus, SFR5Out); //register for 'o'

SFR SFR6(SFRL6, clock, reset, dataBus, SFR6Out); //register for ' ' 

SFR SFR7(SFRL7, clock, reset, dataBus, SFR7Out); //register for '|' 

SFR SFR8(SFRL8, clock, reset, dataBus, SFR8Out); //register for 'g' 

SFR SFR9(SFRL9, clock, reset, dataBus, SFR9Out); //register for 'a'

SFR SFR10(SFRL10, clock, reset, dataBus, SFR10Out); //register for 'n'

SFR SFR11(SFRL11, clock, reset, dataBus, SFR11Out); //register for 'd'

SFR SFR12(SFRL12, clock, reset, dataBus, SFR12Out); //register for 'm'


	//NUMBER SF
	
	output [15:0]SFRV1O, SFRV2O; //outputs to CPU to display
	wire  [63:0] SFR13Out, SFR14Out;
	
SFR SFRV1(SFRL13, clock, reset, dataBus, SFR13Out); //links r17 to output onto display

hex_UTF8 V1(SFR13Out, SFRV1O); 

SFR SFRV2(SFRL14, clock, reset, dataBus, SFR14Out); //links r18 to output onto display

hex_UTF8 V2(SFR14Out, SFRV2O); 

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

module decoder_2to1(select, outA, outB);
	input select;
	output reg outA, outB;
	
	always @(select)
	begin
		case (select)
			1'b0 : {outB, outA} = 2'b01;
			1'b1 : {outB, outA} = 2'b10;
		endcase
	end
endmodule

module decoder_4to1(select, outA, outB, outC, outD);
	input [1:0] select;
	output reg outA, outB, outC, outD;
	
	always @(select)
	begin
		case (select)
			2'b00 : {outD, outC, outB, outA} = 4'b0001;
			2'b01 : {outD, outC, outB, outA} = 4'b0010;
			2'b10 : {outD, outC, outB, outA} = 4'b0100;
			2'b11 : {outD, outC, outB, outA} = 4'b1000;
		endcase
	end
endmodule

module instruction(load, clock, reset, in, out);
	parameter n = 64;
	input load, clock, reset;
	input [n-1:0] in;
	output reg [n-1:0] out;

	always @(negedge clock or negedge reset) begin
		if (~reset)
			out <= {n{1'b0}};
		else if (load)
			out <= in;
	end
endmodule

module statusRegister(load, clock, reset, in, out);
	parameter n = 64;
	input load, clock, reset;
	input [n-1:0] in;
	output reg [n-1:0] out;

	always @(negedge clock or negedge reset) begin
		if (~reset)
			out <= {n{1'b0}};
		else if (load)
			out <= in;
	end

		
endmodule





