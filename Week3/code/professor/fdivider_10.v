`timescale 1ns / 1ps
//fdivider_10.v
module freq_divider_by_10 #(
    parameter DIVISOR = 10
)(
    input wire clk_in,
    input wire reset,
    output reg clk_out
);

    localparam WIDTH = $clog2(DIVISOR);
    reg [WIDTH-1:0] count;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_out <= 1'b0;
        end else begin
            if (count == DIVISOR - 1) begin
                count <= 0;
            end else begin
                count <= count + 1'b1;
            end
            
            // DIVISOR의 절반에 도달할 때마다 출력 토글
            if (count == (DIVISOR / 2) - 1) begin
                clk_out <= 1'b1;
            end else if (count == DIVISOR - 1) begin
                clk_out <= 1'b0;
            end
        end
    end

endmodule
