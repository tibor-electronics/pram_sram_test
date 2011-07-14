//
// Copyright 2011, Kevin Lindsey
// See LICENSE file for licensing information
//
// Based on code from Richard Haskell and Darrin Hanna's,
// "Learning by Example Using Verilog: Advanced Digital Design", 2009
// Chapter 4, Example 31, External RAM
//

module pram_sram_ctrl(
    input clk,
    input clr,
    input go,
	 input halt,
    output reg we,
    output [17:0] sram_addr,
	 output [5:0] pattern,
    output reg en
);

reg[2:0] state;
parameter
	START			= 3'b000,
	ADDROUT		= 3'b001,
	TEST1			= 3'b010,
	WAIT_AND_GO	= 3'b011,
	READ			= 3'b100,
	TEST2			= 3'b101,
	HALT			= 3'b110;
reg [17:0] addrv;
reg [5:0] patternv;

assign sram_addr = addrv;
assign pattern = patternv;

always @(posedge clk or posedge clr)
begin
	if (clr == 1)
		begin
			state <= START;
			addrv = 0;
			patternv = 0;
			we <= 1;
			en <= 0;
		end
	else
		case(state)
			START:
			begin
				we <= 1;
				if (go == 1)
					begin
						addrv = 0;
						en <= 1;
						state <= ADDROUT;
					end
				else
					state <= START;
			end
			
			ADDROUT:
			begin
				state <= TEST1;
				we <= 1;
			end
			
			TEST1:
			begin
				we <= 0;
				if (halt == 1)
					state <= HALT;
				else
					begin
						addrv = addrv + 1;
						if (addrv == 0)
							begin
								state <= WAIT_AND_GO;
								en <= 0;
							end
						else
							state <= ADDROUT;
					end
			end
			
			WAIT_AND_GO:
			begin
				we <= 1;
				if (go == 1)
					state <= WAIT_AND_GO;
				else
					state <= READ;
			end
			
			READ:
			begin
				we <= 1;
				if (go == 1)
					begin
						state <= TEST2;
						addrv = addrv + 1;
					end
				else
					state <= READ;
			end
			
			TEST2:
			begin
				we <= 1;
				if (addrv == 0)
					begin
						patternv = patternv + 1;
						state <= START;
					end
				else
					state <= WAIT_AND_GO;
			end
			
			HALT:
			begin
				state <= HALT;
			end
			
			default;
		endcase
end

endmodule
