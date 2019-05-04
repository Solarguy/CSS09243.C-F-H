module control_unit_tb();
	wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	wire [95:0] controlWord;
	reg clock;
	
	control_unit dut(clock, r0, r1, r2, r3, r4, r5, r6, r7,  r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, controlWord);
	
	wire [1:0] state;
	wire [3:0] status;
	wire [63:0] pc;
	wire [95:0] IF, EX0, EX1, EX2;
	wire [63:0] mem[0:4095];
	wire [31:0] IRout;
	wire [63:0]dataBus;
	
	assign pc = dut.path.pcOut;
	assign IF = dut.IF;
	assign EX0 = dut.EX0;
	assign EX1 = dut.EX1;
	assign EX2 = dut.EX2;
	assign mem = dut.path.randomAccess.mem;
	assign IRout = dut.IRout;
	assign status = dut.status;
	assign state = dut.state;
	assign dataBus = dut.path.dataBus;
	
	initial begin
		clock = 1'b0;
	end
	
	always begin
		#5;
		clock = 1'b1;
		#10;
		clock = 1'b0;
		#5;
	end
endmodule
