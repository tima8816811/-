`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:56 01/02/2023 
// Design Name: 
// Module Name:    db_long 
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
module db_long(
input clk,clr,lu,
output reg LU_o);
 
 
	reg[31:0] count;	
	reg [5:0]clk_cnt;
	reg up_key_last;
	reg lu_o;
	reg last_key; 
	wire flag_up;
	wire flag_down; 
	
always @(posedge clk or posedge clr)
	begin
		if (clr)
		last_key <= 0;
		else last_key <= lu;
	end
 
assign flag_up = (~last_key) & lu; 	
assign flag_down = (~lu) & last_key; 	  

always @(posedge clk or posedge clr)
	begin 
		if (clr)
			count <= 32'd0;
		else if (lu== 1)
			count <= count +1'b1;
		else if (flag_down == 1) begin
			count <= 32'd0;
		end
		else count <= 32'd0;
	end

always @(posedge clk or posedge clr) 
begin
	if (clr)
			lu_o <= 0;
	else if (count >= 32'd79999_999)//1s
			 lu_o <= 1'b1;
	else if (count <= 32'd79999_999)
			 lu_o <= 1'b0;		
	else 	lu_o <= 1'b0; 
	end

always@(posedge clk or posedge clr) begin
		if(clr) begin
			clk_cnt <= 0;
			LU_o <= 0;
			up_key_last <= 0;				
		end	
		else begin
			if(clk_cnt == 5) begin
				clk_cnt <= 0;
				up_key_last <= lu_o;
				if(up_key_last == 0 && lu_o == 1)
					LU_o <= 1;
			end						
			else begin
				clk_cnt <= clk_cnt + 1;
				LU_o <= 0;
			end
		end	
	end		
	
endmodule
