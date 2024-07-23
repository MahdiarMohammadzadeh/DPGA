function [inputs,outputs] = dataPreprocessings(input,output,mode)

if nargin<3
    mode = 1 ;
end

% Actual data
if mode == 1
    input(:,1:6) = [] ;
    output(:,1:5) = [];
    input(:,9:11) = output(:,6:8);
    output(:,4:8) = [];
    inputs = input;
    outputs = output;
    
%Rate Repeated data
elseif mode == 2
    allDatas = [input , output] ;
    i3 = 1 ;
    for i1 = 1 : size(allDatas,1)
        for i2 = 1 : allDatas(i1,26)
            newAllData(i3,:) =  allDatas(i1,:) ;
            i3 = i3 +  1 ;
        end
    end
    
    input = newAllData(:,1:14);
    output = newAllData(:,15:27);
    
    
    input(:,1:6) = [] ;
    output(:,1:5) = [];
    input(:,9) = output(:,8);
    output(:,4:8) = [];
    
    inputs = input(randperm(size(input, 1)), :); %randomizing input
    outputs = output(randperm(size(output, 1)), :); %randomizing output
else
    error('You must select the mode correctly');
end

end

