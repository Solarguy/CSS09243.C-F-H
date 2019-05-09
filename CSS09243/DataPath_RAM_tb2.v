module DataPath_RAM_tb2();
	reg clk, C_in, reset, write, B_sel, EN_B, EN_ALU, EN_RAM, ramWrite, ramOut;
	reg [1:0]PS;
	reg [4:0] FS, rdAddrA, rdAddrB, wrAddr;
	reg [63:0] K;
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
	
	always #5 clk = ~clk;
	
	
	dataPath dut(clk, reset, write, rdAddrA, rdAddrB, wrAddr, EN_B, EN_ALU, 
	K, FS, C_in, B_sel, ramWrite, ramOut, r0, r1, r2, r3, r4, r5, r6, r7, PC_sel, PS);
		
	initial begin
		ramWrite = 0;
		ramOut = 0;
		clk = 1'b0;
		reset = 1'b0;
		C_in = 1'b0;
		write = 1;
		B_sel = 1;
		EN_B = 0;
		EN_RAM = 0;
		EN_ALU = 1;
		rdAddrA = 5'b11111;
		rdAddrB = 0;
		FS = 4;
		// write 1 to reg0
		wrAddr = 0;
		K = 1;
		#10;
		//write 2 to reg 1
		wrAddr = 1;
		K = 2;
		#10;
		//write to RAM location 1 with data 2
		EN_B = 1;
		EN_ALU = 0;
		EN_RAM = 1;
		B_sel = 1;
		ramWrite = 1;
		rdAddrA = 0;
		rdAddrB =1;
		#10;
		#10;
		#10;
		
//		//write to RAM location 2 with data 1
//		EN_B = 1;
//		EN_ALU = 0;
//		EN_RAM = 1;
//		B_sel = 1;
//		ramWrite = 1;
//		rdAddrA = 0;
//		rdAddrB =2;
//		#10;
		
		//read from RAM location 1 and write to register 2
		ramWrite = 0;
		ramOut = 1;
		wrAddr = 2;
		
		#10;
		#10;
		#10;
		//read from RAM 1 and write to register 3
		ramWrite = 0;
		ramOut = 1;
		wrAddr = 7;
		#50;
		$stop;
	end
	
endmodule
		
		
		
		