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
 

    // 테스트 시나리오
 

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
