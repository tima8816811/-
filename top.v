`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:42:39 12/31/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
input clk,clr,ub,enter,
output [6:0] seg,       
output [3:0] scanf
);

wire [3:0] ONES, TENS,HUNDREDS,THOUSANDS;
wire [4:0] state;
wire [12:0] A,B;
wire [12:0] sum_add,sum_sub,sum,sum_mul,sum_neg;
wire rst,neg;
wire U,LU,Enter;
wire blink_o,blink_t,blink_h,blink_th;


db_short d1(
.clk(clk),
.clr(clr),
.ub(ub),
.U(U)
);

db_long d2(
.clk(clk),
.clr(clr),
.lu(ub),
.LU_o(LU)
);

db_short d3(
.clk(clk),
.clr(clr),
.ub(enter),
.U(Enter)
);

control c1(
.clk(clk),
.clr(clr),
.Enter(Enter),
.U(U),
.LU(LU),
.state(state),
.rst(rst),
.blink_o(blink_o),
.blink_t(blink_t),
.blink_h(blink_h),
.blink_th(blink_th)
);

Reg r1(
.state(state),
.clk(clk),
.clr(clr),
.U(U),
.LU(LU),
.A(A),
.B(B),
.rst(rst)
);

ALU a1(
.clk(clk),
.clr(clr),
.A(A),
.B(B),
.sum_add(sum_add),
.sum_sub(sum_sub),
.sum_mul(sum_mul),
.sum_neg(sum_neg),
.neg(neg),
.state(state)
);

mux m1(
.clk(clk),
.clr(clr),
.A(A),
.B(B),
.sum_add(sum_add),
.sum_sub(sum_sub),
.state(state),
.sum(sum),
.sum_mul(sum_mul),
.sum_neg(sum_neg),
.neg(neg)
);

binary_to_BCD b1(
.clk(clk),
.clr(clr),
.sum(sum),
.ONES(ONES),
.TENS(TENS),
.HUNDREDS(HUNDREDS),
.THOUSANDS(THOUSANDS),
.neg(neg)
);

seven s1(
.clk(clk),
.clr(clr),
.ONES(ONES),
.TENS(TENS),
.HUNDREDS(HUNDREDS),
.THOUSANDS(THOUSANDS),
.seg(seg),
.scanf(scanf),
.blink_o(blink_o),
.blink_t(blink_t),
.blink_h(blink_h),
.blink_th(blink_th)
);

endmodule
