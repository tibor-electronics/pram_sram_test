//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
// Based on code from Richard Haskell and Darrin Hanna's,
// "Learning by Example Using Verilog: Basic Digital Design", 2008
// Chapter 7, Example 52, Clock Divider
//
module clock_divider(
    input clk,
    input clr,
	 output clk6,
    output clk17
);

reg [17:0] q;

always @(posedge clk or posedge clr)
	if (clr == 1)
		q <= 0;
	else
		q <= q + 1;

assign clk6 = q[6];
assign clk17 = q[17];

endmodule
