//��ģ�����ڻ�ȡ�ض�ʱ��Ƶ�ʣ����Ϊ�ٶ�ʱ��
module timer_ns(input wire clk, output reg clk_1ms, input [1:0] spe);
	
	reg [31:0] cnt;
	reg [31:0] rep;

	initial begin
		cnt [31:0] <=0;
		clk_1ms <= 0;
	end

	always@(posedge clk) begin
	
		case(spe)  //�����ٶȿ��ص�״̬ȷ�����ʱ�ӵ�Ƶ��
			2'b00:begin
				rep <= 25000000;  //1HZ
			end
			2'b01:begin
				rep <= 12500000;  //2HZ
			end
			2'b10:begin
				rep <=  6250000;  //4HZ
			end
			2'b11:begin
				rep <=  3125000;  //8HZ
			end
		endcase
	
		if(cnt>=rep) begin
			cnt<=0;
			clk_1ms <= ~clk_1ms;
		end
		else begin
			cnt<=cnt+1;
		end
		
	end

endmodule
