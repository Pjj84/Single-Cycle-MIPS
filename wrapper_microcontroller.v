`timescale 1ns / 1ps
module wrapper_microcontroller
// (
   //  input  wire clk,                     //PL clk (Programmable Logic clock) - 50_MHz
   //  input  wire [3:0] button_mb,         //ACTIVE LOW : lsb  -> rightmost on the board ("mb" is the short form of "main board")
   //  input  wire button_2, button_1,      //ACTIVE HIGH
   //  input  wire [7:0] dip,               //ACTIVE HIGH: lsb  -> rightmost on the board
   //  output wire [4:0] led_mb,            //ACTIVE HIGH: lsb   -> rightmost on the board ("mb" is the short form of "main board")
   //  output wire [9:0] led,               //ACTIVE HIGH: lsb   -> downmost on the board
   //  output wire dig3, dig2, dig1, dig0,  //ACTIVE HIGH: dig0 -> rightmost on the board
   //  output wire a,b,c,d,e,f,g,           //ACTIVE LOW
   //  output wire colon                    //ACTIVE LOW    
   //  )
    ;

   reg clk = 1;
   always @(clk) #5 clk <= ~clk;


   reg reset;
   initial begin
      reset = 1;
      @(posedge clk);
		#1;
      reset = 0;
   end
    
    wire [3:0] A_dip_lsb_micro;
    wire [3:0] B_dip_msb_micro;
    wire [4:0] C_button_micro;

    wire [14:0] D_led_micro;
    wire [11:0] E_7seg_micro;

   wire button_1 = 1'b0;
   wire button_2 = 1'b0;
   wire [3:0] button_mb = 4'b0000;
   wire [7:0] dip = 7'hFF;
   wire [4:0] led_mb;            //ACTIVE HIGH: lsb   -> rightmost on the board ("mb" is the short form of "main board")
   wire [9:0] led;               //ACTIVE HIGH: lsb   -> downmost on the board
   wire dig3, dig2, dig1, dig0;  //ACTIVE HIGH: dig0 -> rightmost on the board
   wire a,b,c,d,e,f,g;           //ACTIVE LOW
   wire colon;                    //ACTIVE LOW  
   
    
    assign A_dip_lsb_micro                                  = dip[3:0];
    assign B_dip_msb_micro                                  = dip[7:4];
    assign C_button_micro                                   = {button_2, ~button_mb};

    assign {led_mb, led}                                    = D_led_micro;
    assign {dig3, dig2, dig1, dig0 , {colon,g,f,e,d,c,b,a}} = {E_7seg_micro[11:8], ~E_7seg_micro[7:0]};

    single_cycle_mips core(
      .clk          (clk),
      .reset        (reset),
      .A_dip_lsb    (A_dip_lsb_micro),
      .B_dip_msb    (B_dip_msb_micro),
      .C_button     (C_button_micro),
      .D_led        (D_led_micro),
      .E_7seg       (E_7seg_micro)
    );
    
endmodule

module async_mem_i(
   input clk,
   input write,
   input [31:0] address,
   input [31:0] write_data,
   output [31:0] read_data
);
   
   reg [31:0] mem_data [0:1023];
   
   initial
      $readmemh("LED.hex", mem_data);

   assign read_data = mem_data[ address[11:2] ];

   always @( posedge clk )
      if ( write )
         mem_data[ address[11:2] ] <= write_data;

endmodule

