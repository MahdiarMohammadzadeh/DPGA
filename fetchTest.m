function [] = fetchTest(net , Tdata)


data1 = xlsread('before Throwing results.xlsx');
data2 = xlsread('after Throwing results.xlsx');


T = Tdata - 1;

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
set(gcf,'Name',['Test for throw No.',num2str(Tdata)]);
hold on
%Hardness by calculated Parameter
 minHardness = 0;
 maxHardness = 3;

for i = minHardness:0.01:maxHardness
    inputs(inputSize) = i;
    output = net(inputs);
     plot3(output(3) , output(1) ...
        , output(2)  ,'Marker', 'o', 'MarkerSize' , 12 ,'MarkerEdgeColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness],'MarkerFaceColor',[1-i/maxHardness 1-i/maxHardness 1-i/maxHardness], ...
        'color' , 'r') ;
end

set(gca,'Color',[0.9 0.9 0.9]);
    hold off
    

end

