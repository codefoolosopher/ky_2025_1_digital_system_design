`timescale 1ns/1ns 
module tb_sync_async_reset;

    // 테스트벤치용 신호 선언
    reg clock;         // 클럭 신호
    reg reset_n;       // 비동기 리셋 신호 (Active Low)
    reg data_a;        // 입력 데이터 A
    reg data_b;        // 입력 데이터 B
    wire out_a;        // 출력 데이터 A
    wire out_b;        // 출력 데이터 B

    // DUT(Design Under Test) 인스턴스화
    sync_async_reset uut (
        .clock(clock),
        .reset_n(reset_n),
        .data_a(data_a),
        .data_b(data_b),
        .out_a(out_a),
        .out_b(out_b)
    );

    // 클럭 생성: 10ns 주기 (100MHz)
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 5ns마다 클럭 토글
    end

    // 테스트 시나리오
    initial begin
        // 초기화
        reset_n = 1'b0;   // 리셋 활성화 (Active Low)
        data_a = 1'b0;
        data_b = 1'b0;

        #20;              // 20ns 동안 리셋 유지

        reset_n = 1'b1;   // 리셋 해제
        #20;

        // 정상 동작 테스트: 입력 데이터를 변경하며 출력 확인
        data_a = 1'b1;
        data_b = 1'b0;
        #10;

        data_a = 1'b0;
        data_b = 1'b1;
        #10;

        data_a = 1'b1;
        data_b = 1'b1;
        #10;

        // 리셋 재활성화 테스트
        reset_n = 1'b0;   // 리셋 활성화
        #20;

        reset_n = 1'b1;   // 리셋 해제
        #10;

        $stop;            // 시뮬레이션 종료
    end

endmodule
