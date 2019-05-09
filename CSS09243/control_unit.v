module control_unit(clock, /*r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31,*/ controlWord, status, IRout);
	input clock;
	/*wire Cin, write, Bselect, ramWrite, pcSelect, AS, loadIR, loadStatus;
	wire [4:0] FS, AA, BA, DA;
	wire [1:0] PS, DS;
	wire [63:0] K;*/
	input [31:0] IRout;
	input [3:0] status;
	
	reg [95:0] IF, EX0, EX1, EX2;
	reg [1:0] state;
	
	//output [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	output reg [95:0] controlWord;
	//assign controlWord = {write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS};
	
	reg [999:0] test;

	//datapath path(clock, reset, write, AA, BA, DA, K, FS, Bselect, Cin, status, loadStatus, ramWrite, pcSelect, PS, loadIR, IRout, AS, DS, dataBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	
	initial begin
		IF = {1'b0, 5'b0, 5'b0, 5'b0, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b1, 1'b1, 2'b11};
		EX0 = 96'b0;
		EX1 = 96'b0;
		EX2 = 96'b0;
		controlWord = IF;
		state = 2'b00;
	end

	always @(IRout) begin
		//if (~(IRout == 32'bz)) begin
			case (IRout[26])
				1'b0: begin
					case (IRout[25:23])
						3'b000: begin //D-format
							case(IRout[22])
								1'b0: begin //STORE
									case(IRout[31])
										1'b0: EX0 <= 96'b0; // STURB
										1'b1: begin // STUR
											EX0 <= {1'b0, IRout[9:5], IRout[4:0], 5'b00000, {55'b0, IRout[20:12]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00, 1'b0, 1'b0, 2'b01};
											EX1 <= {1'b0, IRout[9:5], IRout[4:0], 5'b00000, {55'b0, IRout[20:12]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b01};
										end
									endcase
								end
								1'b1: begin//LDUR
									case(IRout[31])
										1'b0: begin // LDURB
											EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {55'b0, IRout[20:12]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b11};
											EX1 <= {1'b1, IRout[4:0], 5'b00000, IRout[4:0], {56'b0, 8'b11111111}, 5'b00000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
										end
										1'b1: begin // LDUR
											EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {55'b0, IRout[20:12]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b11};
											EX1 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {55'b0, IRout[20:12]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b11};
										end
									endcase
								end
							endcase
						end
						3'b010: begin
							case (IRout[30])
								1'b0: begin
									case (IRout[29])
										1'b0: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ADDI, confirmed
										1'b1: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b01000, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ADDIS, confirmed
									endcase
								end
								1'b1: begin
									case (IRout[29])
										1'b0: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b01001, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01, 1'b1, 1'b0, 2'b00}; // SUBI, confirmed
										1'b1: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b01001, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // SUBIS/CMPI (When Rd = 5'b11111), confirmed
									endcase
								end
							endcase
						end
						3'b100: begin //logic D-format
							case(IRout[28])
								1'b1: begin //I-format logic
									case(IRout[30:29])
										2'b00: begin
											case (IRout[27])
												1'b0: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b00000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ANDI, confirmed
												1'b1: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 1'b0, 5'b01000, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ADC
											endcase
										end
										2'b01: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b00100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ORRI, confirmed
										2'b10: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b01100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // EORI, confirmed
										2'b11: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {52'b0, IRout[21:10]}, 5'b00000, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ANDIS/TST(I) when Rd = 5'b11111, confirmed
									endcase
								end
								1'b0: begin //R format logic
									case(IRout[30:29])
										2'b00: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // AND, confirmed
										2'b01: begin
											case (IRout[21])
												1'b0: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b00100, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ORR, confirmed
												1'b1: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b00011, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ORN/MVN when Rn is 5'b11111, confirmed
										endcase
										end
										2'b10: begin
											case (IRout[21])
												1'b0: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01100, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // EOR, confirmed
												1'b1: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01110, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // EON, confirmed
											endcase
										end
										2'b11: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b00000, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ANDS/TST (register) when Rd = 5'b11111, confirmed
									endcase
								end
							endcase
						end
						3'b101: begin //IW-Format (MOVK and MOVZ)
							case(IRout[29])
								1'b0: EX0 <= {1'b1, 5'b11111, 5'b00000, IRout[4:0], {48'b0, IRout[20:5]}, 5'b01000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // MOVZ
								1'b1: begin // MOVK, confirmed
									EX0 <= {1'b1, IRout[4:0], 5'b00000, IRout[4:0], {48'hFFFFFFFFFFFF, 16'b0}, 5'b000000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00};
									EX1 <= {1'b1, IRout[4:0], 5'b00000, IRout[4:0], {48'b0, IRout[20:5]}, 5'b00100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
								end
							endcase
						end
						3'b110: begin //R-arith/Shift
							case(IRout[22])
								1'b1: begin //shift
									case(IRout[21])
										1'b0: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {58'b0, IRout[15:10]}, 5'b10100, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // LSR, confirmed
										1'b1: EX0 <= {1'b1, IRout[9:5], 5'b00000, IRout[4:0], {58'b0, IRout[15:10]}, 5'b10000, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // LSL, confirmed
									endcase
								end
								1'b0: begin //Arithmetic
									case(IRout[29])
										1'b0: begin
											case(IRout[30])
												1'b0: begin
													case (IRout[28])
														1'b0: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ADD, confirmed
														1'b1: begin // MUL
															test[999] = 1'b1;
															EX0 <= {1'b1, IRout[20:16], 5'b11111, 5'b11101, 64'b0, 5'b01000, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
															EX1 <= {1'b1, IRout[9:5], IRout[4:0], IRout[4:0], 64'b0, 5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00}; 
															EX2 <= {1'b1, 5'b11101, 5'b00000, 5'b11101, 64'b1, 5'b01001, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00};
														end
													endcase
												end
												1'b1: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01001, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // ADDS, confirmed
											endcase
										end
										1'b1: begin
											case(IRout[30])
												1'b0: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01000, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // SUB/NEG when Rn = 5'b11111, confirmed
												1'b1: EX0 <= {1'b1, IRout[9:5], IRout[20:16], IRout[4:0], 64'b0, 5'b01001, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00}; // SUBS/CMP when Rd = 5'b11111, confirmed
											endcase
										end
									endcase
								end
							endcase
						end
						default;
					endcase
				end
				1'b1: begin //conditional operations
					case(IRout[31:29])
						3'b000: EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {38'b0, IRout[25:0]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00}; // B, confirmed
						3'b010: begin // B.cond
							EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
							case (IRout[4:0])
								// V, C, N, Z
								// 3, 2, 1, 0
								5'b00000: begin // EQ, confirmed
									if (status[0]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00001: begin // NE, confirmed
									if (~status[0]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00010: begin // HS, confirmed
									if (status[2]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00011: begin // LO, confirmed
									if (~status[2]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00100: begin // MI, confirmed
									if (status[1]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00101: begin // PL, confirmed
									if (~status[1]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00110: begin // VS
									if (status[3]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b00111: begin // VC
									if (~status[3]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01000: begin // HI
									if (status[2] & ~status[0]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01001: begin // LS
									if (~status[2] & status[0]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01010: begin // GE
									if (status[1] ^ status[3]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01011: begin // LT
									if (status[1] ^ status[3]) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01100: begin // GT
									if (~status[0] & ~(status[1] ^ status[3])) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01101: begin // LE
									if (status[0] | (status[1] ^ status[3])) begin
										EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									end
								end
								5'b01110: begin // AL
									EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
								end
								5'b01111: begin // NV
									EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
								end
								default: EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
							endcase
							//EX0 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, {45'b0, IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00}; 
							//EX1 <= {1'b0, 5'b00000, 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
						end
						3'b100: begin // BL, confirmed
							EX0 = {1'b1, 5'b00000, 5'b00000, 5'b11110, 64'b100000000000, 5'b01000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b10};
							EX1 = {1'b0, 5'b00000, 5'b00000, 5'b00000, {38'b0, IRout[25:0]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
						end
						3'b101: begin
							case(IRout[24])
								1'b0: begin // CBZ, confirmed
									EX0 = {1'b0, IRout[4:0], 5'b11111, 5'b00000, 64'b0, 5'b01000, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00};
									EX1 = {1'b0, 5'b00000, 5'b00000, 5'b00000, {(IRout[23] ? 45'hFFFFFFFF : 45'b0), IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									EX2 = {1'b0, 5'b00000, 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
								end
								1'b1: begin // CBNZ, confirmed
									EX0 = {1'b0, IRout[4:0], 5'b11111, 5'b00000, 64'b0, 5'b01000, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00};
									EX1 = {1'b0, 5'b00000, 5'b00000, 5'b00000, {(IRout[23] ? 45'hFFFFFFFF : 45'b0), IRout[23:5]}, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b11, 1'b0, 1'b0, 2'b00};
									EX2 = {1'b0, 5'b00000, 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b0, 2'b00};
								end
							endcase
						end
						3'b110: begin
							case (IRout[22])
								1'b0: EX0 <= {1'b0, IRout[9:5], 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 1'b0, 1'b0, 2'b00}; // BR, confirmed
								1'b1: EX0 <= {1'b0, IRout[9:5], 5'b00000, 5'b00000, 64'b0, 5'b00000, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 1'b0, 1'b0, 2'b00}; // RET
							endcase
						end
					endcase
				end
			endcase
		//end
	end
	
	always @(posedge clock) begin
		if (IRout == 32'bz) begin
			EX0 <= 96'b0;
		end
		case (state)
			2'b00: begin
				controlWord <= IF;
				state <= 2'b01;
			end
			2'b01: begin
				/*if (IRout[31:24] == 8'b01010100) begin // B.cond
					{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX1;
					case (IRout[4:0])
						// V, C, N, Z
						// 3, 2, 1, 0
						5'b00000: begin // EQ, confirmed
							if (status[0] == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00001: begin // NE, confirmed
							if (status[0] == 1'b0) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00010: begin // HS, INCORRECT
							if (status[2] == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00011: begin // LO, INCORRECT
							if (status[2] == 1'b0) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00100: begin // MI, INCORRECT
							if (status[1] == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00101: begin // PL
							if (status[1] == 1'b0) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00110: begin // VS
							if (status[3] == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b00111: begin // VC
							if (status[3] == 1'b0) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01000: begin // HI
							if ((status[2] == 1'b1) & (status[0] == 1'b0)) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01001: begin // LS
							if ((status[2] == 1'b0) & (status[0] == 1'b1)) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01010: begin // GE
							if ((status[1] == 1'b1) ^ (status[3] == 1'b1) == 1'b0) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01011: begin // LT
							if ((status[1] == 1'b1) ^ (status[3] == 1'b1) == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01100: begin // GT
							if (((status[0] == 1'b0) & ~((status[1] == 1'b1) ^ (status[3] == 1'b1))) == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01101: begin // LE
							if (((status[0] == 1'b1) | ((status[1] == 1'b1) ^ (status[3] == 1'b1))) == 1'b1) begin
								{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
							end
						end
						5'b01110: begin // AL
							{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
						end
						5'b01111: begin // NV
							{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX0;
						end
						default: {write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS} <= EX1;
					endcase
				end else begin
					
				end*/
				
				controlWord <= EX0;
				if (IRout[31:23] == 9'b111100101) begin // MOVK
					state <= 2'b10;
				end else if (IRout[31:24] == 8'b10110100) begin // CBZ
					state <= 2'b10;
				end else if (IRout[31:24] == 8'b10110101) begin // CBNZ
					state <= 2'b10;
				end else if (IRout[31:26] == 6'b100101) begin // BL
					state <= 2'b10;
				end else if (IRout[31:21] == 11'b10011011000) begin // MUL
					test[998] = 1'b1;
					state <= status[0] ? 2'b00 : 2'b11;
				end else if (IRout[31:21] == 11'b11111000010) begin // LDUR
					state <= 2'b10;
				end else if (IRout[31:21] == 11'b11111000000) begin // STUR
					state <= 2'b10;
				end else if (IRout[31:21] == 11'b00111000010) begin // LDURB
					state <= 2'b10;
				end else begin
					state <= 2'b00;
				end
			end
			2'b10: begin
				if (IRout[31:24] == 8'b10110100) begin // CBZ
					if (status[0] == 1'b1) begin
						controlWord = EX1;
					end else begin
						controlWord = EX2;
					end
					state <= 2'b00;
				end else if (IRout[31:24] == 8'b10110101) begin // CBNZ
					if (status[0] == 1'b0) begin
						controlWord = EX1;
					end else begin
						controlWord = EX2;
					end
					state <= 2'b00;
				end else if (IRout[31:21] == 11'b10011011000) begin // MUL
					test[997] = 1'b1;
					controlWord = EX1;
					state <= 2'b11;
				end else if (IRout[31:21] == 11'b11111000000) begin // STUR
					controlWord = EX1;
					state <= 2'b00;
				end else begin
					controlWord = EX1;
					state <= 2'b00;
				end
			end
			2'b11: begin
				controlWord = EX2;
				if (IRout[31:21] == 11'b10011011000) begin // MUL
					test[996] = 1'b1;
					state <= status[0] ? 2'b00 : 2'b10;
				end else begin
					state <= 2'b00;
				end
			end
		endcase
	end
endmodule
//{write, AA, BA, DA, K, FS, Bselect, Cin, loadStatus, ramWrite, pcSelect, PS, loadIR, AS, DS}