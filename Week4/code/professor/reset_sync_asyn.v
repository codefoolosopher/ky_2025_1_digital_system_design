`timescale 1ns/1ns
 module sync_async_reset (
    input clock,       // 클럭 입력
    input reset_n,     // 비동기 리셋 (Active Low)
    input data_a,      // 입력 데이터 A
    input data_b,      // 입력 데이터 B
    output reg out_a,  // 출력 데이터 A
    output reg out_b   // 출력 데이터 B
);

reg sync_reg1, sync_reg2; // 리셋 동기화용 레지스터

// 리셋 동기화 블록: 비동기적으로 활성화되고 동기적으로 해제됨
always @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
        sync_reg1 <= 1'b0; // 비동기적으로 리셋 활성화
        sync_reg2 <= 1'b0;
    end else begin
        sync_reg1 <= 1'b1; // 동기적으로 리셋 해제
        sync_reg2 <= sync_reg1;
    end
end

wire synchronized_reset = sync_reg2; // 동기화된 리셋 신호

// 데이터 처리 블록: 동기화된 리셋 신호를 사용하여 데이터 초기화 및 처리
always @(posedge clock or negedge synchronized_reset) begin
    if (!synchronized_reset) begin
        out_a <= 1'b0; // 리셋 시 초기화
        out_b <= 1'b0;
    end else begin
        out_a <= data_a; // 정상 작동 시 데이터 처리
        out_b <= data_b;
    end
end

endmodule

module reset_pulse_gen (
    input clk,
    output reset_out
);
reg [1:0] resets;

always @(posedge clk)
begin
    if (resets == 2'b00)
        resets <= 2'b01; // 초기 상태에서만 리셋 펄스 발생
end

assign reset_out = ~resets[1];
endmodule