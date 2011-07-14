//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
// Based on code from Richard Haskell and Darrin Hanna's,
// "Learning by Example Using Verilog: Basic Digital Design", 2008
// Chapter 7, Example 47, Debounce Pushbuttons
//
module debounce_generic
#(parameter N = 1)
(
    input [N-1:0] in,
    input clk,
    input clr,
    output [N-1:0] out
);

reg [N-1:0] delay1;
reg [N-1:0] delay2;
reg [N-1:0] delay3;

always @(posedge clk or posedge clr)
	if (clr == 1)
		begin
			delay1 <= 0;
			delay2 <= 0;
			delay3 <= 0;
		end
	else
		begin
			delay1 <= in;
			delay2 <= delay1;
			delay3 <= delay2;
		end

assign out = delay1 & delay2 & delay3;

endmodule
