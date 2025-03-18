`timescale 1ns / 1ps

module tb_moore_fsm;

    // 테스트 벤치에서 사용할 신호 정의
    reg clk;         // 클럭 신호
    reg reset;       // 리셋 신호
    reg go;          // 입력 신호 go
    reg ws;          // 입력 신호 ws
    wire rd;         // 출력 신호 rd
    wire ds;         // 출력 신호 ds

    // DUT (Device Under Test) 인스턴스화
 
    // 클럭 생성: 10ns 주기로 클럭 신호 변경
  
    // 초기화 및 테스트 시퀀스 작성


    // 모니터링: 출력 값 확인
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | go=%b | ws=%b | rd=%b | ds=%b | state=%b",
                 $time, clk, reset, go, ws, rd, ds, uut.state);
    end

endmodule
