clc;
clear all;
close all;
rawTable = readtable('my_data.csv');
x = rawTable.date;
y = rawTable.new_cases;


figure
stairs(x,y)

b = 8;
sample_max = 2^(b-1)-1;
y_quantized = floor(y*sample_max);

figure
stairs(x,y_quantized)

partition = [3,4,5,6,7,8,9];
codebook = [3,3,4,5,6,7,8,9];
[index,quants] = quantiz(y,partition,codebook);

figure
stairs([index,quants])

n1=3;
L=2^n1;
xmax=2;
xmin=-2;
del=(xmax-xmin)/L;
partition=xmin:del:xmax; % definition of decision lines
codebook=xmin-(del/2):del:xmax+(del/2); % definition of representation levels
[index,quants]=quantiz(y,partition,codebook); 
% gives rounded off values of the samples
figure

stem(quants);
