`define OPCODE_ANDREG 11'h450
`define OPCODE_ORRREG 11'h550
`define OPCODE_ADDREG 11'h458
`define OPCODE_SUBREG 11'h658

`define OPCODE_ADDIMM 11'b1001000100X
`define OPCODE_SUBIMM 11'b1101000100X

`define OPCODE_MOVZ   11'b110100101??

`define OPCODE_B      11'b0001010XXXX
`define OPCODE_CBZ    11'b10110100XXX

`define OPCODE_LDUR   11'h7C2
`define OPCODE_STUR   11'h7C0

module control(
    output reg reg2loc,
    output reg alusrc,
    output reg mem2reg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch,
    output reg uncond_branch,
    output reg [3:0] aluop,
    output reg [2:0] signop,
    input [10:0] opcode
);

always @(*)
begin
    casez (opcode)

        /* Add cases here for each instruction your processor supports */
	//Need to support LDUR, STUR, ADD, SUB, AND, ORR, CBZ, and B, so 8 opcode types
	`OPCODE_LDUR:
	begin
		
		reg2loc <= 1'bx;
		alusrc <= 1'b1;
		mem2reg <= 1'b1;
		regwrite <= 1'b1;
		memread <= 1'b1;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0010;
		signop <= 3'b001;
	end
	`OPCODE_STUR:
	begin
		
		reg2loc <= 1'b1;
		alusrc <= 1'b1;
		mem2reg <= 1'b1;
		regwrite <= 1'b0;
		memread <= 1'b0;
		memwrite <= 1'b1;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0010;
		signop <= 3'b001;
	end
	`OPCODE_ADDREG:
	begin
		
		reg2loc <= 1'b0;
		alusrc <= 1'b0;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0010;
		signop <= 3'bxxx;
	end
	`OPCODE_ADDIMM:
	begin
		
		reg2loc <= 1'bx;
		alusrc <= 1'b1;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0010;
		signop <= 3'b000;
	end
	`OPCODE_SUBREG:
	begin
		
		reg2loc <= 1'b0;
		alusrc <= 1'b0;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0110;
		signop <= 3'bxxx;
	end
	`OPCODE_SUBIMM:
	begin
		
		reg2loc <= 1'bx;
		alusrc <= 1'b1;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0110;
		signop <= 3'b000;
	end
	`OPCODE_ANDREG:
	begin
		
		reg2loc <= 1'b0;
		alusrc <= 1'b0;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0000;
		signop <= 3'bxxx;
	end
	`OPCODE_ORRREG:
	begin
		
		reg2loc <= 1'b0;
		alusrc <= 1'b0;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0001;
		signop <= 3'bxxx;
	end
	11'h5A0://`OPCODE_CBZ:
	begin
		
		reg2loc <= 1'b1;
		alusrc <= 1'b0;
		mem2reg <= 1'bx;
		regwrite <= 1'b0;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b1;
		uncond_branch <= 1'b0;
		aluop <= 4'b0111;
		signop <= 3'b010;
	end
	11'h0BF://`OPCODE_B:
	begin
		
		reg2loc <= 1'bx;
		alusrc <= 1'bx;
		mem2reg <= 1'bx;
		regwrite <= 1'b0;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'bx;
		uncond_branch <= 1'b1;
		aluop <= 4'bxxxx;
		signop <= 3'b011;
	end
	
	`OPCODE_MOVZ:
	begin
		reg2loc <= 1'bx;
		alusrc <= 1'b1;
		mem2reg <= 1'b0;
		regwrite <= 1'b1;
		memread <= 1'b0;
		memwrite <= 1'b0;
		branch <= 1'b0;
		uncond_branch <= 1'b0;
		aluop <= 4'b0111;
		signop <= {1'b1,opcode[1:0]};
	end
        default:
        begin
	
            reg2loc       <= 1'bx;
            alusrc        <= 1'bx;
            mem2reg       <= 1'bx;
            regwrite      <= 1'b0;
            memread       <= 1'b0;
            memwrite      <= 1'b0;
            branch        <= 1'b0;
            uncond_branch <= 1'b0;
            aluop         <= 4'bxxxx;
            signop        <= 3'bxxx;
        end
    endcase
end

endmodule

