`timescale 1ns / 1ps
module moore_fsm (
    input clk,          // 클럭 신호
    input reset,        // 리셋 신호 (비동기)
    input go,           // 입력 신호 go
    input ws,           // 입력 신호 ws
    output reg rd,      // 출력 신호 rd
    output reg ds       // 출력 신호 ds
);

    // 상태 정의 (4개의 상태)
 
    reg [1:0] state, next_state;  // 현재 상태와 다음 상태

    // 상태 레지스터: 현재 상태를 저장
 
    // 다음 상태 로직: 입력(go, ws)에 따라 상태 전환 결정
 
    // 출력 로직: 현재 상태에 따라 출력 결정 (Moore 머신)
 
endmodule
