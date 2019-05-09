module cpu_tb();
	wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	wire [95:0] controlWord;
	wire [31:0] address;
	reg clock;
	// for SFR testing
	wire SFRL1, SFRL2, SFRL3;
	wire [63:0]SFR1Out, SFR2Out, SFR3Out;
	wire [15:0]SFRV1O, SFRV2O;
	cpu dut(clock, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	
	
	wire [999:0] test;
	wire [63:0] dataBus;
	wire [1:0] state;
	wire [3:0] status;
	wire [63:0] pc;
	wire [95:0] IF, EX0, EX1, EX2;
	wire [63:0] mem [0:4095];
	wire [31:0] IRout;
	assign pc = dut.path.pcOut;
	assign IF = dut.cu.IF;
	assign EX0 = dut.cu.EX0;
	assign EX1 = dut.cu.EX1;
	assign EX2 = dut.cu.EX2;
	assign mem = dut.path.randomAccess.mem;
	assign IRout = dut.cu.IRout;
	assign status = dut.cu.status;
	assign state = dut.cu.state;
	assign dataBus = dut.dataBus;
	assign address = dut.path.memA;
	assign test = dut.cu.test;
	assign controlWord = dut.controlWord;
	assign SFRL1 = dut.path.SFRL1;
	assign SFR1Out = dut.path.SFR1Out;
	assign SFRL2 = dut.path.SFRL2;
	assign SFR2Out = dut.path.SFR2Out;
	assign SFRL3 = dut.path.SFRL3;
	assign SFR3Out = dut.path.SFR3Out;
	assign SFRV1O = dut.path.SFRV1O;
	assign SFRV2O = dut.path.SFRV2O;
	reg [8:0] step;
	
	initial begin
		clock = 1'b0;
		step = 9'b0;
	end
	
	always @(step) begin
		if (step > 256) begin
			$stop;
		end
	end
	
	always begin
		#5;
		clock = 1'b1;
		#10;
		clock = 1'b0;
		step = step + 1;
		#5;
	end
endmodule
