module programcounter_tb(); //test bench works for PC but cant read IR output.

	reg clk, reset, write, C_in, B_sel, ramWrite, PC_sel, IR_load;
	reg [4:0] rdAddrA, rdAddrB, wrAddr, FS;
	reg [63:0] K;
	reg [1:0]PS;
	reg AS;
	reg [1:0]DS;
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
	wire [31:0]IR_out;
	always #5 clk = ~clk;
	
	wire [63:0] PC_output;
	wire [63:0] DataBus;
	
	DataPath dut(clk, reset, write, rdAddrA, rdAddrB, wrAddr, K, FS, C_in, B_sel, ramWrite, PC_sel, PS, IR_load, AS, DS, r0, r1, r2, r3, r4, r5, r6, r7, IR_out, DataBus, PC_output);

	wire [63:0]PC;
	assign PC = dut.PC1.PC;
	
	initial begin
		clk = 1'b0;
		reset = 1'b1;
		#40
		
	// PS
// 00 - PC <= PC
// 01 - PC <= PC+4
// 10 - PC <= in
// 11 - PC <= PC+4+in*4

	//write 4 to internal register of PC
		reset = 1'b0;
		C_in =  1'b0;
		write = 1'b0;
		B_sel = 1'b1;
		ramWrite = 1'b0;
		PC_sel = 1'b1;
		AS = 1'b0;
		IR_load = 1'b1;
		FS = 5'b01000;
		rdAddrA = 5'b00000;
		rdAddrB = 5'b00000;
 		wrAddr = 5'b00001;
		
		//PC <= in
		PS = 2'b10;
		K = 64'b100;
		DS = 2'b10; //EN_PC is now 1, passing output of tribuff onto databus and to the IR, IR_load is on...
		
		#40 //PC <= PC + 4
		
		PS = 2'b01;
		
		#40 //PC <= PC+4+in*4
		
		PS = 2'b11;
		
		#40 //PC <= PC
		
		PS = 2'b00;
		
		#40
		
		//write to instruction register

		$stop;
	end
	
	always begin 
	#5
	clk = ~clk;
	#5;
	end
	
	endmodule
		
		//write value of 4 into register 4
	
		
		