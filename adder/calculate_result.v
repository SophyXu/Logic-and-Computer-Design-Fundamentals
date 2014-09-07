module calculate_result(switch,op1,op2,result);
input [3:0] switch;
input [15:0] op1;
input [15:0] op2;
output reg [15:0] result;
wire [15:0]  add_sub_result;
adder_16bits m0(op1, op2, switch[1], add_sub_result, co);
always @(switch) begin
if(switch[0] ==1 || switch[1] == 1)  //拨动sw[0]~~SW[3]开关决定显示结果。
result = add_sub_result;
if(switch[2] == 1)
result = op1 & op2;
if(switch[3] == 1)
result = op1 | op2;
end
endmodule
