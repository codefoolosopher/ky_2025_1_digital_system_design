`timescale 1ns / 1ps

module tb_shift_register_sipo;
localparam WIDTH = 8;

reg clk;
reg reset;
reg serial_in;
wire [WIDTH -1 :0] parallel_out;
// 모듈 인스턴스화


// 클럭 생성 (100MHz)

// 입력 데이터 및 리셋 신호 설정

// 결과 모니터링
initial begin
    $monitor("time=%0t | reset=%b | serial_in=%b | parallel_out=%b", $time, reset, serial_in, parallel_out);
end

endmodule
