function Hd = hamming_8tap_lp_fir
%HAMMING_8TAP_LP_FIR Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 7.12 and the Signal Processing Toolbox 6.15.
%
% Generated on: 30-Apr-2013 19:30:48
%

% FIR Window Lowpass filter designed using the FIR1 function.

% All frequency values are in kHz.
Fs = 200;  % Sampling Frequency

N    = 8;        % Order
Fc   = 2;        % Cutoff Frequency
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(b);

% [EOF]
