module sram_ctrl_a(
    input clk,
    input clr,
    input go,
	 input halt,
    output reg we,
    output [17:0] sram_addr,
	 output [2:0] pattern,
    output reg en
);

reg[2:0] state;
parameter START = 4'b0000, ADDROUT = 4'b0001, DATAOUT = 4'b0010,
	WRITE = 4'b0011, TEST1 = 4'b0100, WAIT_AND_GO = 4'b0101, READ = 4'b0110,
	TEST2 = 4'b0111, HALT = 4'b1000;
reg [17:0] addrv;
reg [2:0] patternv;

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
				state <= DATAOUT;
				we <= 1;
			end
			
			DATAOUT:
			begin
				state <= WRITE;
				we <= 0;
			end
			
			WRITE:
			begin
				state <= TEST1;
				we <= 1;
			end
			
			TEST1:
			begin
				we <= 1;
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
