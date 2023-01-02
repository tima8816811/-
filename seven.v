`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:47:52 12/31/2022 
// Design Name: 
// Module Name:    seven 
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
module seven(
    input clk,
    input clr,
    input [3:0] ONES,TENS,HUNDREDS,THOUSANDS,
    input blink_o,blink_t,blink_h,blink_th,
    output reg [6:0] seg,       
    output reg [3:0] scanf      
    );
    reg [3:0] one;
    reg [3:0] ten;
    reg [3:0] hundred;
    reg [3:0] thousand;
    reg [1:0] scan;    
    reg [16:0] count;    
    
    
    always @(posedge clk or posedge clr) begin
        if(clr) begin
            scan <= 0;
            count <= 0; 
        end
        else                                     
            if(count == 99999) begin       //100MHz / 100,000 = 1000  1ms
                count <= 0;
                scan <=  scan + 1;
            end
            else
                count <=  count + 1;
    end
    
    always @(*) begin
        case(scan) 
            2'b00 :begin 
                if (blink_o) scanf = 4'b1110;
                else scanf = 4'b1111; end 
            2'b01 :begin 
                if (blink_t) scanf = 4'b1101;
                else scanf = 4'b1111; end   
            2'b10 :begin 
                if (blink_h) scanf = 4'b1011;  
                else scanf = 4'b1111; end  
            2'b11 :begin 
                if (blink_th) scanf = 4'b0111;   
                else scanf = 4'b1111; end  
        endcase
    end
    
    always @(*)
        case(scan)
            2'b00 : begin       
                        case(ONES)                       
                                4'h0: seg = 7'b0000001;
                                4'h1: seg = 7'b1001111;
                                4'h2: seg = 7'b0010010;
                                4'h3: seg = 7'b0000110;
                                4'h4: seg = 7'b1001100;
                                4'h5: seg = 7'b0100100;
                                4'h6: seg = 7'b0100000;
                                4'h7: seg = 7'b0001111;
                                4'h8: seg = 7'b0000000;
                                4'h9: seg = 7'b0000100;
                             default: seg = 7'b0000001;
                        endcase 
                    end
                    
            2'b01 : begin    
                        case(TENS)
                                4'h0: seg = 7'b0000001;
                                4'h1: seg = 7'b1001111;
                                4'h2: seg = 7'b0010010;
                                4'h3: seg = 7'b0000110;
                                4'h4: seg = 7'b1001100;
                                4'h5: seg = 7'b0100100;
                                4'h6: seg = 7'b0100000;
                                4'h7: seg = 7'b0001111;
                                4'h8: seg = 7'b0000000;
                                4'h9: seg = 7'b0000100;
                              default: seg = 7'b0000001;
                            endcase
                    end
                    
            2'b10 : begin     
                        case(HUNDREDS)
                                4'h0: seg = 7'b0000001;
                                4'h1: seg = 7'b1001111;
                                4'h2: seg = 7'b0010010;
                                4'h3: seg = 7'b0000110;
                                4'h4: seg = 7'b1001100;
                                4'h5: seg = 7'b0100100;
                                4'h6: seg = 7'b0100000;
                                4'h7: seg = 7'b0001111;
                                4'h8: seg = 7'b0000000;
                                4'h9: seg = 7'b0000100;
                              default: seg = 7'b0000001;
                            endcase                 
                    end
                    
            2'b11 : begin      
                            case(THOUSANDS)
                                4'h0: seg = 7'b0000001;
                                4'h1: seg = 7'b1001111;
                                4'h2: seg = 7'b0010010;
                                4'h3: seg = 7'b0000110;
                                4'h4: seg = 7'b1001100;
                                4'h5: seg = 7'b0100100;
                                4'h6: seg = 7'b0100000;
                                4'h7: seg = 7'b0001111;
                                4'h8: seg = 7'b0000000;
                                4'h9: seg = 7'b0000100;
                                4'hf: seg = 7'b1111110;
                              default: seg = 7'b0000001;
                            endcase           
                    end
        endcase
endmodule
