module top(input  wire C, B, A, G, G2A, G2B,
           output wire Y);
wire [7:0] T;
decoder_3_8  INSTANCE(C, B, A, G, G2A,G2B, T);
assign Y = !( T[1] & T[2] & T[4] & T[7]); //����������������ذ��£�����
endmodule 
