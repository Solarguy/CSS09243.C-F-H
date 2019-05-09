module cpu(CLOCK_50, GPIO0_D, GPIO1_D, LCD_RS, LCD_RW, LCD_EN, LCD_DATA);
//for DE0
	input CLOCK_50;
	output [31:0] GPIO0_D;
	inout [31:0] GPIO1_D;
//for LCD
	output LCD_RS, LCD_RW, LCD_EN;
	output [7:0]LCD_DATA;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	
	wire [95:0] controlWord;
	wire [31:0] IRout;
	wire [3:0] status;
	wire [63:0] dataBus;
	wire reset;
	
	control_unit cu(pllOut, controlWord, status, IRout);
	datapath path(SFR1Out, SFR2Out, SFR3Out, SFR4Out, SFR5Out, SFR6Out, SFR7Out, SFR8Out, SFR9Out, SFR10Out, SFR11Out, SFR12Out, SFRV1O, SFRV2O, reset, pllOut, controlWord, status, IRout, dataBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);

	
	//LCD DISPLAY
	wire [63:0]SFR1Out, SFR2Out, SFR3Out, SFR4Out, SFR5Out, SFR6Out, SFR7Out, SFR8Out, SFR9Out, SFR10Out, SFR11Out, SFR12Out;
	wire [15:0] SFRV1O, SFRV2O;
	
	wire [127:0] line1 = {SFR1Out[7:0], SFR2Out[7:0], SFR3Out[7:0], SFR4Out[7:0], SFR5Out[7:0], SFR3Out[7:0], SFR6Out[7:0], SFR7Out[7:0], SFR6Out[7:0], SFR8Out[7:0], SFR3Out[7:0], SFR9Out[7:0], SFR10Out[7:0], SFR11Out[7:0], SFR12Out[7:0], SFR9Out[7:0]};							//637572736f72207c206772616e646d61;
	wire [127:0] line2 = {SFRV1O[15:0], SFR6Out[7:0], SFR6Out[7:0], SFR6Out[7:0], SFR6Out[7:0], SFR6Out[7:0], SFR7Out[7:0], SFR6Out[7:0], SFRV2O[15:0],  SFR6Out[7:0],  SFR6Out[7:0],  SFR6Out[7:0],  SFR6Out[7:0],  SFR6Out[7:0]};
	
	lcd_controller lcd(.clk(CLOCK_50), .reset_n(1),.rw(LCD_RW), .rs(LCD_RS), .e(LCD_EN),  .lcd_data(LCD_DATA),.line1_buffer(line1),.line2_buffer(line2));
	
	
	
wire pllOut;
pll instclk(CLOCK_50, pllOut);

	//CLOCKWORK AND DE0
	//wire clock;
//clockDivider cpuclock(CLOCK_50, clock);
	
	wire HEX0_DP, HEX1_DP, HEX2_DP, HEX3_DP, HEX4_DP, HEX5_DP, HEX6_DP, HEX7_DP;
	assign HEX0_DP = 0;
	assign HEX1_DP = 0;
	assign HEX2_DP = 0;
	assign HEX3_DP = 0;
	assign HEX4_DP = 0;
	assign HEX5_DP = 0;
	assign HEX6_DP = 0;
	assign HEX7_DP = 0;
	
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	assign HEX0 = 0;
	assign HEX1 = 0;
	assign HEX2 = 0;
	assign HEX3 = 0;
	assign HEX4 = 0;
	assign HEX5 = 0;
	assign HEX6 = 0;
	assign HEX7 = 0;
	
	wire [31:0]sw, led;
	assign led[0] = CLOCK_50;
	assign led[1] = ~reset;
	// connect the last 16 switches to the first 16 LEDs
	// connect the first 16 switches to the last 16 LEDs
	// this is done to make sure the switches can be read and the LEDs
	// controlled
	
	GPIO_Board DUT(
	CLOCK_50,
	r0, r1, r2, r3, r4, r5, r6, r7, 
	HEX0, HEX0_DP, HEX1, HEX1_DP, 
	HEX2, HEX2_DP, HEX3, HEX3_DP, 
	HEX4, HEX4_DP, HEX5, HEX5_DP, 
	HEX6, HEX6_DP, HEX7, HEX7_DP, sw, led, GPIO0_D, GPIO1_D);
	
	endmodule

	
module clockDivider (clk_in, clk_out);
	input clk_in;

	output reg clk_out;
	
	reg [23:0]count;
	
	always @(posedge clk_in) begin
		count <= count+1; 
		if(count >= 500000) begin
		count <= 0; 
	end	
	clk_out = (count > 250000) ? 1'b1 : 1'b0;
	end

endmodule


//Testbench-capable

/*
module cpu(clock, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);
	input clock;
	wire reset;
	
	output [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	wire [95:0] controlWord;
	wire [31:0] IRout;
	wire [3:0] status;
	wire [63:0] dataBus;
	
	control_unit cu(clock, controlWord, status, IRout);
	datapath path(SFR1Out, SFR2Out, SFR3Out, SFR4Out, SFR5Out, SFR6Out, SFR7Out, SFR8Out, SFR9Out, SFR10Out, SFR11Out, SFR12Out, SFRV1O, SFRV2O, reset, clock, controlWord, status, IRout, dataBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31);

endmodule

*/