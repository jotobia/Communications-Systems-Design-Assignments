clear;
clc;

%: Read the excel file using readtable function
[num] = xlsread('C:\Users\Josh\Dropbox\Communications Systems\DA2\COM-PROJ2A WF') ;
t = 1:41;
noisySignal = num(t,2);
%changing shape of noisy signal to allow it to be cross correlated
noisySignal = reshape(noisySignal,[1,41]);

%plotting 
figure(1);
plot (t,noisySignal);

title('Signal With Noise')
xlabel('time (ms)') 
ylabel('Recieved Voltage (V)')

binaryArray = [0 0 0 0];
correlation = 1:16;
for i = 0:+1:15
    %assigning either 1V or 0V for each bit of digital signal
    for j = 1:+1:4
        if(binaryArray(j) == 0)
            digitalSignal( (10*j-9):(10*j) ) = -1;
        else
            digitalSignal( (10*j-9):(10*j) ) = 1;
        end
    end
    
    %calculating cross correlation between digital signal and noise signal
    r = xcorr(noisySignal,digitalSignal); 
    %it is assumed that the digital signal starts and ends at the same time
    %as the noise signal so we care most about 
    correlation(i+1) = r(40);
    %incrementing digital signal by 1
    binaryArray(4) = binaryArray(4) + 1;
    for j = 4:-1:2
        if (binaryArray(j) == 2) 
            binaryArray(j) = 0;
            binaryArray(j-1) = binaryArray(j-1) + 1;
        end
    end
end
%finding element with max correlation 
[maxCorr,decimalRepOfSignal] = max(correlation);
%outputting the decimal representation of the digital signal (unsigned
%decimal)
decimalRepOfSignal = decimalRepOfSignal-1 


