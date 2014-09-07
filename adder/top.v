module top(input wire clk, input wire [7:0]btn_in, input wire
[3:0]switch, output wire [11:0]anode, output wire [15:0]segment);
//variable definition: op1, op2,disp_num…
reg [15:0] op1,op2;
wire [15:0] display_num;
wire [7:0]  btn_out;
wire[15:0] result;
wire [31:0] display_num32b;
initial  begin 
op1=16'b0011_0011_0011_0011;//3333
op2=16'b0010_0010_0010_0010;//2222
End
pbdebounce p0(clk,btn_in[0],btn_out[0]);//去抖程序
pbdebounce p1(clk,btn_in[1],btn_out[1]);
pbdebounce p2(clk,btn_in[2],btn_out[2]);
pbdebounce p3(clk,btn_in[3],btn_out[3]);
pbdebounce p4(clk,btn_in[4],btn_out[4]);
pbdebounce p5(clk,btn_in[5],btn_out[5]);
pbdebounce p6(clk,btn_in[6],btn_out[6]);
pbdebounce p7(clk,btn_in[7],btn_out[7]);
display m0(clk,display_num,anode[3:0], segment[7:0]);      
//原16位显示程序
display32bits m1(clk,display_num32b,anode[11:4],segment[15:8]);//32位显示程序
calculate_result m2(switch,op1, op2, result);        //运算值
always @(posedge btn_out[0])op1[ 3: 0]  <= op1[ 3: 0]  + 4'd1;
//操作数4位+1
always @(posedge btn_out[1]) op1[ 7: 4]  <= op1[ 7: 4]  + 4'd1;
always @(posedge btn_out[2]) op1[ 11: 8] <= op1[ 11: 8] + 4'd1;
always @(posedge btn_out[3]) op1[ 15: 12]<= op1[15: 12] + 4'd1;
always @(posedge btn_out[4]) op2[ 3: 0]  <= op2[ 3: 0]  + 4'd1;
always @(posedge btn_out[5]) op2[ 7: 4]  <= op2[ 7: 4]  + 4'd1;
always @(posedge btn_out[6]) op2[ 11: 8] <= op2[ 11: 8] + 4'd1;
always @(posedge btn_out[7]) op2[ 15: 12]<= op2[15: 12] + 4'd1;
assign display_num32b={op2,op1};//操作数2,1合成32位数据。
assign display_num=result;
endmodule
