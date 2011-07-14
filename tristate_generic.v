//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
// Based on code from Richard Haskell and Darrin Hanna's,
// "Learning by Example Using Verilog: Advanced Digital Design", 2009
// Chapter 4, Listing 4.9, buff3.v
//
module tristate_generic
#(parameter N = 8)
(
	input wire [N-1:0] in,
	input wire en,
	output reg [N-1:0] out
);

always @(*)
begin
	if (en == 1)
		out = in;
	else
		out = 'bz;
end

endmodule
