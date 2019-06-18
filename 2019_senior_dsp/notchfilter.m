%% Read the file
clear all;
close all;

[f,fs] = audioread('projectDSP.wav');
% sound(f,fs);

%% Plot audio channel
N = size(f,1);
t=1:N;  
figure
plot(t, f);
title('Original signal');
% audiowrite('originsample.wav', f, fs)

%% Plot Frequency plots -> 2100 & 3300 +-50
df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f, N) / N; %//For normalizing, but not needed for our analysis
y2 = fftshift(y);
figure;
w2=w(N/2:N);
y3=y2(N/2:N);
plot(w2,abs(y3));
xlim([0 4000]);
title('Frequency Domain');
grid; 

%% Design a notch filter without 2100
d1=notch_2100;

%% Plot a notch filter Magnitude and Response
[h,w]=freqz(d1, fs);
phi=180*unwrap(angle(h))/pi;
figure
subplot(2,1,1), plot(w,abs(h)),grid; xlabel('Frequency (radians)'), ylabel('Magnitude');
subplot(2,1,2), plot(w,phi),grid; xlabel('Frequency (radians)'), ylabel('Phase (degrees)');
title('Frequency vs magnitude/phase Responses');
%% Design a notch filter without 3300
d2=notch_3300;

%% Plot a notch filter Magnitude and Response
[h,w]=freqz(d2, fs);
phi=180*unwrap(angle(h))/pi;
figure
subplot(2,1,1), plot(w,abs(h)),grid; xlabel('Frequency (radians)'), ylabel('Magnitude');
subplot(2,1,2), plot(w,phi),grid; xlabel('Frequency (radians)'), ylabel('Phase (degrees)');
title('Frequency vs magnitude/phase Responses');
%% Filter the signal
nf1 = filter(d1, f);
nf2 = filter(d2, nf1);

figure
plot(t, nf2);
nf2= nf2*20;
title('Bandpassed signal');
audiowrite('bandpass.wav', nf2, fs)

df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(nf2, N) / N; %//For normalizing, but not needed for our analysis
y2 = fftshift(y);
figure
w2=w(N/2:N);
y3=y2(N/2:N);
plot(w2,abs(y3));
xlim([0 4000]);
title('Bandpass Frequency Domain');
grid; 
%% Filter the signal(1D Median filter)
med=medfilt1(nf2,5);
figure
plot(t,med);
title('Median signal');

df = fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(med, N) / N; %//For normalizing, but not needed for our analysis
y2 = fftshift(y);
figure
w2=w(N/2:N);
y3=y2(N/2:N);
plot(w2,abs(y3));
xlim([0 4000]);
title('Median Frequency Domain');
grid; 
%% Save Enhanced signal
% soundsc(med, fs);
audiowrite('median.wav', med, fs)

