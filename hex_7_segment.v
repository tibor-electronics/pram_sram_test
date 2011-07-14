//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
// Based on code from Richard Haskell and Darrin Hanna's,
// "Learning by Example Using Verilog: Basic Digital Design", 2008
// Chapter 5, Example 15, 7-Segment Displays
//
module hex_7_segment(
	input wire [15:0] x,
	input wire clk,
	input wire clr,
	output reg [6:0] a_to_g,
	output reg [3:0] an
);

wire [1:0] s;
reg [3:0] digit;
wire [3:0] aen;
reg [18:0] clkdiv;

assign s = clkdiv[18:17];
//assign aen[3]	= x[15] | x[14] | x[13] | x[12];
//assign aen[2]	= x[15] | x[14] | x[13] | x[12]
//					| x[11] | x[10] |  x[9] |  x[8];
//assign aen[1]	= x[15] | x[14] | x[13] | x[12]
//					| x[11] | x[10] |  x[9] |  x[8]
//					| x[7]  |  x[6] |  x[5] |  x[4];
//assign aen[0]	= 1;
assign aen = 4'b1111;

always @(*)
	case (s)
		0: digit = x[3:0];
		1: digit = x[7:4];
		2: digit = x[11:8];
		3: digit = x[15:12];
		default: digit = x[3:0];
	endcase

always @(*)
	case (digit)
		'h0: a_to_g = 7'b0000001;
		'h1: a_to_g = 7'b1001111;
		'h2: a_to_g = 7'b0010010;
		'h3: a_to_g = 7'b0000110;
		'h4: a_to_g = 7'b1001100;
		'h5: a_to_g = 7'b0100100;
		'h6: a_to_g = 7'b0100000;
		'h7: a_to_g = 7'b0001111;
		'h8: a_to_g = 7'b0000000;
		'h9: a_to_g = 7'b0000100;
		'ha: a_to_g = 7'b0001000;
		'hb: a_to_g = 7'b1100000;
		'hc: a_to_g = 7'b0110001;
		'hd: a_to_g = 7'b1000010;
		'he: a_to_g = 7'b0110000;
		'hf: a_to_g = 7'b0111000;
		default: a_to_g = 7'b0000001;
	endcase

always @(*)
	begin
		an = 4'b0000;
		if (aen[s] == 1)
			an[s] = 1;
	end

always @(posedge clk or posedge clr)
	begin
		if (clr == 1)
			clkdiv <= 0;
		else
			clkdiv <= clkdiv + 1;
	end

endmodule
