% rcv_data_gen.m
% Generate a data file for receiver
clc;
data = load('e:\design\QUARTUS\plc_design_git\matlab_sim\tb_tx_data.txt');
data = data.';

alpha = 0.5;
beta = 4;%1;

data = [zeros(1,1000),data,zeros(1,2500)];
data = round(alpha*data+beta*randn(size(data)));
plot(data);
save2file('e:\design\QUARTUS\plc_design_git\tb_rx_data_in.txt',data);