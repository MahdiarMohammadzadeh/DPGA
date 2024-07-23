clc;
clear;
close all;

load net2;


data1 = xlsread('before Throwing results.xlsx');
data2 = xlsread('after Throwing results.xlsx');


askToInput = 'Please enter the order number of thrower:';
T = input(askToInput);
T = T - 1;

ID = data1(:,1);
No = data1(:,2);
inputSize = net.inputs{1,1}.size ;

if inputSize == 11
data1(:,1:6) = [] ;
data2(:,1:5) = [];
data1(:,9:11) = data2(:,6:8);
data2(:,4:8) = [];
elseif inputSize == 9
data1(:,1:6) = [] ;
data2(:,1:5) = [];
data1(:,9) = data2(:,8);
data2(:,4:8) = [];
end
inputs = (data1(T,:))' ;


openfig(sprintf('plots//ID%dNo%dplot.fig'  , ID(T) , No(T)));
hold on
%Hardness by calculated Parameter
%  minHardness = 0.01;
%  maxHardness = 10;
% for i = minHardness:0.01:maxHardness
%     inputs(inputSize) = i;
%     output = net(inputs);
%      plot3(output(3) , output(1) ...
%         , output(2)  ,'Marker', 'o', 'MarkerSize' , 12 ,'MarkerEdgeColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness],'MarkerFaceColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness], ...
%         'color' , 'r') ;
% end

%Hardness by User Score Parameter
 minScore = 10;
 maxScore = 10;
for i = maxScore:-0.01:minScore
     inputs(inputSize) = 3;
    inputs(10) = 10;
    output = net(inputs);
     plot3(output(3) , output(1) ...
        , output(2)  ,'Marker', 'o', 'MarkerSize' , 30 ,'MarkerEdgeColor',[1 1 1],'MarkerFaceColor',[1 1 1], ...
        'color' , 'r') ;
end

%Hardness by both User Score and Calculated Hardness Parameters
%  minHardness = 0.01;
%  maxHardness = 10;
% for i = maxHardness:-0.01:minHardness
%     inputs(10) = i;
%     outputAvgU(:,1001 - uint16(i*100)) = net(inputs);
% end
% 
%  minHardness = 0.01;
%  maxHardness = 10;
% 
% for i = minHardness:0.01:maxHardness
%     inputs(inputSize) = i;
%     outputAvgH(:,uint16(i*100)) = net(inputs);
% end
% 
% for i = minHardness:0.01:maxHardness
%      output = (outputAvgH(:,uint16(i*100)) + outputAvgU(:,uint16(i*100)))/2  ;
%      plot3(output(3) , output(1) ...
%      , output(2)  ,'Marker', 'o', 'MarkerSize' , 20 ,'MarkerEdgeColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness],'MarkerFaceColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness], ...
%      'color' , 'r') ;
% end



set(gca,'Color',[0.9 0.9 0.9]);
    hold off
    