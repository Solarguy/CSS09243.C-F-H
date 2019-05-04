module DataPath_tb();
reg clk, reset, write;
reg [4:0] rdAddrA, rdAddrB, wrAddr;
reg C_in;
reg [4:0] FS;
reg [63:0] K;
reg EN_B, EN_ALU, B_sel, RAM_EN, ramWrite, ramOut;
reg count;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, 
r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18,
r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30;

DataPath dut(clk, reset, write, rdAddrA, rdAddrB, wrAddr, EN_B, EN_ALU, 
K, FS, C_in, B_sel, RAM_EN, ramWrite, ramOut, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12,
r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30);

initial begin
 RAM_EN = 0;
 ramWrite = 0;
 ramOut = 0;
 count = 1'b1;
 clk = 1'b0;
 C_in = 0;
 reset = 0;
 write = 1;
 FS = 5'b01000;
 K = 64'b0;
 EN_B = 1'b0;
 B_sel = 1'b1;
 EN_ALU = 1'b1;
 rdAddrA = 5'b11111;
 rdAddrB = 5'b0;
 wrAddr = 1'b0;
  #320
  FS = 5'b11100;
  count = 1'b0;
  B_sel = 1'b0;
  wrAddr = 1'b0;
  #200
  EN_ALU = 0;
  EN_B = 1;
  rdAddrB = 5'b00011;
  #100
 $stop;
end

//first stage, AK ops
always 
	begin
	#5
	clk = ~clk;
	end
//
//		always begin
//		#10
//			wrAddr = wrAddr + 5'b1;
//			K = K + 64'b1;
//		 end
//		 
always begin
	#10
	begin
		if(count == 1'b1)
		begin
			wrAddr = wrAddr + 5'b1;
			K = K + 64'b1;
		end
		else if(count == 1'b0)
		begin
			rdAddrA = 2;
			rdAddrB = 3;
			FS = FS + 5'b100;
			wrAddr = wrAddr + 5'b1;
		end
	end
end
//	always begin
//			rdAddrA = 1;
//			rdAddrB = 2;
//			FS = FS + 1;
//	end
	
	
endmodule


 
 
 

