/**************************************************
DATE:		2018.10.18
PROGRAMER:	cnst.deer
FUNCTION:	基础框架搭建

PROBLEM:	1.假设片内RC振荡器时钟为128k
			2.假设存在复位信号
			3.key_os 与 key_key 的优先级不明
***************************************************/


module led_top(
	clk,
	rst_n,
	key_os,
	key_key,
	
	led
);

input clk,rst_n,key_os,key_key;
output wire led;

wire clk,rst_n;
wire stable_os,stable_key;


//////////////////////////////////////////////////




//例化key_os
key_filter filter_os(
	.clk		(clk),
	.rst_n		(rst_n),
	.key		(key_os),
	
	.key_stable	(stable_os),
	.key_flag	(flag_os)
);



//例化key_key
key_filter filter_key(
	.clk		(clk),
	.rst_n		(rst_n),
	.key		(key_key),

	.key_stable	(stable_key),
	.key_flag	(flag_key)
);




//例化led功能模块
led_func led_func(
	.clk			(clk),
	.rst_n		(rst_n),
	.flag_os		(flag_os),
	.stable_os	(stable_os),
	.flag_key	(flag_key),
	.stable_key	(stable_key),

	.led		(led)
);

/////////////////////////////////////////////////////

endmodule 
