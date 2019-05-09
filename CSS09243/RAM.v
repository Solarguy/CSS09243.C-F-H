module RAM(clock, address, data, select, write, out);
	parameter addressWidth = 12;
	parameter dataWidth = 64;
	parameter dataDepth = 1 << addressWidth;

	input clock, select, write, out;
	input [31:0] address;
	inout [dataWidth-1:0] data;
	reg [dataWidth-1:0] dataOut;
	reg [dataWidth-1:0] mem [0:dataDepth-1];
	reg outReg;
	
	assign data = (select & out & ~write) ? dataOut : {dataWidth{1'bz}};
	
	always @(posedge clock) begin : memWrite
		if (select & write) begin
			if (address < 32'hFFF)
				mem[address[addressWidth-1:0]] = data;
		end
	end
	
	always @(posedge clock) begin : memRead
		if (select & ~write & out) begin
			if (address < 32'hFFF)
				dataOut = mem[address[addressWidth-1:0]];
			else
				dataOut = {dataWidth{1'bz}};
				outReg = 1;
		end else begin
			outReg = 0;
		end
	end
endmodule
