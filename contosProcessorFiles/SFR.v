module SFRDecoder(clock, ramWrite, address, SFRL1, SFRL2, SFRL3, SFRL4, SFRL5, SFRL6, SFRL7, SFRL8, SFRL9, SFRL10, SFRL11, SFRL12, SFRL13, SFRL14);
input clock;
input ramWrite;
input [31:0]address;
output reg SFRL1, SFRL2, SFRL3, SFRL4, SFRL5, SFRL6, SFRL7, SFRL8, SFRL9, SFRL10, SFRL11, SFRL12, SFRL13, SFRL14; 

initial begin
	SFRL1 = 0;
	SFRL2 = 0;
	SFRL3 = 0;
	SFRL4 = 0;
	SFRL5 = 0;
	SFRL6 = 0;
	SFRL7 = 0;
	SFRL8 = 0;
	SFRL9 = 0;
	SFRL10 = 0;
	SFRL11 = 0;
	SFRL12 = 0;
	SFRL13 = 0;
	SFRL14 = 0;
end

always @(posedge clock) begin
if (address[19:0] == 20'b0) begin
			case (address[31:20])
		12'b000000000001: 
			begin
				SFRL1 = ramWrite;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b000000000010:
			begin 
				SFRL1 = 0;
				SFRL2 = ramWrite;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			
			end
		12'b000000000011:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = ramWrite;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b000000000100:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = ramWrite;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b000000000101:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = ramWrite;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b000000000110:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = ramWrite;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b000000000111:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = ramWrite;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
				
			end
		12'b000000001000:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = ramWrite;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
				
			end
		12'b000000001001:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = ramWrite;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
				
			end
		12'b000000001010:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = ramWrite;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b00000001011:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = ramWrite;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = 0;
				
			end
		12'b00000001100:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = ramWrite;
				SFRL13 = 0;
				SFRL14 = 0;
			end
		12'b00000001101:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = ramWrite;
				SFRL14 = 0;
			end
		12'b00000001110:
			begin 
				SFRL1 = 0;
				SFRL2 = 0;
				SFRL3 = 0;
				SFRL4 = 0;
				SFRL5 = 0;
				SFRL6 = 0;
				SFRL7 = 0;
				SFRL8 = 0;
				SFRL9 = 0;
				SFRL10 = 0;
				SFRL11 = 0;
				SFRL12 = 0;
				SFRL13 = 0;
				SFRL14 = ramWrite;
			end
		default:
			begin
			SFRL1 = 0;
			SFRL2 = 0;
			SFRL3 = 0;
			SFRL4 = 0;
			SFRL5 = 0;
			SFRL6 = 0;
			SFRL7 = 0;
			SFRL8 = 0;
			SFRL9 = 0;
			SFRL10 = 0;
			SFRL11 = 0;
			SFRL12 = 0;
			SFRL13 = 0;
			SFRL14 = 0;
			end
		
		endcase
	end
end
endmodule

//SFR1 Load connected to SFRL1 from decoder

module SFR(load, clock, reset, in, out);
	parameter n = 64;
	input load, clock, reset;
	input [n-1:0] in;
	output reg [n-1:0] out;

	always @(negedge clock or negedge reset) begin
		if (~reset)
			out <= {n{1'b0}};
		else if(load)
			out <= in;
	end
endmodule



