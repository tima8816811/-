`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:16 12/31/2022 
// Design Name: 
// Module Name:    control 
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
    module control(
    input clk,clr,Enter,U,LU,
    output reg [5:0] state,
    output reg rst,blink_o,blink_t,blink_h,blink_th
    );
    
    reg [5:0] next_state;
    reg [27:0] counter;
	 
    parameter S_start = 5'd0,
              S_set_a = 5'd1,
              S_set_a_ten = 5'd2,
              S_set_a_hun = 5'd3,
              S_set_a_thun = 5'd4,
              S_set_b = 5'd5,
              S_set_b_ten = 5'd6,
              S_set_b_hun = 5'd7,
              S_set_b_thun = 5'd8,
              S_add = 5'd9,
              S_sub = 5'd10,
              S_mul =5'd12,
              S_sum = 5'd11,
              S_alu = 5'd13,
              S_a_s = 5'd14,
              S_a_t_s = 5'd15,
              S_a_h_s = 5'd16,
              S_a_th_s = 5'd17,
              S_b_s = 5'd18,
              S_b_t_s = 5'd19,
              S_b_h_s = 5'd20,
              S_b_th_s = 5'd21;
              
    always @(posedge clk or posedge clr)
        begin
            if (clr)
                state <= S_start;
            else
                state <= next_state;
        end       
    
    always @(*)
        begin
            next_state = S_start;
            rst=0;
                case(state)
                    S_start:
                        if ((Enter)||(U)||(LU))begin
                            next_state = S_set_a;
                            rst=1;
                            end
                        else begin
                            next_state = S_start;
                            rst=1;
                            end    
                    S_set_a:     
                        if (Enter) begin
                            next_state = S_set_b;
                        end  
                        else if (LU)begin
                            next_state = S_a_s;
                            end
                        else begin
                            next_state = S_set_a;
                        end
                        
                    S_a_s:  next_state = S_set_a_ten;   
                                   
                    S_set_a_ten:
                        if (Enter) begin
                            next_state = S_set_b;
                        end  
                        else if (LU)begin
                            next_state = S_a_t_s;
                            end
                        else begin
                            next_state = S_set_a_ten;
                        end   
                        
                    S_a_t_s: next_state = S_set_a_hun;    
                    
                     S_set_a_hun:
                        if (Enter) begin
                            next_state = S_set_b;
                        end  
                        else if (LU)begin
                            next_state = S_a_h_s;
                            end
                        else begin
                            next_state = S_set_a_hun;
                        end
                        
                    S_a_h_s: next_state = S_set_a_thun;  
                       
                    S_set_a_thun:
                        if (Enter) begin
                            next_state = S_set_b;
                        end  
                        else if (LU)begin
                            next_state = S_a_th_s;
                            end
                        else begin
                            next_state = S_set_a_thun;
                        end 
                        
                    S_a_th_s: next_state = S_set_a;  
                                
                    S_set_b:     
                        if (Enter) begin
                            next_state = S_alu;
                        end  
                        else if (LU)begin
                            next_state = S_b_s;
                            end
                        else begin
                            next_state = S_set_b;
                        end
                        
                    S_b_s:  next_state = S_set_b_ten; 
                    
                    S_set_b_ten:
                        if (Enter) begin
                            next_state = S_alu;
                        end  
                        else if (LU)begin
                            next_state = S_b_t_s;
                            end
                        else begin
                            next_state = S_set_b_ten;
                        end   
                        
                     S_b_t_s: next_state = S_set_b_hun;   
                        
                     S_set_b_hun:
                        if (Enter) begin
                            next_state = S_alu;
                        end  
                        else if (LU)begin
                            next_state = S_b_h_s;
                            end
                        else begin
                            next_state = S_set_b_hun;
                        end
                        
                    S_b_h_s: next_state = S_set_b_thun;
                        
                    S_set_b_thun:
                        if (Enter) begin
                            next_state = S_alu;
                        end  
                        else if (LU)begin
                            next_state = S_b_th_s;
                            end
                        else begin
                            next_state = S_set_b_thun;
                        end      
                    
                    S_b_th_s: next_state = S_set_b;
                        
                    S_alu:
                        if ((U))begin 
                            next_state = S_add;
                            end   
                        else next_state = S_alu;
                    S_add:
                        if ((U))begin
                            next_state = S_sub;
                            end
                        else if (Enter)begin
                            next_state = S_sum;
                            end            
                        else  next_state = S_add;  
                    S_sub:
                        if ((U))begin
                            next_state = S_mul;
                            end  
                        else if (Enter)begin
                            next_state = S_sum;
                            end               
                        else  next_state = S_sub;
                    S_mul:
                        if ((U))begin
                            next_state = S_add;
                            end  
                        else if (Enter)begin
                            next_state = S_sum;
                            end               
                        else  next_state = S_mul;
                    S_sum:
                        if (Enter)begin
                            next_state = S_start;
                            end 
                        else  next_state = S_sum;          
            endcase
        end 
		  
always @ (posedge clk or posedge clr)
    begin
        if (clr) begin
            counter <= 0;
            blink_o <= 0; 
            blink_t <= 0;
            blink_h <= 0;
            blink_th <= 0;   
            end
        else if ((state == S_set_a)||(state == S_set_b))begin
            if (counter == 26'd50000001) begin
            counter <= 0;
            blink_o <= ~blink_o; end    
            else begin
                counter <= counter + 1;
                blink_o <= blink_o;
                end
            end 
        else if ((state == S_set_a_ten)||(state == S_set_b_ten))begin
            if (counter == 26'd50000001) begin
            counter <= 0;
            blink_t <= ~blink_t; end    
            else begin
                counter <= counter + 1;
                blink_t <= blink_t;
                end
            end
        else if ((state == S_set_a_hun)||(state == S_set_b_hun))begin
            if (counter == 26'd50000001) begin
            counter <= 0;
            blink_h <= ~blink_h; end    
            else begin
                counter <= counter + 1;
                blink_h <= blink_h;
                end
            end
        else if ((state == S_set_a_thun)||(state == S_set_b_thun))begin
            if (counter == 26'd50000001) begin
            counter <= 0;
            blink_th <= ~blink_th; end    
            else begin
                counter <= counter + 1;
                blink_th <= blink_th;
                end
            end
         else begin
            counter <= 0;
            blink_o <= 1; 
            blink_t <= 1;
            blink_h <= 1;
            blink_th <= 1;   
            end                 
    end   		  
    endmodule