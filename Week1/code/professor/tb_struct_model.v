`timescale 1ns / 1ps
// tb_struct_model.v
module tb_struct_model;
  // Inputs
  reg [7:0] x;
  reg [7:0] y;
  reg cin;
  // Outputs
  wire [7:0] s;
  wire carry;

  // Instantiate the Unit Under Test (UUT)
  fa_8 uut (
    .x(x),
    .y(y),
    .cin(cin),
    .s(s),
    .carry(carry)
  );

  // Monitor
  initial begin
    $monitor("Time=%0t: x=%b y=%b cin=%b | s=%b carry=%b", 
             $time, x, y, cin, s, carry);
  end

  integer i,j;
  // Stimulus
  initial begin
    // Initialize Inputs
    x = 0; y = 0; cin = 0;
    #10;

    // Test cases
    x = 8'b00000001; y = 8'b00000001; cin = 0; #10; // 1 + 1 = 2
    x = 8'b00001010; y = 8'b00000101; cin = 0; #10; // 10 + 5 = 15
    x = 8'b01111111; y = 8'b00000001; cin = 0; #10; // 127 + 1 = 128
    x = 8'b10000000; y = 8'b10000000; cin = 0; #10; // 128 + 128 = 256 (overflow)
    x = 8'b11111111; y = 8'b00000001; cin = 0; #10; // 255 + 1 = 256 (overflow)
    x = 8'b10101010; y = 8'b01010101; cin = 0; #10; // 170 + 85 = 255
    x = 8'b11111111; y = 8'b11111111; cin = 0; #10; // 255 + 255 = 510 (overflow)
    // every partten vector test
    for (i = 0; i<256; i=i+1 ) begin
      for (j = 0; j<256 ; j=j+1 ) begin
        x=i;
        y=j;
        #10;
      end
    end

    $finish;
  end
      
endmodule


