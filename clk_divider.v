`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:27 01/13/2011 
// Design Name: 
// Module Name:    clk_divider 
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
//  parameter toggle_value = 25'b1011111010111100001000000;
	 

//////////////////////////////////////////////////////////////////////////////////
module clk_divider(
	input clk_in,
	input rst,
	output reg divided_clk
    );


// parameter toggle_value = 10'd2047;	 
// reg [10:0] cnt;

parameter toggle_value = 3000000;
reg[24:0] cnt;

always@(posedge clk_in or posedge rst)
begin
	if (rst==1) begin
		cnt <= 0;
		divided_clk <= 0;
	end
	else begin
		if (cnt==toggle_value) begin
			cnt <= 0;
			divided_clk <= ~divided_clk;
		end
		else begin
			cnt <= cnt +1;
			divided_clk <= divided_clk;		
		end
	end

end
	

endmodule
