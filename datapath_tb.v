module datapath_tb();
	reg clock, cin, reset, write, Bselect, EN_B, EN_ALU;
	reg [4:0] FS, AA, BA, DA;
	reg [63:0] K;
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	
	datapath path(clock, cin, Bselect, reset, write, EN_B, EN_ALU, FS, K, AA, BA, DA, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	
	initial begin
		clock = 1'b0;
		cin = 1'b0;
		reset = 1'b1;
		write = 1'b1;
		Bselect = 1'b1;
		EN_B = 1'b0;
		EN_ALU = 1'b1;
		FS = 5'b01000;
		AA = 5'b11111;
		BA = 5'b0;
		DA = 5'b0;
		K = 64'b0;
		#420;
		$stop;
	end
	
	always begin
		#10;
		clock = ~clock;
		#10;
		clock = ~clock;
		#10;
		DA = DA + 5'b1;
		K = K + 64'b1;
	end
endmodule
