`timescale 1ns / 1ps

module tri_io_example_tb;

    reg clk;
    reg oe;
    reg [7:0] data_in;
    wire [7:0] io_pin;
    wire [7:0] data_out;

    // 외부 환경 모델링
    reg [7:0] external_data;
    reg external_drive_enable;

    // 양방향 핀 연결 (외부 환경 구동)
    assign io_pin = external_drive_enable ? external_data : 8'bz;

    // DUT 인스턴스화
    tri_io_example dut (
        .clk(clk),
        .oe(oe),
        .data_in(data_in),
        .data_out(data_out),
        .io_pin(io_pin)
    );

    // 클럭 생성 (10ns 주기)
    always #5 clk = ~clk;

    initial begin
        // 초기화
        clk = 0;
        oe = 0;
        data_in = 8'h00;
        external_data = 8'hAA;         // 외부에서 보낼 초기값
        external_drive_enable = 0;

        $display("Simulation Start");

        // Step 1: 외부 데이터를 DUT로 입력하는 테스트 (입력 모드)
        #10;
        external_drive_enable = 1;     // 외부가 io_pin을 구동 (입력 모드)
        external_data = 8'h55;         // 외부 데이터 설정

        #20;
        oe = 1;                        // DUT를 출력 모드로 전환
        external_drive_enable = 0;     // 외부 구동 중지
        data_in = 8'hF0;               // DUT에서 출력할 데이터 설정

        #20;
        oe = 0;                        // DUT를 입력 모드로 전환

        #20;
        external_drive_enable = 1;     // 다시 외부 데이터를 구동 (입력 모드)
        external_data = 8'hA5;         // 새로운 외부 데이터 설정

        #40;
        
        $display("Simulation End");
        $finish;
    end

    initial begin
        $dumpfile("tri_io_example_tb.vcd");
        $dumpvars(0, tri_io_example_tb);
    end

endmodule

