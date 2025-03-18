`timescale 1ns / 1ps
//structural_model.v
module fa_8 (
    input [7:0] x,  // 8bit vertor형 
    input [7:0] y,
    input cin,
    output [7:0] s,
    output carry
);

    // code를 완성하시오
    wire temp;
    fa_4 U_fa4_0 (
        .x(x[3:0]),  // 4bit vertor형 
        .y(y[3:0]),
        .cin(cin),
        .s(s[3:0]),
        .carry(temp)
    );

    fa_4 U_fa4_1 (
        .x(x[7:4]),  // 4bit vertor형 
        .y(y[7:4]),
        .cin(temp),
        .s(s[7:4]),
        .carry(carry)
    );

endmodule
module fa_4 (
    input [3:0] x,  // 4bit vertor형 
    input [3:0] y,
    input cin,
    output [3:0] s,
    output carry
);
    wire [3:0] w_c;
    full_adder U_fa0 (
        .x(x[0]),
        .y(y[0]),
        .cin(1'b0),
        .sum(s[0]),
        .carry(w_c[0])
    );
    full_adder U_fa1 (
        .x(x[1]),
        .y(y[1]),
        .cin(w_c[0]),
        .sum(s[1]),
        .carry(w_c[1])
    );
    full_adder U_fa2 (
        .x(x[2]),
        .y(y[2]),
        .cin(w_c[1]),
        .sum(s[2]),
        .carry(w_c[2])
    );
    full_adder U_fa4 (
        .x(x[3]),
        .y(y[3]),
        .cin(w_c[2]),
        .sum(s[3]),
        .carry(carry)
    );
endmodule

module full_adder (
    input  x,
    input  y,
    input  cin,
    output sum,
    output carry
);

    wire temp1, temp2, temp3;
    ha u0 (
        .a(x),
        .b(y),
        .c(temp1),
        .s(temp2)
    );
    ha u1 (
        .a(temp2),
        .b(cin),
        .c(temp3),
        .s(sum)
    );
    or_2 u2 (
        .a(temp1),
        .b(temp3),
        .c(carry)
    );
endmodule

//half adder
module ha (
    input  a,
    input  b,
    output c,
    output s
);
    assign c = a & b;
    assign s = a ^ b;
endmodule

// 2input or
module or_2 (
    input  a,
    input  b,
    output c
);
    assign c = a | b;
endmodule
