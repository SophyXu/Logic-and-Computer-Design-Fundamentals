module m_gen_hour(clk_hour, clk_day, hour_low, hour_high);
input wire clk_hour;     //小时时钟
output reg clk_day;      //天时钟
output reg[3:0] hour_low, hour_high;    //小时低位/高位
always @(posedge clk_hour) begin
    clk_day=0;
	if (hour_low == 3 && hour_high == 2) 
	begin //23小时，再来一个小时时钟就进位为1天。
	        hour_low = 0;
	        hour_high = 0;
	        clk_day = 1;
	end else if (hour_low == 9) begin
	       hour_low = 0;      //小时低位为十进制
	       hour_high = hour_high + 1;
	end else
	        hour_low = hour_low + 1;
	end
endmodule 
