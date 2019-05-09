module ALU_LEGv8_Testbench();
	reg [63:0] A, B;
	reg [4:0] FS;
	reg C0;
	wire [63:0] F;
	wire [3:0] status;
	
	ALU_LEGv8 dut (A, B, FS, C0, F, status);
	
	integer errors;
	
	initial begin
		errors <= 0;
		FS <= 5'b00000; // A AND B
		/*
		A <= 64'b110;
		B <= 64'b011;
		#5 
		FS <= 5'b00100; // A OR B
		#5 
		FS <= 5'b01000; // A + B
		C0 <= 1'b0;
		#5 FS <= 5'b01100; // A XOR B
		#5 A <= {$random, $random};
		B <= {$random, $random};
		#5 FS <= 5'b00011; // ~A AND ~B = A NOR B
		#5 FS <= 5'b00111; // ~A OR ~B = A NAND B
		#5 FS <= 5'b10000; // shift left
		A <= 64'b1; // shift 1 a random number of times
		#5 FS <= 5'b10100; // shift right
		A <= 64'h8000000000000000;*/
		#320 $display("total errors: %d", errors);
		$stop;
	end
	
	// every 5 ticks select a random operation with random operands
	always begin
		#10
		FS <= FS + 1;
		A <= 64'b11;
		B <= 64'b10;
		C0 <= 1'b0;
	end
	
	// implement the ALU a second time in behavior verilog to come up with an expected value
	// then compare the two
	reg [63:0] Fexp;
	// implement the A/Anot and B/Bnot muxes
	wire [63:0] A2, B2; 
	assign A2 = FS[1] ? ~A : A;
	assign B2 = FS[0] ? ~B : B;
	
	always @(*) begin
		case (FS[4:2])
			3'b000: Fexp <= A2 & B2;
			3'b001: Fexp <= A2 | B2;
			3'b010: Fexp <= A2 + B2 + C0;
			3'b011: Fexp <= A2 ^ B2;
			3'b100: Fexp <= A << B[5:0];
			3'b101: Fexp <= A >> B[5:0];
			3'b110: Fexp <= 64'b0;
			3'b111: Fexp <= 64'b0;
		endcase
	end
	
	// create a signal that will indicate if the expected and actual values match
	// and display a message if they don't with what is being done
	reg good;
	always begin
		#5 good = (F == Fexp) ? 1'b1 : 1'b0;
		if(F != Fexp) begin
			$display("time %d, F %x, Fexp %x, FS %b, A %x, B %x", $time, F, Fexp, FS, A, B);
			errors <= errors + 1;
		end
	end
	
endmodule













