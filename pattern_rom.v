//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
module pattern_rom(
	input clk,
	inout [5:0] addr,
	output reg [15:0] data
);

reg [5:0] addr_reg;

always @(posedge clk)
	addr_reg <= addr;

always @*
	case (addr_reg)
		// rolling 1's - right
		6'h00: data = 16'h8000;
		6'h01: data = 16'h4000;
		6'h02: data = 16'h2000;
		6'h03: data = 16'h1000;
		6'h04: data = 16'h0800;
		6'h05: data = 16'h0400;
		6'h06: data = 16'h0200;
		6'h07: data = 16'h0100;
		6'h08: data = 16'h0080;
		6'h09: data = 16'h0040;
		6'h0a: data = 16'h0020;
		6'h0b: data = 16'h0010;
		6'h0c: data = 16'h0008;
		6'h0d: data = 16'h0004;
		6'h0e: data = 16'h0002;
		6'h0f: data = 16'h0001;
		
		// rolling 0's - right
		6'h10: data = 16'h7FFF;
		6'h11: data = 16'hBFFF;
		6'h12: data = 16'hDFFF;
		6'h13: data = 16'hEFFF;
		6'h14: data = 16'hF7FF;
		6'h15: data = 16'hFBFF;
		6'h16: data = 16'hFDFF;
		6'h17: data = 16'hFEFF;
		6'h18: data = 16'hFF7F;
		6'h19: data = 16'hFFBF;
		6'h1a: data = 16'hFFDF;
		6'h1b: data = 16'hFFEF;
		6'h1c: data = 16'hFFF7;
		6'h1d: data = 16'hFFFB;
		6'h1e: data = 16'hFFFD;
		6'h1f: data = 16'hFFFE;
		
		// rolling 1's - left
		6'h20: data = 16'h0001;
		6'h21: data = 16'h0002;
		6'h22: data = 16'h0004;
		6'h23: data = 16'h0008;
		6'h24: data = 16'h0010;
		6'h25: data = 16'h0020;
		6'h26: data = 16'h0040;
		6'h27: data = 16'h0080;
		6'h28: data = 16'h0100;
		6'h29: data = 16'h0200;
		6'h2a: data = 16'h0400;
		6'h2b: data = 16'h0800;
		6'h2c: data = 16'h1000;
		6'h2d: data = 16'h2000;
		6'h2e: data = 16'h4000;
		6'h2f: data = 16'h8000;
		
		// rolling 0's - left
		6'h30: data = 16'hFFFE;
		6'h31: data = 16'hFFFD;
		6'h32: data = 16'hFFFB;
		6'h33: data = 16'hFFF7;
		6'h34: data = 16'hFFEF;
		6'h35: data = 16'hFFDF;
		6'h36: data = 16'hFFBF;
		6'h37: data = 16'hFF7F;
		6'h38: data = 16'hFEFF;
		6'h39: data = 16'hFDFF;
		6'h3a: data = 16'hFBFF;
		6'h3b: data = 16'hF7FF;
		6'h3c: data = 16'hEFFF;
		6'h3d: data = 16'hDFFF;
		6'h3e: data = 16'hBFFF;
		6'h3f: data = 16'h7FFF;
		
		default: data = 16'h0;
	endcase

endmodule
