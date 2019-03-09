close all
freq=[0.01  0.0125 0.02 0.1 0.2 0.4];%用于测试的归一化频率 前三个是通带内的f<1/49 后三个是阻带的f>1/36
num=length(freq);                     %测试频率个数
for i=1:num                           %对每一个频率走一遍流程
n=1:8000;                             %采样点   8000个
x=18*sin(2*pi*freq(i)*n);              %输入正弦信号
N0=length(x);                         %输入信号长度
X=fft(x);                             %做fft 得到频谱
%Pass the first stage filter          %通过第一级滤波器并且降采样M1=3
y1=filter(h1,1,x);                    %通过滤波器                
y1=y1(1:M1:end);                      %降采样 每经过M1=3个点采一个点
Y1=fft(y1);                           %做fft 得到y1频谱
N1=length(y1);                        %长度
%Pass the second stage filter
y2=filter(h2,1,y1); 
y2=y2(1:M2:end);
Y2=fft(y2);
N2=length(y2);
%Pass the third stage filter;  finish the procedure
y3=filter(h3,1,y2);
y3=y3(1:M3:end);
Y3=fft(y3);
N3=length(y3);
%%
%%plot the spectrum of the input and output                   %绘图部分
figure(i)
%spectrum of the input                                        %输入的频谱图
subplot(4,1,1)
plot((-N0/2:N0/2-1)/N0,abs(fftshift(X))*2/N0)
str1=['Spectrogram of the input whose frequency is:',num2str(freq(i))]; 
 title(str1);   ylabel('Amplitude')
 
%spectrum of the output of the first stage                    %第一级降采样的频谱图
subplot(4,1,2)
plot((-N1/2:N1/2-1)/N1/M1,abs(fftshift(Y1))*2/N0)
title('Spectrogram of output of the first stage');  ylabel('Amplitude')

%spectrum of the output of the second stage                   %第二级降采样的频谱图
subplot(4,1,3) 
plot((-N2/2:N2/2-1)/N2/M1/M2,abs(fftshift(Y2))*2/N0)
title('Spectrogram of output of the second stage'); ylabel('Amplitude')

%spectrum of the output of the third stage                    %第三级降采样的频谱图
subplot(4,1,4)
plot((-N3/2:N3/2-1)/N3/M,abs(fftshift(Y3))*2/N0)
title('Spectrogram of output of the third stage');xlabel('Normalized frequency');  ylabel('Amplitude')
end