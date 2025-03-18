`timescale 1ns / 1ps
//tb_fdivider_10.v
module freq_divider_by_10_tb;
    reg clk_in;
    reg reset;
    wire clk_out;

     // 결과 모니터링
    always @(posedge clk_in) begin
        $display("Time=%0t, clk_in=%b, clk_out=%b", $time, clk_in, clk_out);
    end
endmodule
