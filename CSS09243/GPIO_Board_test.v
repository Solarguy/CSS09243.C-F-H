module GPIO_Board_test(CLOCK_50, GPIO0_D, GPIO1_D);
	input CLOCK_50;
	output [31:0] GPIO0_D;
	inout [31:0] GPIO1_D;
	
	wire [31:0] sw_led;
	
	// create a 32-bit counter instance
	wire [31:0]count;
	count_32bit counter1(CLOCK_50, count);
	
	wire GPIO_clock;
	assign GPIO_clock = CLOCK_50;
	
	
	// use a subset of the 32-bit counter to generate data to be displayed
	// on the matrix display
	wire [15:0]R0, R1, R2, R3, R4, R5, R6, R7;
	assign R0 = {count[31:24], count[31:24]};
	assign R1 = {count[31:28], count[31:28], count[31:28], count[31:28]};
	assign R2 = {count[27:24], count[27:24], count[27:24], count[27:24]};
	assign R3 = {count[27:24], count[31:28], count[27:24], count[31:28]};
	assign R4 = ~R3;
	assign R5 = ~R2;
	assign R6 = ~R1;
	assign R7 = ~R0;
	
	// alternate between even and odd decimal points being on based on count[27]
	wire HEX0_DP, HEX1_DP, HEX2_DP, HEX3_DP, HEX4_DP, HEX5_DP, HEX6_DP, HEX7_DP;
	assign HEX0_DP = count[27];
	assign HEX1_DP = ~count[27];
	assign HEX2_DP = count[27];
	assign HEX3_DP = ~count[27];
	assign HEX4_DP = count[27];
	assign HEX5_DP = ~count[27];
	assign HEX6_DP = count[27];
	assign HEX7_DP = ~count[27];
	
	// count through the hex display segments but offset them by 1 from the previous
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	wire [2:0] HEX_seg_count;
	assign HEX_seg_count = count[28:26];
	gpio_decoder_3_8 d0(HEX_seg_count,HEX0[0],HEX0[1],HEX0[2],HEX0[3],HEX0[4],HEX0[5],HEX0[6]);
	gpio_decoder_3_8 d1(HEX_seg_count,HEX1[1],HEX1[2],HEX1[3],HEX1[4],HEX1[5],HEX1[6],HEX1[0]);
	gpio_decoder_3_8 d2(HEX_seg_count,HEX2[2],HEX2[3],HEX2[4],HEX2[5],HEX2[6],HEX2[0],HEX2[1]);
	gpio_decoder_3_8 d3(HEX_seg_count,HEX3[3],HEX3[4],HEX3[5],HEX3[6],HEX3[0],HEX3[1],HEX3[2]);
	gpio_decoder_3_8 d4(HEX_seg_count,HEX4[4],HEX4[5],HEX4[6],HEX4[0],HEX4[1],HEX4[2],HEX4[3]);
	gpio_decoder_3_8 d5(HEX_seg_count,HEX5[5],HEX5[6],HEX5[0],HEX5[1],HEX5[2],HEX5[3],HEX5[4]);
	gpio_decoder_3_8 d6(HEX_seg_count,HEX6[6],HEX6[0],HEX6[1],HEX6[2],HEX6[3],HEX6[4],HEX6[5]);
	gpio_decoder_3_8 d7(HEX_seg_count,HEX7[0],HEX7[1],HEX7[2],HEX7[3],HEX7[4],HEX7[5],HEX7[6]);
	
	wire [31:0]sw, led;
	// connect the last 16 switches to the first 16 LEDs
	// connect the first 16 switches to the last 16 LEDs
	// this is done to make sure the switches can be read and the LEDs
	// controlled
	assign led[15:0] = sw[31:16];
	assign led[31:16] = sw[15:0];
	

	GPIO_Board DUT(
	GPIO_clock,
	R0, R1, R2, R3, R4, R5, R6, R7, 
	HEX0, HEX0_DP, HEX1, HEX1_DP, 
	HEX2, HEX2_DP, HEX3, HEX3_DP, 
	HEX4, HEX4_DP, HEX5, HEX5_DP, 
	HEX6, HEX6_DP, HEX7, HEX7_DP, sw, led, GPIO0_D, GPIO1_D);
	
endmodule
	
	
module count_32bit(clock, out);
	input clock;
	output reg [31:0]out;
	
	always @(posedge clock)
		out <= out + 1'b1;
		
endmodule
