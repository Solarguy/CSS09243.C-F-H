module ram(clock, address, data, select, write, out);
	parameter addressWidth = 8;
	parameter dataWidth = 8;
	parameter dataDepth = 64;//1 << dataWidth;

	input clock, select, write, out;
	input [addressWidth-1:0] address;
	inout [dataWidth-1:0] data;
	reg [dataWidth-1:0] dataOut;
	reg [dataWidth-1:0] mem [0:dataDepth-1];
	reg outReg;
	
	assign data = (select & out & ~write) ? dataOut : {dataWidth{1'bz}};
	
	always @(posedge clock) begin : memWrite
		if (select & write) begin
			mem[address] = data;
		end
	end
	
	always @(posedge clock) begin : memRead
		if (select & ~write & out) begin
			dataOut = mem[address];
			outReg = 1;
		end else begin
			outReg = 0;
		end
	end
endmodule
