`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:50 12/31/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
input clk,clr,
input  [12:0] A,
input  [12:0] B,
input [5:0] state,
output reg neg,
output reg [12:0] sum_add,sum_sub,sum_mul,
output [12:0] sum_neg
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
localparam sum = 5'd11;
localparam mul = 5'd12;
localparam alu = 5'd13;


assign sum_neg = ~sum_sub+1'd1;

always@ (posedge clk or posedge clr) begin
    if (clr) neg<=0;
    else if ((state==sub)||(state==sum))begin
        if ((sum_sub[12])==1) neg<=1;end
        else neg<=0;
    end


always @(posedge clk or posedge clr)
    if(clr) begin
        sum_add <= 12'd0;
        sum_sub <= 12'd0;
        sum_mul <= 12'd0;
        end
    else if (state==add) sum_add<= A+B;
    else if (state==sub) sum_sub <= A-B;
    else if (state==mul) sum_mul <= A*B;
    
    else begin
        sum_add <= sum_add;
        sum_sub <= sum_sub;
        sum_mul <= sum_mul;
    end
    
endmodule