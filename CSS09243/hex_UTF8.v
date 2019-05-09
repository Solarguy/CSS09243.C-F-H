module hex_UTF8(in, out); //input from SFR converted to hex UTF8 for display
	input [63:0]in;
	output reg [15:0]out;
//128 bits per row on 2x16 display
//data = 128'b constant character concatination of output of 16 registers
//data = 128'b 2 # changing, 5 blank (20), 1 bar (7C), 1 blank, 2 changing #, 5 blank (20) 

	always @* 
			case(in)
				0: out = 16'h2030; //_0
				1: out = 16'h2031; //_1
				2: out = 16'h2032; //_2
				3: out = 16'h2033; //_3
				4: out = 16'h2034; //_4
				5: out <= 16'h2035; //_5
				6: out <= 16'h2036; //_6
				7: out <= 16'h2037; //_7
				8: out <= 16'h2038; //_8
				9: out <= 16'h2039; //_9
					10: out <= 16'h3130; //10
					11: out <= 16'h3131; //11
					12: out <= 16'h3132; //12
					13: out <= 16'h3133; //13
					14: out <= 16'h3134; //14
					15: out <= 16'h3135; //15
					16: out <= 16'h3136; //16
					17: out <= 16'h3137; //17
					18: out <= 16'h3138; //18
					19: out <= 16'h3139; //19
						20: out <= 16'h3230; //20
						21: out <= 16'h3231; //21
						22: out <= 16'h3232; //22
						23: out <= 16'h3233; //23
						24: out <= 16'h3234; //24
						25: out <= 16'h3235; //25
						26: out <= 16'h3236; //26
						27: out <= 16'h3237; //27
						28: out <= 16'h3238; //28
						29: out <= 16'h3239; //29
							30: out <= 16'h3330; 
							31: out <= 16'h3331;
							32: out <= 16'h3332;
							33: out <= 16'h3333;
							34: out <= 16'h3334;
							35: out <= 16'h3335;
							36: out <= 16'h3336;
							37: out <= 16'h3337;
							38: out <= 16'h3338;
							39: out <= 16'h3339;
								40: out <= 16'h3430;
								41: out <= 16'h3431;
								42: out <= 16'h3432;
								43: out <= 16'h3433;
								44: out <= 16'h3434;
								45: out <= 16'h3435;
								46: out <= 16'h3436;
								47: out <= 16'h3437;
								48: out <= 16'h3438;
								49: out <= 16'h3439;
									50: out <= 16'h3530;
									51: out <= 16'h3531;
									52: out <= 16'h3532;
									53: out <= 16'h3533;
									54: out <= 16'h3534;
									55: out <= 16'h3535;
									56: out <= 16'h3536;
									57: out <= 16'h3537;
									58: out <= 16'h3538;
									59: out <= 16'h3539;
										60: out <= 16'h3630;
										61: out <= 16'h3631;
										62: out <= 16'h3632;
										63: out <= 16'h3633;
										64: out <= 16'h3634;
										65: out <= 16'h3635;
										66: out <= 16'h3636;
										67: out <= 16'h3637;
										68: out <= 16'h3638;
										69: out <= 16'h3639;
											70: out <= 16'h3730;
											71: out <= 16'h3731;
											72: out <= 16'h3732;
											73: out <= 16'h3733;
											74: out <= 16'h3734;
											75: out <= 16'h3735;
											76: out <= 16'h3736;
											77: out <= 16'h3737;
											78: out <= 16'h3738;
											79: out <= 16'h3739;
												80: out <= 16'h3830;
												81: out <= 16'h3831;
												82: out <= 16'h3832;
												83: out <= 16'h3833;
												84: out <= 16'h3834;
												85: out <= 16'h3835;
												86: out <= 16'h3836;
												87: out <= 16'h3837;
												88: out <= 16'h3838;
												89: out <= 16'h3839;
													90: out <= 16'h3930;
													91: out <= 16'h3931;
													92: out <= 16'h3932;
													93: out <= 16'h3933;
													94: out <= 16'h3934;
													95: out <= 16'h3935;
													96: out <= 16'h3936;
													97: out <= 16'h3937;
													98: out <= 16'h3938;
													99: out <= 16'h3939;			
			endcase	

endmodule


/*
module hexto7segment(
    input  [3:0]x,
    output reg [6:0]z
    );
always @*
case (x)
4'b0000 :      	//Hexadecimal 0
z = 7'b1111110;
4'b0001 :    		//Hexadecimal 1
z = 7'b0110000  ;
4'b0010 :  		// Hexadecimal 2
z = 7'b1101101 ; 
4'b0011 : 		// Hexadecimal 3
z = 7'b1111001 ;
4'b0100 :		// Hexadecimal 4
z = 7'b0110011 ;
4'b0101 :		// Hexadecimal 5
z = 7'b1011011 ;  
4'b0110 :		// Hexadecimal 6
z = 7'b1011111 ;
4'b0111 :		// Hexadecimal 7
z = 7'b1110000;
4'b1000 :     		 //Hexadecimal 8
z = 7'b1111111;
4'b1001 :    		//Hexadecimal 9
z = 7'b1111011 ;
4'b1010 :  		// Hexadecimal A
z = 7'b1110111 ; 
4'b1011 : 		// Hexadecimal B
z = 7'b0011111;
4'b1100 :		// Hexadecimal C
z = 7'b1001110 ;
4'b1101 :		// Hexadecimal D
z = 7'b0111101 ;
4'b1110 :		// Hexadecimal E
z = 7'b1001111 ;
4'b1111 :		// Hexadecimal F
z = 7'b1000111 ;
endcase
 
endmodule

*/