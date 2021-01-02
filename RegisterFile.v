`timescale 1ns / 1ps

//Note: Don't use an initial block, this will fail to synthesize

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input signed [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];  


    //This handles the write capability
    always @ (negedge Clk) begin
        if(RegWr && RW != 31)
            registers[RW] <= BusW;
    end

    //Assign the registers based on these statements
    assign BusA = (RA == 31) ? 0: registers[RA];
    assign BusB = (RB == 31) ? 0: registers[RB];


endmodule
