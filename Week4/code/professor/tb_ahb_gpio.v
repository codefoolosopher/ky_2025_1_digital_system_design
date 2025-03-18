`timescale 1ns/1ns
module tb_ahb_gpio;

    reg clk;
    reg reset_n;
    reg [31:0] addr;
    reg [31:0] wdata;
    reg write_enable;
    wire [31:0] rdata;
    reg [7:0] gpio_in;
    wire [7:0] gpio_out;

    ahb_gpio uut (
        .clk(clk),
        .reset_n(reset_n),
        .addr(addr),
        .wdata(wdata),
        .write_enable(write_enable),
        .rdata(rdata),
        .gpio_in(gpio_in),
        .gpio_out(gpio_out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;  // 클럭 생성 (10ns 주기)
    end

    initial begin
        reset_n = 1'b0;
        addr = 32'b0;
        wdata = 32'b0;
        write_enable = 1'b0;
        gpio_in = 8'b10101010;

        #10 reset_n = 1'b1;       // 리셋 해제

        #10 addr = 32'h53000008; wdata = 8'b11110000; write_enable = 1'b1; #10 write_enable = 1'b0; 
             // 방향 설정(출력)

        #10 addr = 32'h53000004; wdata = 8'b11001100; write_enable = 1'b1; #10 write_enable = 1'b0; 
             // 출력 데이터 설정

        #10 addr = 32'h53000000; write_enable = 1'b0; 
             $display("Input Data Read: %b", rdata[7:0]); 
             // 입력 데이터 확인

        #50 $stop;
    end

endmodule
