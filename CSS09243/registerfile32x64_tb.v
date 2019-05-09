module RegisterFile32x64_Testbench();
	// create registers for holding the simulated input values to the DUT
	reg [4:0]rdAddrA, rdAddrB, wrAddr;
	reg [63:0]wrData;
	reg write, reset, clk;
	// create wires for the output of the DUT
	wire [63:0]rdDataA, rdDataB;
	
	registerfile dut(rdDataA, rdDataB, rdAddrA, rdAddrB, wrData, wrAddr, write, reset, clk);
	
	// give all inputs initial values
	initial begin
		clk <= 1'b1;
		reset <= 1'b1;
		wrData <= 64'b0;
		write <= 1'b1;
		wrAddr <= 5'd31; // write to register 0 first since D will be incremented before first clock
		rdAddrA <= 5'd30; // read from register 31 first on A bus
		rdAddrB <= 5'd29; // read from register 30 first on B bus
		#5 reset <= 1'b0; // delay 5 ticks then turn reset off
		#320 write <= 1'b0; // delay 320 ticks then turn write off
		#320 $stop; // delay another 320 ticks then stop the simulation
	end
	
	// simulate clock with period of 10 ticks
	always
		#5 clk <= ~clk;
		
	// every 10 ticks generate random data and increment SA, SB, and DA
	always begin
		#5 wrData <= {$random, $random}; // $random is a system command that generates a 32 random number
		wrAddr <= wrAddr + 5'b1;
		rdAddrA <= rdAddrA + 5'b1;
		rdAddrB <= rdAddrB + 5'b1;
		#5 ;
	end
	
	// create wires for each register in the dut then connect them accordingly so they
	// show up on the wave view in ModelSim automatically
	wire [63:0]R00, R01, R02, R03, R04, R05, R06, R07, R08, R09;
	wire [63:0]R10, R11, R12, R13, R14, R15, R16, R17, R18, R19;
	wire [63:0]R20, R21, R22, R23, R24, R25, R26, R27, R28, R29;
	wire [63:0]R30, R31;
	
	assign R00 = dut.R00;
	assign R01 = dut.R01;
	assign R02 = dut.R02;
	assign R03 = dut.R03;
	assign R04 = dut.R04;
	assign R05 = dut.R05;
	assign R06 = dut.R06;
	assign R07 = dut.R07;
	assign R08 = dut.R08;
	assign R09 = dut.R09;
	assign R10 = dut.R10;
	assign R11 = dut.R11;
	assign R12 = dut.R12;
	assign R13 = dut.R1;
	assign R14 = dut.R14;
	assign R15 = dut.R15;
	assign R16 = dut.R16;
	assign R17 = dut.R17;
	assign R18 = dut.R18;
	assign R19 = dut.R19;
	assign R20 = dut.R20;
	assign R21 = dut.R21;
	assign R22 = dut.R22;
	assign R23 = dut.R23;
	assign R24 = dut.R24;
	assign R25 = dut.R25;
	assign R26 = dut.R26;
	assign R27 = dut.R27;
	assign R28 = dut.R28;
	assign R29 = dut.R29;
	assign R30 = dut.R30;
	assign R31 = dut.R31;
	
endmodule
