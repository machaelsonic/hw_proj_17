clc;
clear;
N = 256;
fft_data_in_file_path = 'e:\design\QUARTUS\plc_design_git\tb_fft_data_in.txt';
fft_data_out_file_path = 'e:\design\QUARTUS\plc_design_git\tb_fft_data_out_m.txt';

ifft_data_in_file_path = 'e:\design\QUARTUS\plc_design_git\tb_ifft_data_in.txt';
ifft_data_out_file_path = 'e:\design\QUARTUS\plc_design_git\tb_ifft_data_out_m.txt';

%% IFFT Data
% read data
data = load(ifft_data_in_file_path);
% format:
% [sop, eop], sink_real
row = size(data,1);
data = data(1:floor(row/N)*N,:);    % data 

% calc using altera fft model
[out_ifft, exp] = fft_ip_model(data(:,1),N,1);

% output 
out_ifft = out_ifft(:);

f = fopen(ifft_data_out_file_path,'w');
for i = 1:1:length(out_ifft)
    fprintf(f, '%10d%10d\n', real(out_ifft(i)), imag(out_ifft(i)));
end
fclose(f);



%% FFT Data
% read data
data = load(fft_data_in_file_path);
% format:
% [sop, eop], sink_real
row = size(data,1);
data = data(1:floor(row/N)*N,:);    % data 

% calc using altera fft model
[out, exp] = fft_ip_model(data(:,1),N,0);

% output 
out = out(:);

f = fopen(fft_data_out_file_path,'w');
for i = 1:1:length(out)
    fprintf(f, '%10d%10d\n', real(out(i)), imag(out(i)));
end
fclose(f);



