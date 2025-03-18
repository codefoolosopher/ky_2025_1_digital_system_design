`timescale 1ns / 1ps
module SimpleRegister (
    input  clk,             // 클럭 신호
    input  reset,           // 리셋 신호
    input  write_enable,    // 쓰기 활성화 신호
    input  [7:0] write_data, // 쓰기 데이터
    output  [7:0] read_data  // 읽기 데이터
);

    // 8비트 레지스터 선언


    // 클럭 상승 에지에서 동작


    // 읽기 데이터는 항상 현재 레지스터 값 출력


endmodule
