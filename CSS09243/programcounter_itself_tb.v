module programcounter_itself_tb();
wire [63:0]PC;
wire[63:0]in;
reg [1:0]PS;
reg clock, reset;

programcounter dut(PC, in, PS, clock, reset); 

assign in = 64'b100;

initial begin 
	// PS
// 00 - PC <= PC
// 01 - PC <= PC+4
// 10 - PC <= in
// 11 - PC <= PC+4+in*4
reset = 1'b1;
clock = 0;

#20

reset = 1'b0;
PS = 2'b10; //PC <= in

#20

PS = 2'b01;

#20

PS = 2'b11;

#20

PS = 2'b00;

#20

$stop;

end

	always begin 
	#10
	clock = ~clock;
	end
	
endmodule
