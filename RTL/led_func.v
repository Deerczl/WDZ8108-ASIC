/**************************************************
DATE:		2018.10.18
PROGRAMER:	cnst.deer
FUNCTION:	LED功能模块

TIPS:	0. LED 输出为0时点亮 
		1. key_os	--> 触发一次LED亮525s，期间不被重复触发
		2. key_key	--> ON/OFF功能，上电OFF
***************************************************/

`timescale 1us/1us

module led_func(
	clk,
	rst_n,
	flag_os,
	stable_os,
	flag_key,
	stable_key,
	
	led
);


input clk,rst_n,flag_os,flag_key;
input stable_os,stable_key;
output wire led;
	
	
//////////////////////////////////////////	
/*		FSM of funtions of led			*/
reg [1:0]ledstate;
reg en_cnt,cnt_full;
reg flag,led_r;

parameter IDLE = 2'b00;
parameter KEY  = 2'b01;
parameter OS   = 2'b11;

always @(posedge clk or negedge rst_n) begin
	if( !rst_n ) begin 
		led_r <= 1'b0;
		flag <= 1'b0;
		en_cnt <= 1'b0;
		ledstate <= IDLE; end 
	else begin 
		case (ledstate) 
			IDLE: begin
				led_r <= led_r;
				
				if ( (!flag_key) && (stable_key) ) begin
					ledstate <= KEY;
				end 
				else begin  
					if ( (!flag_os) && (stable_os) && (!flag) )
						ledstate <= OS;
					else 
						ledstate <= IDLE;
				end 
			end 
			
			KEY: begin
				if(flag) begin 
					led_r <= 1'b1;
					flag <= ~flag;
					end 
				else begin
					led_r <= 1'b0;
					flag <= ~flag;
				end 
				ledstate <= IDLE;
			end 
		
			OS	: begin 
					en_cnt <= 1'b1;
					led_r <= 1'b1;
					/* 200k->525s --> 200k*525=105_000_000 */
					if (cnt_full) begin
						en_cnt <= 1'b0;
						ledstate <= IDLE;
						led_r <= 1'b0;
					end
					else 
					ledstate <= OS;		
			end 
			
			default:begin
				en_cnt <= 1'b0;
				ledstate <= IDLE;
				led_r <= 1'b0;
				flag <= 1'b0;
			end
		
		endcase 
	end 
end 


reg [6:0] cnt_1,cnt_2,cnt_3;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt_1 <= 7'h00; cnt_2 <= 7'h00; cnt_3 <= 7'h00; cnt_full <= 1'b0;end 
	else if (!en_cnt) begin
			cnt_1 <= 7'h00; cnt_2 <= 7'h00; cnt_3 <= 7'h00; cnt_full <= 1'b0; end 
		else if (cnt_1 < 7'h64) begin 
			cnt_1 <= cnt_1 + 1'b1; cnt_full <= 1'b0; end 
			else if (cnt_2 < 7'h64) begin
				cnt_1 <= 7'h00; cnt_2 <= cnt_2 + 1'b1; cnt_full <= 1'b0; end 
				else if (cnt_3 < 7'h69) begin
					cnt_1 <= 7'h00; cnt_2 <= 7'h00; cnt_3 <= cnt_3 + 1'b1; cnt_full <= 1'b0; end
					else begin
						cnt_full <= 1'b1; cnt_1 <= 7'h00; cnt_2 <= 7'h00; cnt_3 <= 7'h00; end 		
end 


//////////////////////////////////////////


assign led = (~led_r);

endmodule 
