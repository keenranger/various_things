function hd = notch_2100
%UNTITLED 이산시간 필터 객체를 반환합니다.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and DSP System Toolbox 9.6.
% Generated on: 10-Jun-2019 21:41:24

% Equiripple Bandstop filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 8000;  % Sampling Frequency

Fpass1 = 2000;            % First Passband Frequency
Fstop1 = 2050;            % First Stopband Frequency
Fstop2 = 2150;            % Second Stopband Frequency
Fpass2 = 2200;            % Second Passband Frequency
Dpass1 = 0.028774368332;  % First Passband Ripple
Dstop  = 0.001;           % Stopband Attenuation
Dpass2 = 0.057501127785;  % Second Passband Ripple
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass1 Fstop1 Fstop2 Fpass2]/(Fs/2), [1 0 ...
                          1], [Dpass1 Dstop Dpass2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
hd = dfilt.dffir(b);

% [EOF]
