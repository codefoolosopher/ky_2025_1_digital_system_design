`timescale 1ns / 1ps
module TB;
  reg clk, rst_n, x;
  wire z;


 
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
endmodule