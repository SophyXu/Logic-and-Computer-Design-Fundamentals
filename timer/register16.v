module  register16(cl, Di, Dot);//��R��D������
input wire cl;
input wire [15:0] Di;
output reg [15:0] Dot;
always @(posedge cl)
Dot <= Di;
endmodule 
