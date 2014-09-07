module timer_1s(input wire clk, output reg clk_1ms);
	reg [31:0] cnt;

	initial begin
		cnt [31:0] <=0;
		clk_1ms <= 0;
	end

	always@(posedge clk) begin
		if(cnt>=25000000) begin
			cnt<=0;
			clk_1ms <= ~clk_1ms;
		end
		else begin
			cnt<=cnt+1;
		end
	end

endmodule
