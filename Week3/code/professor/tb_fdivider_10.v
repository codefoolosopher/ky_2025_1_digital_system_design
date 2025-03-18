`timescale 1ns / 1ps
//tb_fdivider_10.v
module freq_divider_by_10_tb;
    reg clk_in;
    reg reset;
    wire clk_out;

    freq_divider_by_10 #(
        .DIVISOR(10)
    ) divider (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out)
    );

    // 클록 생성 (10ns 주기, 100MHz)
    always #5 clk_in = ~clk_in;

    initial begin
        clk_in = 0;
        reset = 1;
        #20 reset = 0;  // 20ns 후 리셋 해제
        // 200 사이클 동안 시뮬레이션
        repeat(200) @(posedge clk_in);
        $finish;
    end
    // 결과 모니터링
    always @(posedge clk_in) begin
        $display("Time=%0t, clk_in=%b, clk_out=%b", $time, clk_in, clk_out);
    end
endmodule
