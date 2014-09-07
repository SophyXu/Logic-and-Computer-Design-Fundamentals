module TOP(clk,btn_in,digit_anode,segment); 
input    clk; 
input  [3:0] btn_in; 
output [3:0]   digit_anode; 
output [7:0]   segment; 
reg [15:0] disp_num; 
wire [3:0] btn_in,btn_out; 
initial disp_num=16’b1010_1011_1100_1101;//显示的初值
pbdebounce b0(clk, btn_in[0], btn_out[0]);//调用去抖动程序
pbdebounce b1(clk, btn_in[1], btn_out[1]); 
pbdebounce b2(clk, btn_in[2], btn_out[2]); 
pbdebounce b3(clk, btn_in[3], btn_out[3]);
//读取第一位开关的开闭状态，当开关打开时触发 
always@(posedge btn_out[0])
disp_num[ 3: 0]<= disp_num[ 3: 0] + 4’d1;//低4位加1 
//读取第二位开关的开闭状态，当开关打开时触发 
always@(posedge btn_out[1]) 
disp_num[ 7: 4]<= disp_num[ 7: 4] + 4’d1;//第2个4位加1 
//读取第三位开关的开闭状态，当开关打开时触发 
always@(posedge btn_out[2]) 
disp_num[11: 8]<= disp_num[11: 8] + 4’d1;//第3个4位加1 
//读取第四位开关的开闭状态，当开关打开时触发 
always@(posedge btn_out[3]) 
disp_num[15:12]<= disp_num[15:12]+ 4’d1;//高4位加1 
display m1(clk,disp_num,digit_anode,segment);//调用显示程序 
//(input wire clk, reset, 
//input wire [15:0] disp_num, // hex digits 
//input wire [3:0] dp_in, // 4 decimal points 
//output reg [3:0] an, // enable 1‐out‐of‐4 asserted low/ 
//output reg [7:0] sseg // led segments 
//); 
endmodule 
