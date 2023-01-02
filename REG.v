`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:49 12/31/2022 
// Design Name: 
// Module Name:    Reg 
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
module Reg(
input [5:0] state,
input clk,clr,U,LU,rst,
output reg [12:0] A,B
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
    if (clr)begin
        A<=0;
        B<=0;
    end
	 else if (rst)begin
        A<=0;
        B<=0;
    end
    else if ((state==set_a))begin
        if (U)begin
            A<=A+13'd1;end 
        else A <= A;      
    end
    else if ((state==set_a_ten))begin
        if (U)begin
            A<=A+13'd10;end
        else A <= A; 
         end   
    else if ((state==set_a_hun))begin
        if (U)begin
            A<=A+13'd100;end
        else A <= A;   
    end     
    else if ((state==set_a_thun))begin
        if (U)begin
            A<=A+13'd1000;end
        else A <= A;   
    end    
    else if ((state==set_b))begin
        if (U)begin
            B<=B+13'd1;end 
        else B <= B;      
    end
    else if ((state==set_b_ten))begin
        if (U)begin
            B<=B+13'd10;end
        else B <= B; 
         end   
    else if ((state==set_b_hun))begin
        if (U)begin
            B<=B+13'd100;end
        else B <= B;   
    end     
    else if ((state==set_b_thun))begin
        if (U)begin
            B<=B+13'd1000;end
        else B <= B;   
    end  
end

endmodule
