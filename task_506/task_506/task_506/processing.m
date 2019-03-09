clear;clc;close;
%��������
fp=1/49;
fs=1;
delta_p=1-10^(log10(1-0.025)/3);%ͨ������ ��0.025/3�������һ���ģ�����Ӧ���������ʽ��
delta_s=0.002;%��С���˥�� 
M1=3;M2=3;M3=2;
M=M1*M2*M3;%18
%������
fs1=fs;
fs2=fs/M1;
fs3=fs/M1/M2;
%���Ƶ��
f_stop1=fs/M1-fs/(2*M);
f_stop2=fs/(M1*M2)-fs/(2*M);
f_stop3=fs/(2*M)

%first stage
f=[fp f_stop1];%ͨ���������ֹƵ��
a=[1 0];%ǰͨ���� 1��ʾͨ 0��ʾ��
dev=[delta_p delta_s];%ͨ�����������˥��
[order1,fpts,mag,wt]=firpmord(f,a,dev,fs1);
h1=firpm(order1,fpts,mag,wt);%�˲���ϵ��
[H1,w1]=freqz(h1,1);%Ƶ����Ӧ
figure(1)
subplot(2,1,1);
plot(w1*fs1/2/pi,20*log10(abs(H1)));%����Ƶ����ӦdB��ʾ
grid;%�ָ�
axis([0,fs1/2,-90,10]);%�����������ʾ��Χ
title('Amplitude frequency response of the first stage');   ylabel('Amplitude/dB')
subplot(2,1,2);
plot(w1*fs1/2/pi,unwrap(angle(H1))) %��λƵ����Ӧ  unwrap�ǽ�������
title('Phase frequency response of the first stage');      xlabel('Normalized frequency');    
%second stage
f=[fp f_stop2];
a=[1 0];
dev=[delta_p delta_s];
[order2,fpts,mag,wt]=firpmord(f,a,dev,fs2);
h2=firpm(order2,fpts,mag,wt);
[H2,w2]=freqz(h2,1);
figure(2)
subplot(2,1,1);
plot(w2*fs2/2/pi,20*log10(abs(H2)/max(abs(H2))));
grid;
axis([0,fs2/2,-90,10]);
set(gca,'xtick',0:100:2500);
title('Amplitude frequency response of the second stage');   ylabel('Amplitude/dB')
subplot(2,1,2);
plot(w2*fs2/2/pi,unwrap(angle(H2)))
title('Phase frequency response of the second stage');      xlabel('Normalized frequency');
%third stage
f=[fp f_stop3];
a=[1 0];
dev=[delta_p delta_s];
[order3,fpts,mag,wt]=firpmord(f,a,dev,fs3);
h3=firpm(order3,fpts,mag,wt);
[H3,w3]=freqz(h3,1);
figure(3)
subplot(2,1,1);
plot(w3*fs3/2/pi,20*log10(abs(H3)/max(abs(H3))));
grid;
axis([0,fs3/2,-90,10]);
set(gca,'xtick',0:100:2500);
title('Amplitude frequency response of the third stage');    ylabel('Amplitude/dB')
subplot(2,1,2);
plot(w3*fs3/2/pi,unwrap(angle(H3)))
title('Phase frequency response of the third stage');       xlabel('Normalized frequency');
