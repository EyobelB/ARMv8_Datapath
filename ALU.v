`timescale 1ns/1ps
`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111

//ADD SIGNED NUMBERS
module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    parameter n = 64;

    output [n-1:0] BusW;
    input signed  [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  reg Zero;
    
    reg     [n-1:0] BusW;


    always @(BusW) begin
	    if(BusW == 0)
		    Zero <= 1;
	    else
		    Zero <= 0;
    end
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: begin
		BusW <= BusA & BusB;
            end
	    `OR: begin
		BusW <= BusA | BusB;
	    end
	    `ADD: begin
		BusW <= BusA + BusB;
	    end
	    `SUB: begin
		BusW <= BusA - BusB;
	    end
	    `PassB: begin
		BusW <= BusB;
	end
	endcase
	
    end

endmodule
