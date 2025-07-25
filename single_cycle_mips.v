//===============================================================================
//
//			Parsa Joneidi 402101509
//
//			Implemented Instructions are:
//			R format:  add(u), sub(u), and, or, xor, nor, slt, sltu;
//			I format:  beq, bne, lw, sw, addi(u), slti, sltiu, andi, ori, xori, lui.
//
//===============================================================================

`timescale 1ns/1ns

   `define ADD  4'h0
   `define SUB  4'h1
   `define SLT  4'h2
   `define SLTU 4'h3
   `define AND  4'h4
   `define OR   4'h5
   `define NOR  4'h6
   `define XOR  4'h7
   `define LUI  4'h8

module single_cycle_mips
(
	input wire clk,
	input wire reset,
   input wire [3:0] A_dip_lsb,
   input wire [3:0] B_dip_msb,
   input wire [4:0] C_button,
   output reg [14:0] D_led,
   output reg [11:0] E_7seg   
);
 
	initial begin
		$display("Single Cycle MIPS Implemention");
		$display("Parsa Joneidi 402101509");
	end

	reg [31:0] PC;          // Keep PC as it is, its name is used in higher level test bench

   wire [31:0] instr;
   wire [ 5:0] op   = instr[31:26];
   wire [ 5:0] func = instr[ 5: 0];

   // Parsa: Don't Worry about RD1 and RD2 they are taken care of.
   wire [31:0] RD1, RD2, AluResult, MemReadData;
  
   wire AluZero;

   // Control Signals

   reg branch;
   wire PCSrc = branch & ( op == 6'h04 ? AluZero : ~AluZero);

   reg SZEn, ALUSrc, RegDst, MemtoReg, RegWrite, MemWrite;


   reg [3:0] AluOP;

	
	// CONTROLLER COMES HERE

      /*
   Parsa Nikookalam
   Moein Yousefinia
   Mojtaba Pour Ali Mohammadi
   @ Computer Architecture course of Prof. MohammadReza Movahedin
   */

   // Your main version to be completed (just complete the address decoder)

   ////////////////////////////////////////////////////////////////////////////////////////////////////////////

   reg lw_flag;
   reg [31:0] ReadData;
   reg EN_D_led, EN_E_7seg, WEM;
   reg [1:0] RDsel;



   always @(*) begin
      branch = 1'b0; // DEFAULT IS NOT BRANCH
      SZEn = 1'b0;   // DEFAULT ZERO EXTEND = 0 ( SIGN EXTEND =  1)
      AluOP = 4'hx;  
      ALUSrc = 1'b1; // DEFAULT IMMEDIATE = 1 ( REGISTER FILE = 0 )
      RegDst = 1'b0; // DEFAULT I-FORMAT = 0 ( R-FORMAT = 1)
      MemtoReg = 1'b0; // DEFAULT DISABLED
      RegWrite = 1'b1; // DEFAULT ENABLED
      MemWrite = 1'b0; // DEFAULT DISABLED
      lw_flag = 1'b0;

      case(op)
         6'h0:begin  // R-FORMAT
            ALUSrc = 1'b0;
            RegDst = 1'b1;
         
         case(func)
         6'h20:begin       // ADD
            AluOP = `ADD;
            // $display("ADDING");
         end
         6'h21:begin       // ADDU
            AluOP = `ADD;
            // $display("ADDING UNSIGNED");
         end
         6'h22:begin       // SUB
            AluOP = `SUB;
            // $display("SUBING");
         end
         6'h23:begin       // SUBU
            AluOP = `SUB;
            // $display("SUBING UNSIGNED");
         end
         6'h24:begin       // AND
            AluOP = `AND;
            // $display("ANDING");
         end
         6'h25:begin       // OR
            AluOP = `OR;
            // $display("ORING");
         end
         6'h26:begin       // XOR
            AluOP = `XOR;
            // $display("XORING");
         end
         6'h27:begin       // NOR
            AluOP = `NOR;
            // $display("NORING");
         end
         6'h2A:begin       // SLT
            AluOP = `SLT;
            // $display("SLT");
         end
         6'h2B:begin       // SLTU
            AluOP = `SLTU;
            // $display("SLTU");
         end
         endcase

         end
         6'h23:begin       // LW
            SZEn = 1'b1;
            RegWrite = 1'b1;
            AluOP = `ADD;
            MemtoReg = 1'b1;
            lw_flag = 1'b1;
            $display("LW");
         end
         6'h2B:begin       // SW
            SZEn = 1'b1;
            RegWrite = 1'b0;
            AluOP = `ADD;
            MemWrite = 1'b1;
            $display("SW");
         end
         6'h04:begin       // BEQ
            branch = 1'b1;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            AluOP = `SUB;
            // $display("BEQ");
         end
         6'h05:begin       // BNE
            branch = 1'b1;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            AluOP = `SUB;
            // $display("BNE");
         end
         6'h08:begin       // ADDI
            AluOP = `ADD;
            SZEn = 1'b1;
            // $display("ADDI");
         end
         6'h09:begin       // ADDIU
            AluOP = `ADD;
            // $display("ADDIU");
         end
         6'h0A:begin       // SLTI
            AluOP = `SLT;
            SZEn = 1'b1;
            // $display("SLTI");
         end
         6'h0B:begin       // SLTIU
            AluOP = `SLTU;
            // $display("SLTIU");
         end
         6'h0C:begin       // ANDI
            AluOP = `AND;
            // $display("ANDI");
         end
         6'h0D:begin       // ORI
            AluOP = `OR;
            // $display("ORI");
         end
         6'h0E:begin       // XORI
            AluOP = `XOR;
            // $display("XORI");
         end
         6'h0F:begin       // LUI
            AluOP = `LUI;
            // $display("LUI");
         end

      endcase
      


   end


	// DATA PATH STARTS HERE

   wire [31:0] PCplus4 = PC + 4'h4;

   wire [31:0] WD = MemtoReg ? ReadData : AluResult;

   wire [ 4:0] WR = RegDst ? instr[15:11] : instr[20:16];

   wire [31:0] Imm32 = SZEn ? {{16{instr[15]}},instr[15:0]} : {16'h0, instr[15:0]};
                    // ZSEn: 1 sign extend, 0 zero extend

   wire [31:0] PCbranch = PCplus4 + (Imm32 << 2);

//==========================================================//
//	instantiated modules
//==========================================================//

// Register File

   reg_file rf
   (
      .clk (clk),
      .write ( RegWrite ),
      .RR1   ( instr[25:21] ),
      .RR2   ( instr[20:16] ),
      .WR (WR),
      .WD (WD),
      .RD1 (RD1),
      .RD2 (RD2)
	);

   my_alu alu
   (
      .Op( AluOP ),
      .A ( RD1 ),
      .B ( ALUSrc ? Imm32 : RD2),
      .X ( AluResult ),
      .Z ( AluZero )
   );
   
//	Instruction Memory
	async_mem_i imem			// keep the exact instance name
	(
		.clk		   (1'b0),
		.write		(1'b0),		// no write for instruction memory
		.address	   ( PC ),		   // address instruction memory with pc
		.write_data	(32'bx),
		.read_data	( instr )
	);
	
// Data Memory
	async_mem dmem			// keep the exact instance name
	(
		.clk		   ( clk ),
		.write		( WEM ),
		.address	   ( AluResult ),
		.write_data	( RD2 ),
		.read_data	( MemReadData )
	);

      // Added control unit (address decoder)
   always @(*) begin
      RDsel = 2'bxx;  // Muxes asre initialized as "x"s, to be treated as don't care as default while not given a value
      WEM   = 1'b0; // Write enables can never be "x"s or don't cares, and we want them to be "0"s as default when we don't want to write on them
      EN_D_led = 1'b0;
      EN_E_7seg = 1'b0;
      if(lw_flag) begin // LW : either from memory, or from "button"
         case (AluResult)
            32'd4076 : RDsel = 2'b01; // A_dip_lsb
            32'd4080 : RDsel = 2'b10; // B_dip_msb 
            32'd4084 : RDsel = 2'b11; // C_button             
            default:   RDsel = 2'b00; // LW from data memory
         endcase
      end
      if(MemWrite) begin // SW : either to memory, or to "led"
      case (AluResult)
         32'd4088 : EN_D_led = 1'b1;
         32'd4092 : EN_E_7seg = 1'b1;
         default:   WEM   = 1'b1; // SW to data memory
      endcase
      end
   end

   always @(posedge clk) begin

      if (reset) begin
         D_led  <= 15'h0000;
         E_7seg <= 12'h000;
         PC <= 32'h0;
      end
      else begin
         if ( EN_D_led )
            D_led  <= RD2[14:0]; // The output register "D_led" with "EN_D_led" as the enable, described here
         if ( EN_E_7seg )
            E_7seg <= RD2[11:0]; // The output register "E_7seg" with "EN_E_7seg" as the enable, described here
         case(PCSrc)
            1'b1:
               PC <= PCbranch;
            1'b0:
               PC <= PCplus4;
            default:
               PC <= PCplus4;
         endcase
      end
   end

   // muxes for inputs and the data memory
   always @(*) begin
      case (RDsel)
         2'b00: ReadData = MemReadData;
         2'b01: ReadData = {28'b0, A_dip_lsb};
         2'b10: ReadData = {28'b0, B_dip_msb};
         2'b11: ReadData = {27'b0, C_button};
         default: ReadData = 32'hxxxx_xxxx;
      endcase
   end

endmodule


//===============================================================================

module my_alu(
   input  [3:0] Op,
   input  [31:0] A,
   input  [31:0] B,
   output [31:0] X,
   output        Z
   );

   wire sub = Op != `ADD;
   wire [31:0] bb = sub ? ~B : B;
   wire [32:0] sum = A + bb + sub;
   wire sltu = ! sum[32];

   wire v = sub ?
            ( A[31] != B[31] && A[31] != sum[31] )
          : ( A[31] == B[31] && A[31] != sum[31] );

   wire slt = v ^ sum[31];

   reg [31:0] x;

   always @( * )
      case( Op )
         `ADD : x = sum;
         `SUB : x = sum;
         `SLT : x = slt;
         `SLTU: x = sltu;
         `AND : x = A & B;
         `OR  : x = A | B;
         `NOR : x = ~(A | B);
         `XOR : x = A ^ B;
         `LUI : x = {B[15:0], 16'h0};
         default : x = 32'hxxxxxxxx;
      endcase

   assign X = x;
   assign Z = x == 32'h00000000;

endmodule

//===============================================================================

