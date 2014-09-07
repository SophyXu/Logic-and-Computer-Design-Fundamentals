//top主函数
module top_10(
	input wire clk,
	input wire [11:0] btn_in,
	input wire [13:0] switch,
	output wire [11:0] anode,
	output wire [15:0] segment
		   );
reg [15:0] op1,op2;
reg  [15:0] display_num;
wire [11:0]  btn_out;
wire [15:0] result,cnt;
wire [31:0] display_num32b;
wire clk_1s;
wire [15:0] Q1,data_out;

initial  begin 
		op1=16'b0011_0011_0011_0011;//3333
		op2=16'b0010_0010_0010_0010;//2222
end
pbdebounce p0(clk,btn_in[0],btn_out[0]);
pbdebounce p1(clk,btn_in[1],btn_out[1]);
pbdebounce p2(clk,btn_in[2],btn_out[2]);
pbdebounce p3(clk,btn_in[3],btn_out[3]);
pbdebounce p4(clk,btn_in[4],btn_out[4]);
pbdebounce p5(clk,btn_in[5],btn_out[5]);
pbdebounce p6(clk,btn_in[6],btn_out[6]);
pbdebounce p7(clk,btn_in[7],btn_out[7]);
pbdebounce p8(clk,btn_in[8],btn_out[8]);
pbdebounce p9(clk,btn_in[9],btn_out[9]);
pbdebounce p10(clk,btn_in[10],btn_out[10]);//主扳上按健作为reg写入的CLK
pbdebounce p11(clk,btn_in[11],btn_out[11]);//主扳上按健作为reg读出的CLK

display m0(clk, display_num,anode[3:0], segment[7:0]); //display module
display32bits m1(clk,display_num32b,anode[11:4],segment[15:8]);

calculate_result m2(switch[3:0],op1, op2, result); //calculate result

counter_1s  m3(clk, clk_1s);  
couter_16reversible  m4(clk_1s&btn_out[8],switch[4],cnt,Rc);

//写入和读出寄存器函数
regfile   m7(btn_out[10],btn_out[11],switch[13:10], op2, data_out);

always @(posedge btn_out[0]) op1[ 3: 0]  <= op1[ 3: 0]  + 4'd1;
always @(posedge btn_out[1]) op1[ 7: 4]  <= op1[ 7: 4]  + 4'd1;
always @(posedge btn_out[2]) op1[ 11: 8] <= op1[ 11: 8] + 4'd1;
always @(posedge btn_out[3]) op1[ 15: 12]<= op1[15: 12] + 4'd1;
always @(posedge btn_out[4]) op2[ 3: 0]  <= op2[ 3: 0]  + 4'd1;
always @(posedge btn_out[5]) op2[ 7: 4]  <= op2[ 7: 4]  + 4'd1;
always @(posedge btn_out[6]) op2[ 11: 8] <= op2[ 11: 8] + 4'd1;
always @(posedge btn_out[7]) op2[ 15: 12]<= op2[15: 12] + 4'd1;

assign display_num32b={op2,op1};
//assign display_num=result;
always @* begin

case (switch[7:6])
2'b00: display_num = result; //result
2'b01: display_num = cnt;
2'b10: display_num = Q1;
2'b11: begin if (btn_out[10]==1) display_num = op2; else display_num = data_out;end
endcase

end
endmodule
