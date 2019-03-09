close all
freq=[0.01  0.0125 0.02 0.1 0.2 0.4];%���ڲ��ԵĹ�һ��Ƶ�� ǰ������ͨ���ڵ�f<1/49 �������������f>1/36
num=length(freq);                     %����Ƶ�ʸ���
for i=1:num                           %��ÿһ��Ƶ����һ������
n=1:8000;                             %������   8000��
x=18*sin(2*pi*freq(i)*n);              %���������ź�
N0=length(x);                         %�����źų���
X=fft(x);                             %��fft �õ�Ƶ��
%Pass the first stage filter          %ͨ����һ���˲������ҽ�����M1=3
y1=filter(h1,1,x);                    %ͨ���˲���                
y1=y1(1:M1:end);                      %������ ÿ����M1=3�����һ����
Y1=fft(y1);                           %��fft �õ�y1Ƶ��
N1=length(y1);                        %����
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
%%plot the spectrum of the input and output                   %��ͼ����
figure(i)
%spectrum of the input                                        %�����Ƶ��ͼ
subplot(4,1,1)
plot((-N0/2:N0/2-1)/N0,abs(fftshift(X))*2/N0)
str1=['Spectrogram of the input whose frequency is:',num2str(freq(i))]; 
 title(str1);   ylabel('Amplitude')
 
%spectrum of the output of the first stage                    %��һ����������Ƶ��ͼ
subplot(4,1,2)
plot((-N1/2:N1/2-1)/N1/M1,abs(fftshift(Y1))*2/N0)
title('Spectrogram of output of the first stage');  ylabel('Amplitude')

%spectrum of the output of the second stage                   %�ڶ�����������Ƶ��ͼ
subplot(4,1,3) 
plot((-N2/2:N2/2-1)/N2/M1/M2,abs(fftshift(Y2))*2/N0)
title('Spectrogram of output of the second stage'); ylabel('Amplitude')

%spectrum of the output of the third stage                    %��������������Ƶ��ͼ
subplot(4,1,4)
plot((-N3/2:N3/2-1)/N3/M,abs(fftshift(Y3))*2/N0)
title('Spectrogram of output of the third stage');xlabel('Normalized frequency');  ylabel('Amplitude')
end