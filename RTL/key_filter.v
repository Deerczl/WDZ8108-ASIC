/**************************************************
DATE:		2018.10.18
PROGRAMER:	cnst.deer
FUNCTION:	按键滤波

TIPS:		假设片内RC振荡器时钟为200k
			按键按下(/松开)100ms以上确认按键状态改变
			按键按下时输出key_flag为0
***************************************************/



module key_filter(
	clk,
	rst_n,
	key,
	
	key_stable,
	key_flag
);

input clk,rst_n,key;
output reg key_flag,key_stable;

	
//////////////////////////////////////////	
/*			上升/下降沿判断				*/
reg [2:0]key_r;
wire po_key,ne_key;

always@ (posedge clk) 
	key_r <= {key_r[1:0],key};
	
assign po_key = ( key_r[1] && (!key_r[2]) );
assign ne_key = ( (!key_r[1]) && key_r[2]);

/////////////////////////////////////////
	
	
	
	
	
/////////////////////////////////////////
/*		100ms encounter with port 'en'	*/
/* 		200k -> 100ms --> 20k-1			*/
reg [14:0] cnt;
reg en_cnt;
always @(posedge clk) begin 
	if ( !rst_n ) begin 
		cnt <= 15'd0; end 
	else if ( (cnt == 15'h4e1f) ||(!en_cnt) ) begin
		cnt <= 15'd0; end 
	else if ( en_cnt )begin 
		cnt <= cnt + 1'b1; end  
end 
/////////////////////////////////////////





/////////////////////////////////////////
/*			FSM of filter of key		*/
	
reg [1:0]state;
parameter IDLE  = 2'b00;
parameter W_LOW = 2'b01;
parameter W_HIG = 2'b11;
parameter S_HIG = 2'b10;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		key_flag <= 1'b1;
		state <= IDLE;
		en_cnt <= 1'b0; end 
	else begin 
		case (state) 
	
			IDLE: begin
				key_stable <= 1'b0;
				if (ne_key) begin 
					state <= W_LOW;
					en_cnt <= 1'b1;
				end
				else begin  
					state <= IDLE;
				end 
			end 
				
			W_LOW: begin
				if ( cnt >= 20_000-1 ) begin 
					en_cnt <= 1'b0;
					state <= W_HIG;
					key_stable <= 1'b1;
					key_flag <= 1'b0;
				end
				else begin  
					if (po_key) begin
						state <= IDLE;
						en_cnt <= 1'b0;
					end 
					else 
						state <= W_LOW; 
				end 
			end
			
			W_HIG: begin
				key_stable <= 1'b0;
				if (po_key) begin 
					state <= S_HIG;
					en_cnt <= 1'b1;
				end
				else begin  
					state <= W_HIG;
				end  
			end 
				
			S_HIG: begin
				if ( cnt >= 20_000-1 ) begin 
					en_cnt <= 1'b0;
					state <= IDLE;
					key_stable <= 1'b1;
					key_flag <= 1'b1;
				end
				else begin  
					if (ne_key) begin
						state <= W_HIG;
						en_cnt <= 1'b0;
					end 
					else begin  
						state <= S_HIG;
					end 
				end 
			end
			
			default: begin
				state <= IDLE; 
				key_flag <= 1'b1;
				en_cnt <= 1'b0;
			end 
		endcase
	end 
end 
/////////////////////////////////////////


endmodule 