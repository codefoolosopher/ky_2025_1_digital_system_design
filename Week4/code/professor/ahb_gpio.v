`timescale 1ns/1ns
module ahb_gpio (
    input wire clk,                   // 시스템 클럭
    input wire reset_n,               // 비동기 리셋 (Active Low)
    input wire [31:0] addr,           // AHB 주소
    input wire [31:0] wdata,          // AHB 쓰기 데이터
    input wire write_enable,          // AHB 쓰기 활성화 신호
    output reg [31:0] rdata,          // AHB 읽기 데이터
    input wire [7:0] gpio_in,         // 외부 입력 데이터
    output reg [7:0] gpio_out,        // 외부 출력 데이터
    output reg [7:0] gpio_dir         // GPIO 방향 제어 (1: 출력, 0: 입력)
);

    // 내부 레지스터 정의
    reg [7:0] input_data;             // 입력 데이터 레지스터
    reg [7:0] output_data;            // 출력 데이터 레지스터
    reg [7:0] direction;              // 방향 레지스터

    // 주소 매핑 상수 정의
    localparam ADDR_INPUT  = 32'h5300_0000;  // 입력 레지스터 주소
    localparam ADDR_OUTPUT = 32'h5300_0004;  // 출력 레지스터 주소
    localparam ADDR_DIR    = 32'h5300_0008;  // 방향 레지스터 주소

    // 읽기 동작 처리
    always @(*) begin
        case (addr)
            ADDR_INPUT:  rdata = {24'b0, input_data};   // 입력 데이터 읽기
            ADDR_OUTPUT: rdata = {24'b0, output_data};  // 출력 데이터 읽기
            ADDR_DIR:    rdata = {24'b0, direction};    // 방향 레지스터 읽기
            default:     rdata = 32'b0;                // 기본값
        endcase
    end

    // 쓰기 동작 처리
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            input_data <= 8'b0;
            output_data <= 8'b0;
            direction <= 8'b0;
        end else if (write_enable) begin
            case (addr)
                ADDR_OUTPUT: output_data <= wdata[7:0];   // 출력 데이터 쓰기
                ADDR_DIR:    direction <= wdata[7:0];     // 방향 레지스터 쓰기
                default: ;                                // 기본값 유지
            endcase
        end
    end

    // GPIO 동작 처리 (입출력 제어)
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            gpio_out <= 8'b0;
            gpio_dir <= 8'b0;
        end else begin
            gpio_out <= output_data & direction;          // 출력 모드일 때만 값 설정
            gpio_dir <= direction;                       // 방향 설정 유지
        end

        input_data <= gpio_in & ~direction;              // 입력 모드일 때만 값 읽기
    end

endmodule