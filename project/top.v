module top(
input wire clk,
input wire [11:0] btn_in,
input wire [9:0] switch,
output wire [11:0] anode,
output wire [15:0] segment);

reg  [15:0] display_num;
reg  [31:0] disp_num;
reg  [31:0] num;
wire [11:0] btn_out;
wire [1:0] spe;
wire clk_1s, clk_ns;
wire dir;

initial begin
	disp_num = 32'b0001_0010_0011_0100_0101_0110_0111_1000;	//拓展板的8个数码管默认显示的数值为12345678 
	display_num = 16'h0000; //主板上4个数码管默认显示为0000
end

//修改8个数码管数值的按钮去抖动模块
pbdebounce p0(clk,btn_in[0],btn_out[0]);
pbdebounce p1(clk,btn_in[1],btn_out[1]);
pbdebounce p2(clk,btn_in[2],btn_out[2]);
pbdebounce p3(clk,btn_in[3],btn_out[3]);
pbdebounce p4(clk,btn_in[4],btn_out[4]);
pbdebounce p5(clk,btn_in[5],btn_out[5]);
pbdebounce p6(clk,btn_in[6],btn_out[6]);
pbdebounce p7(clk,btn_in[7],btn_out[7]);
pbdebounce p8(clk,btn_in[8],btn_out[8]);

assign spe   = switch[9:8]; //速度
assign dir   = switch[0];   //方向
assign blink = switch[1];	 //闪烁
assign shift = switch[2]; 	 //移位
assign roll  = switch[3];	 //滚动
assign wave  = switch[4];   //波动
assign reset = switch[5];	 //重置


always@ (posedge clk) begin
	display_num[3:0]   <= spe;		//速度显示
	display_num[7:4]   <= 15-dir; //方向显示
	display_num[11:8]  <= blink;  //闪烁显示
	display_num[15:12] <= shift;  //移位显示
end

timer_ns t0(clk, clk_1s, spe); //获取速度时钟

display16bits d1(clk, display_num, anode[3:0], segment[7:0]);	//主板4个数码管显示参数

display32bits d0(clk, clk_1s, disp_num, anode[11:4], segment[15:8], blink, roll, dir); //拓展板8个数码管显示数值


	always@ (posedge clk_1s) begin
		if(reset)	  //是否重置数值
			disp_num <= 32'h1234_5678;
		else if(shift) begin  //是否移位
			if(dir)  //判断移位方向
				disp_num <= {disp_num[27:0], disp_num[31:28]};	//移位
			else
				disp_num <= {disp_num[3:0], disp_num[31:4]};
		end 
		else if(wave) begin  //是否波动
					disp_num <= 32'hdefe_defe;
	   end else begin
			if(btn_out[0])	disp_num[3:0]   <= disp_num[3:0] + 4'd1;
			if(btn_out[1])	disp_num[7:4]   <= disp_num[7:4] + 4'd1;
			if(btn_out[2])	disp_num[11:8]  <= disp_num[11:8] + 4'd1;
			if(btn_out[3])	disp_num[15:12] <= disp_num[15:12] + 4'd1;
			if(btn_out[4])	disp_num[19:16] <= disp_num[19:16] + 4'd1;
			if(btn_out[5])	disp_num[23:20] <= disp_num[23:20] + 4'd1;
			if(btn_out[6])	disp_num[27:24] <= disp_num[27:24] + 4'd1;
			if(btn_out[7])	disp_num[31:28] <= disp_num[31:28] + 4'd1;
		end
	end

endmodule
