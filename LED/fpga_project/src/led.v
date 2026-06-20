module led(
    input Clock,
    output IO_voltage
);
// 创建一个模块

parameter count_value=13_499_999;
// 晶振为27kHz，故当计数13500000为0.5s

reg [23:0] count_value_reg;
reg count_value_flag;

always @(posedge Clock) begin
    if(count_value_reg<=count_value) begin
        count_value_reg<=count_value_reg+1'b1;
        count_value_flag<=1'b0;
    end
    else begin
        count_value_reg<=23'b0;
        count_value_flag<=1'b1;
    end
end
/* 当未满足计数条件时就计数加一，并令count_value_flag为0；
   当满足计数条件之后，就清空计数器并令count_value_flag为1*/

reg IO_voltage_reg=1'b0;

always @(posedge Clock) begin
    if(count_value_flag)
        IO_voltage_reg<=~IO_voltage_reg;
    else
        IO_voltage_reg<=IO_voltage_reg;
end
// 当count_value_flag为1的时候翻转状态位

assign IO_voltage=IO_voltage_reg;

endmodule