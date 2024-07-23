clc;
clear;
close all;

%% Load Data

 
beforeThrowDatas = xlsread('before Throwing results.xlsx');
afterThrowDatas = xlsread('after Throwing results.xlsx');

[input , output] = dataPreprocessings(beforeThrowDatas , afterThrowDatas ,1) ;

    
input(110:140,:) = [];
output(110:140,:)  = [] ;

TrainInputs = input;

TrainTargets = output;

%% Design SVM

rng default

Mdlx = fitcecoc(TrainInputs,TrainTargets(:,1));
Mdly = fitcecoc(TrainInputs,TrainTargets(:,2));
Mdlz = fitcecoc(TrainInputs,TrainTargets(:,3));


beforeThrowDatas = xlsread('before Throwing results.xlsx');
afterThrowDatas = xlsread('after Throwing results.xlsx');

[input , output] = dataPreprocessings(beforeThrowDatas , afterThrowDatas ,1) ;
for i = 110:1:140
    
testOutput(i-109,1) = predict(Mdlx,input(i,:));
testOutput(i-109,2) = predict(Mdly,input(i,:));
testOutput(i-109,3) = predict(Mdlz,input(i,:));
end
testOutput';