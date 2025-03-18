`timescale 1ns/1ns 
module SystemClockPrescaler(
    input wire clk_in,          // 입력 클럭
    input wire reset,           // 리셋 신호
    input wire [3:0] clkps,     // Prescaler 설정 값 (CLKPS[3:0])
    output reg clk_out          // 출력 클럭
);

    reg [7:0] prescale_counter; // Prescaler 카운터

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            prescale_counter <= 8'b0; // 리셋 시 카운터 초기화
            clk_out <= 1'b0;         // 출력 클럭 초기화
        end else begin
            if (prescale_counter == (2**clkps - 1)) begin
                prescale_counter <= 8'b0; // 카운터 리셋
                clk_out <= ~clk_out;      // 출력 클럭 반전
            end else begin
                prescale_counter <= prescale_counter + 1; // 카운터 증가
            end
        end
    end

endmodule

module ClockControlUnit(
    input wire clk_in,          // 입력 클럭
    input wire reset,           // 리셋 신호
    input wire [3:0] prescaler, // Prescaler 설정 값
    output wire cpu_clk,        // CPU 클럭 출력
    output wire io_clk          // I/O 클럭 출력
);

    wire divided_clk;

    // Prescaler 모듈 인스턴스화
    SystemClockPrescaler prescaler_unit (
        .clk_in(clk_in),
        .reset(reset),
        .clkps(prescaler),
        .clk_out(divided_clk)
    );

    assign cpu_clk = divided_clk;   // CPU 클럭에 분주된 클럭 연결
    assign io_clk = divided_clk;   // I/O 클럭에 분주된 클럭 연결

endmodule

