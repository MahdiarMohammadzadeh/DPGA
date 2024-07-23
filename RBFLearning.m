clc;
clear;
close all;

beforeThrowDatas = xlsread('before Throwing results.xlsx');
afterThrowDatas = xlsread('after Throwing results.xlsx');

[input , output] = dataPreprocessings(beforeThrowDatas , afterThrowDatas ,1) ;

    
input(110:112,:) = [];
output(110:112,:)  = [] ;

inputs = transpose(input);
targets = transpose(output);



% Create and Train RBF Network
nData=size(inputs,2);

Perm=randperm(nData);

pTrainData=0.7;
nTrainData=round(pTrainData*nData);
trainInd=Perm(1:nTrainData);
Perm(1:nTrainData)=[];
trainInputs = inputs(:,trainInd);
trainTargets = targets(:,trainInd);

pTestData=1-pTrainData;
nTestData=nData-nTrainData;
testInd=Perm;
testInputs = inputs(:,testInd);
testTargets = targets(:,testInd);


% Create and Train RBF Network
% Goal=0; 
% Spread=1;
% MaxNeuron=120;
DisplayAt=1;
% net = newrb(trainInputs,trainTargets,Goal,Spread,MaxNeuron,DisplayAt);
net = newrb(trainInputs,trainTargets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);


% Recalculate Training, Validation and Test Performance
trainOutputs = outputs(:,trainInd);
trainErrors = trainTargets-trainOutputs;
trainPerformance = perform(net,trainTargets,trainOutputs);
%
testOutputs = outputs(:,testInd);
testError = testTargets-testOutputs;
testPerformance = perform(net,testTargets,testOutputs);
%



fetchTest(net,112);

PlotResults(targets,outputs,'All Data');
PlotResults(trainTargets,trainOutputs,'Train Data');
PlotResults(testTargets,testOutputs,'Test Data');



% View the Network
% view(net);
