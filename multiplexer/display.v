module display(
input wire        clk,
input wire [15:0] digit,//��ʾ������ 
output reg [ 3:0] node, //4������ܵ�λѡ 
output reg [ 7:0] segment);//�߶�+С���� 
reg [3:0]  code  =  4��b0;
reg [15:0] count = 15��b0;
always @(posedge clk) begin
    case (count[15:14])
   //�𵽷�Ƶ�����ã���ȡcount�����ĵ�14��15λ 
        2��b00 : begin                        //������λΪ00
            node <= 4��b1110;                //��һλ�������
            code <= digit[3:0];            //����Ҫ��ʾ�����ָ�ֵ
            end
        2��b01 : begin                       //������λΪ01
            node <= 4��b1101;                //�ڶ�λ�������
            code <= digit[7:4];
            end
        2��b10 : begin                       //������λΪ10
            node <= 4��b1011;                //����λ�������
            code <= digit[11:8];
            end
        2��b11 : begin                       //������λΪ11
            node <= 4��b0111;                //����λ�������
            code <= digit[15:12];
            end
    endcase 
    case (code)                          //��8��LED��ʾ1~9��A~F
        4��b0000: segment <= 8��b11000000;
        4��b0001: segment <= 8��b11111001;
        4��b0010: segment <= 8��b10100100;
        4��b0011: segment <= 8��b10110000;
        4��b0100: segment <= 8��b10011001;
        4��b0101: segment <= 8��b10010010;
        4��b0110: segment <= 8��b10000010;
        4��b0111: segment <= 8��b11111000;
        4��b1000: segment <= 8��b10000000;
        4��b1001: segment <= 8��b10010000;
        4��b1010: segment <= 8��b10001000;
        4��b1011: segment <= 8��b10000011;
        4��b1100: segment <= 8��b11000110;
        4��b1101: segment <= 8��b10100001;
        4��b1110: segment <= 8��b10000110;
        4��b1111: segment <= 8��b10001110;
        default: segment <= 8��b00000000;
    endcase 
    count <= count + 1;                           //����count+1����
end
endmodule 
