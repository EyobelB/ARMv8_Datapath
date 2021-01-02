`timescale 1ns/1ps
module signExtender(BusImm, Imm26, Ctrl);
	output reg [63:0] BusImm;
	input wire [25:0] Imm26;	
	input wire [2:0] Ctrl;

	reg extendBit;
	//This statements says if the control signal is true,
	//	make the external bit zero, but if its false,
	//	set it to the highest bit value on the original immedate,
	//	so that it can be replicated.
	//
	//	Extending to be done based on instruction:
	//	For ADD and SUB, the immediate exists from [21:10]
	//	For LDUR and STUR, immediate exists from [20:12]
	//	For CBZ, the immediate exists from [23:5]
	//	For B, the immediate exists from [25:0]

	//Based on the above, we need sign extending for...
	//	ADD, SUB, LDUR, STUR, B, and CBZ
	//	create an always block
	//	Create 3'b100 for sign extending the immediate on MOVZ based
	//	on the last 2 digits of the opcode 
	
	always @(Ctrl, Imm26)
	begin
		case(Ctrl)
			3'b000:	begin
			       	extendBit = 0;
				BusImm = {{52{extendBit}}, Imm26[21:10]};
				end

			3'b001:	begin
			       	extendBit = Imm26[20];
				BusImm = {{55{extendBit}}, Imm26[20:12]};
				end

			3'b010:	begin
			       	extendBit = Imm26[23];
				BusImm = {{45{extendBit}}, Imm26[23:5]};
				end

			3'b011:	begin
			        extendBit = Imm26[25];
				BusImm = {{38{extendBit}}, Imm26};
				end
			3'b100: begin
				BusImm = {{48{1'b0}}, Imm26[20:5]};
			end
			3'b101: begin
				BusImm = {{32{1'b0}}, Imm26[20:5], 16'b0};
			end
			3'b110: begin
				BusImm = {{16{1'b0}}, Imm26[20:5], 32'b0};
			end
			3'b111: begin
				BusImm = {Imm26[20:5], 48'b0};
			end
		endcase
	end

endmodule
