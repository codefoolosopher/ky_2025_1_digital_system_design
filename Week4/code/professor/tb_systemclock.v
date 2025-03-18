`timescale 1ns/1ns 

module tb_ClockControlUnit;

    // 테스트벤치 신호 선언
    reg clk_in;
    reg reset;
    reg [3:0] prescaler;

    wire cpu_clk;
    wire io_clk;

    // ClockControlUnit 모듈 인스턴스화
    ClockControlUnit uut (
        .clk_in(clk_in),
        .reset(reset),
        .prescaler(prescaler),
        .cpu_clk(cpu_clk),
        .io_clk(io_clk)
    );

    // 입력 클럭 생성 (100MHz, 주기 10ns)
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in; // 5ns마다 반전 (100MHz)
    end

    // 초기값 설정 및 테스트 시나리오
    initial begin
        // 초기값 설정
        reset = 1;
        prescaler = 4'd1; // prescaler = 1 (2^(1+1) = 4로 분주)

        #20;              // 리셋 유지 (20ns)
        reset = 0;        // 리셋 해제
        #200;             // 200ns 동안 동작 관찰 (prescaler=1)
        prescaler = 4'd2; // prescaler 변경: 2^(2+1)=8로 분주
        #200;             // 추가로 200ns 동안 동작 관찰
        prescaler = 4'd3; // prescaler 변경: 2^(3+1)=16로 분주
        #400;             // 추가로 400ns 동안 동작 관찰
        prescaler = 4'd0; // prescaler 변경: 분주 없음 (2^(0+1)=2로 분주)
        #100;             // 추가로 100ns 동안 동작 관찰
        $finish;          // 시뮬레이션 종료
    end
    // 파형 덤프 설정 (GTKWave 등에서 파형 확인용)
    initial begin
        $dumpfile("ClockControlUnit_tb.vcd");
        $dumpvars(0, tb_ClockControlUnit);
    end
endmodule

