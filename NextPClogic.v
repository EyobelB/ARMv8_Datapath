`timescale 1ns / 1ps
module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	input [63:0] CurrentPC;
	input signed [63:0] SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output reg [63:0] NextPC;
	
	//Determine what goes into determining the NextPC
	//A MUX that decides between a plus four to the CurrentPC or the sign
	//	extended value plus the CurrentPC
	//The select line is based on ((ALUZero && Branch) || Uncondbranch),
	//	where zero means add 4 to PC and one means add CurrentPC and
	//		signextend

	reg branching;

	//Always block for the MUX select line
	always@(*)
	begin
		branching <= ((ALUZero && Branch) || Uncondbranch) ? 1'b1 : 1'b0;
	end
	//Ensure that the SignExtImm64 is signed.

	//Always block for the actual MUX, which utilizes the above select
	//line in the other always block
	always@(*)
	begin
		case (branching)
			1'b0: begin
				NextPC <= CurrentPC + 64'b100;
			end
			1'b1: begin	
				NextPC <= (SignExtImm64 <<< 2) + CurrentPC;
			end
		endcase
	end


endmodule
