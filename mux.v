`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:19 12/31/2022 
// Design Name: 
// Module Name:    mux 
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
module mux(
input clk,clr,neg,
input [12:0] A,B,
input [12:0] sum_add,sum_sub,sum_mul,sum_neg,
input [5:0] state,
output reg [12:0] sum
);

localparam start = 5'd0;
localparam set_a = 5'd1;
localparam set_a_ten = 5'd2;
localparam set_a_hun = 5'd3;
localparam set_a_thun = 5'd4;
localparam set_b = 5'd5;
localparam set_b_ten = 5'd6;
localparam set_b_hun = 5'd7;
localparam set_b_thun = 5'd8;
localparam add = 5'd9;
localparam sub = 5'd10;
localparam s_sum = 5'd11;
localparam mul = 5'd12;
localparam alu = 5'd13;

always@(posedge clk or posedge clr)begin
    if (clr) sum<=0;
    
    else if ((state==set_a)||(state==set_a_ten)||(state==set_a_hun)||(state==set_a_thun)) sum<=A;
    
    else if ((state==set_b)||(state==set_b_ten)||(state==set_b_hun)||(state==set_b_thun)) sum<=B;
    
    else if ((state==add)) sum<=sum_add;
    
    else if ((state==sub)&&(neg)) sum<=sum_neg;
    
    else if ((state==sub)) sum<=sum_sub;
    
    else if ((state==mul)) sum<=sum_mul;
    
    else sum <= sum;
end 
endmodule