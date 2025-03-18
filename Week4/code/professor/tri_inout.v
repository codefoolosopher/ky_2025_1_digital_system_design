`timescale 1ns / 1ps
module tri_io_example (
    input             clk,       // 클럭 신호
    input             reset,
    input             oe,        // 출력 활성화 신호 (Output Enable)
    input       [7:0] data_in,   // 출력 데이터
    output reg  [7:0] data_out,  // 입력 데이터 저장
    inout  wire [7:0] io_pin     // 양방향 핀
);

    // 트라이스테이트 제어
    assign io_pin = (oe) ? data_in : 8'bz; // 출력 모드일 때만 데이터 전송

    // 입력 데이터를 읽어오는 로직
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            data_out <= 0;
        end else begin
            if (!oe) begin
                data_out <= io_pin;  // 입력 모드일 때만 데이터 읽기
            end

        end
    end

endmodule

