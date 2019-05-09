//module registerfile_tb();
//	// create registers for holding the simulated input values to the DUT
//	reg [4:0]rdAddrA, rdAddrB, wrAddr;
//	reg [63:0]wrData;
//	reg write, reset, clk;
//	// create wires for the output of the DUT
//	wire [63:0]rdDataA, rdDataB;
//	
//	registerfile dut(.write(write), .clk(clk), .wrAddr(wrAddr), .wrData(wrData),
//							.rdAddrA(rdAddrA), .rdAddrB(rdAddrB), .rdDataA(rdDataA),
//							.rdDataB(rdDataB));
// 
//	// give all inputs initial values
//	initial begin
//		clk <= 1'b1;
//		reset <= 1'b0;
//		wrData <= 64'b0;
//		write <= 1'b1;
//		wrAddr <= 5'd31; // write to register 0 first since D will be incremented before first clock
//		rdAddrA <= 5'd30; // read from register 31 first on A bus
//		rdAddrB <= 5'd29; // read from register 30 first on B bus
//		#5 reset <= 1'b1; // delay 5 ticks then turn reset off
//		#320 write <= 1'b0; // delay 320 ticks then turn write off
//		#320 $stop; // delay another 320 ticks then stop the simulation
//	end
//	
//	// simulate clock with period of 10 ticks
//	always
//		#5 clk <= ~clk;
//		
//	// every 10 ticks generate random data and increment SA, SB, and DA
//	always begin
//		#5 wrData <= 64'b0; //{$random, $random}; // $random is a system command that generates a 32 random number
//		wrAddr <= wrAddr + 5'b1;
//		rdAddrA <= rdAddrA + 5'b1;
//		rdAddrB <= rdAddrB + 5'b1;
//		#5 ;
//	end
//	
//	// create wires for each register in the dut then connect them accordingly so they
//	// show up on the wave view in ModelSim automatically
//	wire [63:0]R00, R01, R02, R03, R04, R05, R06, R07, R08, R09;
//	wire [63:0]R10, R11, R12, R13, R14, R15, R16, R17, R18, R19;
//	wire [63:0]R20, R21, R22, R23, R24, R25, R26, R27, R28, R29;
//	wire [63:0]R30, R31;
//	
//	assign R00 = dut.Q0;
//	assign R01 = dut.Q1;
//	assign R02 = dut.Q2;
//	assign R03 = dut.Q3;
//	assign R04 = dut.Q4;
//	assign R05 = dut.Q5;
//	assign R06 = dut.Q6;
//	assign R07 = dut.Q7;
//	assign R08 = dut.Q8;
//	assign R09 = dut.Q9;
//	assign R10 = dut.Q10;
//	assign R11 = dut.Q11;
//	assign R12 = dut.Q12;
//	assign R13 = dut.Q13;
//	assign R14 = dut.Q14;
//	assign R15 = dut.Q15;
//	assign R16 = dut.Q16;
//	assign R17 = dut.Q17;
//	assign R18 = dut.Q18;
//	assign R19 = dut.Q19;
//	assign R20 = dut.Q20;
//	assign R21 = dut.Q21;
//	assign R22 = dut.Q22;
//	assign R23 = dut.Q23;
//	assign R24 = dut.Q24;
//	assign R25 = dut.Q25;
//	assign R26 = dut.Q26;
//	assign R27 = dut.Q27;
//	assign R28 = dut.Q28;
//	assign R29 = dut.Q29;
//	assign R30 = dut.Q30;
//	assign R31 = dut.Q31;
//	
//endmodule
//
//





module registerfile_tb();
//inputs
reg clk;
reg write;
reg [4:0] wrAddr;
reg [63:0] wrData;
reg [4:0] rdAddrA;
reg [4:0] rdAddrB;
wire reset = 0;
//outputs
wire [63:0] rdDataA;
wire [63:0] rdDataB;

registerfile uut(.write(write), .clk(clk), .wrAddr(wrAddr), .wrData(wrData),
 .rdAddrA(rdAddrA), .rdAddrB(rdAddrB), .rdDataA(rdDataA),
 .rdDataB(rdDataB));
 
 
 initial clk = 0;
 always #10 clk = ~clk;
 initial begin
 
 write = 1'b1;
 wrAddr = 5'b00000;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000000001;
 
 #100;
 
 write = 1'b1;
 wrAddr = 5'b00001;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000000010;

 #100; 
 
 write = 1'b1;
 wrAddr = 5'b00010;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000000100;

 #100;
 
 write = 1'b1;
 wrAddr = 5'b00011;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000001000;

 #100;
 
 write = 1'b1;
 wrAddr = 5'b00100;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000010000;
 
 #100;
 
 write = 1'b1;
 wrAddr = 5'b00101;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000100000; //writes in order up until fifth register R4
 
 #100;      //loads the last register R31
 
 write = 1'b1;
 wrAddr = 5'b11111;
 wrData = 64'b0000000000000000000000000000000000000000000000000000000000000001;
 
 #100; 
 
 write = 1'b0;
 wrAddr = 5'b00000;
 wrData = 64'b0;
 rdAddrA = 5'b00000;
 rdAddrB = 5'b00001;
 
 #100;
 
 rdAddrA = 5'b00010;
 rdAddrB = 5'b00011;
 
 #100;
 
 rdAddrA = 5'b00100;
 rdAddrB = 5'b00101;
 
 #100;
 
 rdAddrA = 5'b00101;
 rdAddrB = 5'b11111;
 
 write = 1'b1; //rewrites first register
 wrAddr = 5'b00000;
 wrData = 64'b1111111111111111111111111111111111111111111111111111111111111111;
 
 #100;
 
 rdAddrA = 5'b00000;
 rdAddrB = 5'b11111;
 
 #100;
 
 $stop;
 
 
end
endmodule 





