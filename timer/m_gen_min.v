//���ӵ�������������Ϊʱ���źţ���10���ƺ�6������ϳ�60���ƣ�������Сʱ��//���źš�
module m_gen_min(clk_min,clk_hour,min_low,min_high);
input wire clk_min;
output reg clk_hour=0;
output reg[3:0] min_low=0, min_high=0;   //���ӵ�λ�����Ӹ�λ
reg [15:0] cnt=0;
always @(posedge clk_min) begin
     if (min_low == 9) begin
	begin min_low = 0;clk_hour=0;end /* base 10 */
         if (min_high == 5) begin
	min_high = 0; /* base 6 */
	clk_hour = 1;
        end else
	 min_high = min_high + 1;
						
        end else
	min_low = min_low + 1;
     end
endmodule 
