`timescale 1ns/1ps

module AHBTIMER_tb;

    // AHB-Lite 신호 선언
    reg HCLK;
    reg HRESETn;
    reg [31:0] HADDR;
    reg [31:0] HWDATA;
    reg [1:0] HTRANS;
    reg HWRITE;
    reg HSEL;
    reg HREADY;

    wire [31:0] HRDATA;
    wire HREADYOUT;
    wire timer_irq;

    // AHBTIMER 모듈 인스턴스화
    AHBTIMER uut (
        .HCLK(HCLK),
        .HRESETn(HRESETn),
        .HADDR(HADDR),
        .HWDATA(HWDATA),
        .HTRANS(HTRANS),
        .HWRITE(HWRITE),
        .HSEL(HSEL),
        .HREADY(HREADY),
        .HRDATA(HRDATA),
        .HREADYOUT(HREADYOUT),
        .timer_irq(timer_irq)
    );

    // 클럭 생성 (10ns 주기)
    initial begin
        HCLK = 0;
        forever #5 HCLK = ~HCLK; // 10ns 클럭 주기 (100MHz)
    end

    // 테스트 시나리오
    initial begin
        // 초기화 단계
        HRESETn = 0; // 리셋 활성화
        HADDR = 32'd0;
        HWDATA = 32'd0;
        HTRANS = 2'b00; // IDLE 상태
        HWRITE = 0;
        HSEL = 0;
        HREADY = 1;

        #20; // 리셋 유지 시간
        HRESETn = 1; // 리셋 비활성화

        // 타이머 로드값 설정
        #10;
        AHB_WRITE(32'h00000000, 32'd100); // LDADDR에 로드값 100 설정

        // 타이머 제어 레지스터 설정 (Enable, Free-running mode)
        #10;
        AHB_WRITE(32'h00000008, 32'b0001); // CTLADDR에 제어 값 설정 (Enable)

        // 타이머 동작 관찰
        #1100; // 타이머가 카운트다운하는 동안 대기

        $display("타이머 인터럽트 상태: %b", timer_irq);



        // 타이머 값 읽기
        AHB_READ(32'h00000004); // VALADDR에서 현재 값 읽기

        $finish; // 시뮬레이션 종료
    end

    // AHB 쓰기 작업 수행
    task AHB_WRITE(input [31:0] addr, input [31:0] data);
    begin
        @(posedge HCLK); 
        HADDR = addr;
        HWDATA = data;
        HTRANS = 2'b10; // NONSEQ 상태
        HWRITE = 1;
        HSEL = 1;

        @(posedge HCLK);
        HTRANS = 2'b00; // IDLE 상태
        HWRITE = 0;
        HSEL = 0;
    end
    endtask

    // AHB 읽기 작업 수행
    task AHB_READ(input [31:0] addr);
    begin
        @(posedge HCLK); 
        HADDR = addr;
        HTRANS = 2'b10; // NONSEQ 상태
        HWRITE = 0;
        HSEL = 1;

        @(posedge HCLK);
        $display("읽은 데이터 (HRDATA): %d", HRDATA);

        @(posedge HCLK);
        HTRANS = 2'b00; // IDLE 상태
        HSEL = 0;
    end
    endtask

endmodule
