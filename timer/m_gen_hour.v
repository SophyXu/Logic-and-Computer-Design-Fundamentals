module m_gen_hour(clk_hour, clk_day, hour_low, hour_high);
input wire clk_hour;     //Сʱʱ��
output reg clk_day;      //��ʱ��
output reg[3:0] hour_low, hour_high;    //Сʱ��λ/��λ
always @(posedge clk_hour) begin
    clk_day=0;
	if (hour_low == 3 && hour_high == 2) 
	begin //23Сʱ������һ��Сʱʱ�Ӿͽ�λΪ1�졣
	        hour_low = 0;
	        hour_high = 0;
	        clk_day = 1;
	end else if (hour_low == 9) begin
	       hour_low = 0;      //Сʱ��λΪʮ����
	       hour_high = hour_high + 1;
	end else
	        hour_low = hour_low + 1;
	end
endmodule 
