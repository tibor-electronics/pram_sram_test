//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//

module sram_top(
    input wire clk,
    input wire button,
    output wire [6:0] a_to_g,
    output wire [3:0] an,
    output wire [6:0] a_to_g2,
    output wire [3:0] an2,
	 output reg good,
	 output reg bad,
	 output wire [1:0] hi_addr,
	 output wire [18:0] addr,
    inout wire [15:0] data,
    output wire ce,
    output wire be,
    output wire we,
    output wire oe
);

wire clr, en, dclk, bclk, fclk;
wire [15:0] dataio, din1;
wire [17:0] sram_addr;
wire [5:0] pattern;
wire button_d;

assign clr = button_d;
assign ce = 0;
assign be = 0;
assign oe = en;

assign data = dataio;
assign addr = {1'b0, sram_addr};
assign hi_addr = sram_addr[17:16];

// custom clock
dcm_clock main_clock (
    .CLKIN_IN(clk),
    .RST_IN(clr),
    .CLKFX_OUT(fclk)
    //.CLKIN_IBUFG_OUT(), 
    //.CLK0_OUT(CLK0_OUT)
);

// controller
pram_sram_ctrl sram_ctrl (
	.clk(fclk),
	.clr(clr),
	.go(bclk),
	.halt(bad),
	.we(we),
	.sram_addr(sram_addr),
	.pattern(pattern),
	.en(en)
);

// ROM
pattern_rom pattern_rom (
	.clk(fclk),
	.addr(pattern),
	.data(din1)
);

tristate_generic #(.N(16))
data_tristate (
	.in(din1),
	.en(en),
	.out(dataio)
);

// button input
clock_divider clock_divider(
	.clk(fclk),
	.clr(clr),
	.clk6(bclk),
	.clk17(dclk)
);

debounce_generic button_debouncer(
	.in(button),
	.clk(dclk),
	.clr(clr),
	.out(button_d)
);

// address and value display
hex_7_segment data_display(
	.x(data),
	.clk(fclk),
	.clr(clr),
	.a_to_g(a_to_g),
	.an(an)
);

hex_7_segment addr_display(
	.x(addr[15:0]),
	.clk(fclk),
	.clr(clr),
	.a_to_g(a_to_g2),
	.an(an2)
);

always @*
	if (data == din1)
		begin
			bad <= 0;
			good <= 1;
		end
	else
		begin
			bad <= 1;
			good <= 0;
		end

endmodule
