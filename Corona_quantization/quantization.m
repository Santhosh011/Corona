Matlab code:-
clc
clear all
close all
syms x
% SAMPLING
% n=input('Enter the number of samples per cycle : ');

n=20;
rawTable = readtable('my_data.csv'); %Reading my dataset
x = rawTable.date; %loading date column with x
y = rawTable.new_cases; %naming new_cases with y

signal_1=y; % input signal
figure % initializing new figure
hold on;
plot(x,y); % plotting sine signal
title('RAW DATA 18BEC1173'); %provides title for the graph
xlabel('TIME'); % labeling the x axis
ylabel('AMPLITUDE'); % labeling the y axis
hold off; % hold on and hold off for plotting in different windows
figure % initializing new figure
hold on; %hold on retains plots in the current axes
stem(x,signal_1); % plot of sampled signal
title('SAMPLED DATA 18BEC1173'); %provides title for the graph
xlabel('TIME'); % labeling the x axis
ylabel('AMPLITUDE'); % labeling the y axis
hold off; %resets axes properties
% QUANTIZATION
% n1=input('Enter the number of bits per sample : ');
n1=3;
L=2^n1;
xmax=10^5; %Setting the maximum value value in my graph
xmin=-2; %Setting the minimum value in my graph
del=(xmax-xmin)/L;
partition=xmin:del:xmax; % definition of decision lines
codebook=xmin-(del/2):del:xmax+(del/2); % definition of representation levels
[index,quants]=quantiz(signal_1,partition,codebook); 
% gives rounded off values of the samples
figure
hold on; %hold on retains plots in the current axes
stem(x,quants); %Stem for digital output in the graph
title('QUANTIZED SIGNAL 18BEC1173'); %provides title for the graph
xlabel('TIME'); %provides title for the graph
ylabel('AMPLITUDE'); % labeling the y axis
hold off; %resets axes properties
% NORMALIZATION
l1=length(index); % to convert 1 to n as 0 to n-1 indicies
for i=1:l1
if (index(i)~=0)
index(i)=index(i)-1;
end
end
l2=length(quants);
for i=1:l2          %  to convert the end representation levels within the range.
if(quants(i)==xmin-(del/2))
        quants(i)=xmin+(del/2);
end
if(quants(i)==xmax+(del/2))
        quants(i)=xmax-(del/2);
end
end
l2=length(quants); % Storing the length of quants in l2
for i=1:l2          %  to convert the end representation levels within the range.
if(quants(i)==xmin-(del/2))
        quants(i)=xmin+(del/2);
end
if(quants(i)==xmax+(del/2))
        quants(i)=xmax-(del/2);
end
end
%  ENCODING
code=de2bi(index,'left-msb');   % DECIMAL TO BINANRY CONV OF INDICIES
k=1;
for i=1:l1                     % to convert column vector to row vector
for j=1:n1
        coded(k)=code(i,j);
        j=j+1;
        k=k+1;
end
    i=i+1;
end
figure% This will extend the graph in bot [5] and [6]
hold on; %hold on retains plots in the current axes
stairs(coded); %Draws the stairstep function of the graph


%plot of digital signal
title('DIGITAL SIGNAL 18BEC1173'); %provides title for the graph
xlabel('TIME'); %provides title for the graph
ylabel('AMPLITUDE'); % labeling the y axis
hold off; %resets axes properties
%  DEMODULATION
code1=reshape(coded,n1,(length(coded)/n1));
index1=bi2de(code1,'left-msb');
resignal=del*index+xmin+(del/2);
figure% Initializing a new figure
hold on; %hold on retains plots in the current axes
plot(x,resignal); % Plotting the signal
title('DEMODULATED SIGNAL 18BEC1173'); %provides title for the graph
xlabel('TIME'); %provides title for the graph
ylabel('AMPLITUDE'); % labeling the y axis
hold off; %resets axes properties
