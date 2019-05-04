module DataPath_RAM_tb();
reg clk, reset, write;
reg [4:0] rdAddrA, rdAddrB, wrAddr;
reg C_in;
reg [4:0] FS;
reg [63:0] K;
reg EN_B, EN_ALU, B_sel, EN_RAM, ramWrite, ramOut;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, 
r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18,
r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30;

DataPath dut(clk, reset, write, rdAddrA, rdAddrB, wrAddr, EN_B, EN_ALU, 
K, FS, C_in, B_sel, EN_RAM, ramWrite, ramOut, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12,
r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30);

initial begin

clk = 1'b0;
reset = 1'b0;
write = 1'b0;
rdAddrA = 5'b00000;
rdAddrB = 5'b00000;
wrAddr = 5'b00000;
FS = 5'b00000;
K = 64'b0;
EN_B = 1'b0;
EN_ALU = 1'b0;
B_sel = 1'b0;
EN_RAM = 1'b0;
ramWrite = 1'b0;
ramOut = 1'b0;

//write 4 to register 1 (SA to select address, Reg 2 to data)
write = 1'b1;
rdAddrA = 5'b00000;
rdAddrB = 5'b00000;
wrAddr = 5'b00001;
C_in = 1'b0;
FS = 5'b01000;
K = 64'b100;
EN_B = 1'b0;
EN_ALU = 1'b1;
B_sel =1'b1;
EN_RAM = 1'b0;
ramWrite = 1'b0;
ramOut = 1'b0;

 #20
//write 2 to register 2
write = 1'b1;
rdAddrA = 5'b00000;
rdAddrB = 5'b00000;
wrAddr = 5'b00010;
C_in = 1'b0;
FS = 5'b01000;
K = 64'b10;
EN_B = 1'b0;
EN_ALU = 1'b1;
B_sel =1'b1;
EN_RAM = 1'b0;
ramWrite = 1'b0;
ramOut = 1'b0;
 
//write to RAM location 4 with data 2
write = 1'b0;
rdAddrA = 5'b00001;
rdAddrB = 5'b00010;
wrAddr = 5'b00000;
C_in = 1'b0;
FS = 5'b01000;
K = 64'b0;
EN_B = 1'b1;
EN_ALU = 1'b0;
B_sel = 1'b1;
EN_RAM = 1'b1;
ramWrite = 1'b1;
ramOut = 1'b0;
#20

//read from RAM location 4 into register 3
write = 1'b1;
rdAddrA = 5'b00001;
rdAddrB = 5'b00000;
wrAddr = 5'b00011;
C_in = 1'b0;
FS = 1'b00000;
K = 64'b0;
EN_B = 1'b0;
EN_ALU = 1'b0;
B_sel = 1'b1;
EN_RAM = 1'b1;
ramWrite = 1'b0;
ramOut = 1'b1;
#20
$stop;
end

always 
	begin
	#5
	clk = ~clk;
	end
endmodule