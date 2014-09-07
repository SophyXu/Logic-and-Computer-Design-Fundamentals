module regfile(wclk, rclk, address, data_in, data_out); 
input wire wclk,rclk; 
input wire [3:0]address; 
input wire [15:0]data_in; 
output wire [15:0]data_out; 
wire [15:0] Yi; 
wire [15:0] clk; 
assign clk[15:0] = {16{wclk}} & Yi; 
wire [15:0] regQ0,regQ1,regQ2,regQ3, 
regQ4,regQ5,regQ6,regQ7,regQ8,regQ9, 
regQ10,regQ11,regQ12,regQ13,regQ14,regQ15; 
decode_4_16 M0(address[3:0],wclk,Yi);//4-16ÒëÂëÆ÷
mux_16_1 M1(rclk, address[3:0], 
    regQ0, regQ1, regQ2, regQ3, 
    regQ4, regQ5, regQ6, regQ7, 
    regQ8, regQ9, regQ10,regQ11, 
    regQ12,regQ13,regQ14,regQ15, 
    data_out);//16-1:¶àÑ¡Ò»
register16 R0(clk[0], data_in, regQ0),//clk=wclk&Yi 
    R1(clk[1], data_in, regQ1), 
    R2(clk[2], data_in, regQ2), 
    R3(clk[3], data_in, regQ3), 
    R4(clk[4], data_in, regQ4), 
    R5(clk[5], data_in, regQ5), 
    R6(clk[6], data_in, regQ6), 
R7(clk[7], data_in, regQ7), 
    R8(clk[8], data_in, regQ8), 
    R9(clk[9], data_in, regQ9), 
    R10(clk[10], data_in, regQ10), 
    R11(clk[11], data_in, regQ11), 
    R12(clk[12], data_in, regQ12), 
    R13(clk[13], data_in, regQ13), 
    R14(clk[14], data_in, regQ14), 
    R15(clk[15], data_in, regQ15); 
endmodule 
