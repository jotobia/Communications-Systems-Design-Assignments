clear;
clc;
% https://lpsa.swarthmore.edu/Fourier/Series/ExFS.html
%Initials : JT ... J = 10, T = 20
%300 ms High then 700 ms Low

numHarmonics = 100;                              %number of harmonics in plot
To = 1;                                         %period of 1 sec
wo = 2 * pi / To;                               %omega naught
d = .3;                                         %dutyCycle
A = 1;                                          %amplitude of 1

an = 0:numHarmonics;                            %makes a blank 1x21 matrix 
an(1,1) = d * A;                                %an(1,1) = ao = A * d
%an = 2 * A / (n*pi) * sin(n*pi*d);
for n = 1:+1:numHarmonics
   an(1,n+1) = 2*A/(pi*n)*sin(d*pi*n);
end
%==========================================================================
%x(t) = an*cos(n*wo*t) ***from n=0 to inf
syms fourierWaveform(t)                         
fourierWaveform(t) = an(1,1);
for n = 1:+1:numHarmonics
   fourierWaveform(t) = fourierWaveform(t) + an(1,1+n)*cos(n*wo*t);
end

%power / parseval power calculations
power = abs(int((A*A),t,-d/2,d/2))/To

parsevalPower = an(1,1)*an(1,1);
for n = 1:+1:numHarmonics
   parsevalPower = parsevalPower + (an(1,1+n))*(an(1,1+n));
end
parsevalPower
%==========================================================================
figure(1);
fplot (fourierWaveform(t) )
title('Fourier Representation of Signal')
xlabel('time (ms)') 
ylabel('Voltage (V)') 
xlim([-.5 .5])

figure(2);
stem( an )
title('Fourier Series Frequency Spectrum of Signal')
xlabel('Frequency') 
ylabel('Height') 
%==========================================================================
%making all negative coefficients positive
anAdj = an;
for n = 1:+1:numHarmonics
    % make any positive coefficients less than .05 five negative
    if anAdj(1,n+1)>0 && anAdj(1,n+1)<.04
       anAdj(1,n+1) = -anAdj(1,n+1);
    end
    %make all negative coefficients 1.7 times larger
    if anAdj(1,n+1)<0
       anAdj(1,n+1) = 1.7*anAdj(1,n+1);
    end
end

%x(t) = an*cos(n*wo*t) ***from n=0 to inf
syms fourierWaveformAdjusted(t)                         
fourierWaveformAdjusted(t) = anAdj(1,1);
for n = 1:+1:numHarmonics
   fourierWaveformAdjusted(t) = fourierWaveformAdjusted(t) + anAdj(1,1+n)*cos(n*wo*t);
end
%==========================================================================
figure(3);
fplot ( fourierWaveformAdjusted(t) )
title('Fourier Representation of Signal After Manipulation')
xlabel('time (ms)') 
ylabel('Voltage (V)') 
xlim([-.5 .5])

figure(4);
stem( anAdj )
title('Fourier Series Frequency Spectrum After Manipulation')
xlabel('Frequency') 
ylabel('Height') 
