mkdir('Datasets');

currentFolder = pwd ;

filename = sprintf('%s' , currentFolder , '\Datasets\before Throwing results.xlsx');
A = {'ID'  , 'Number of Throwing' , 'Body Posture', 'Body Position(X)', 'Body Position(Y)','Body Position(Z)','Tracked Left Hand(X)' ,'Tracked Left Hand(Y)','Tracked Left Hand(Z)', 'Tracked Right Hand(X)' , 'Tracked Right Hand(Y)' ,'Tracked Right Hand(Z)', 'Direction' , 'Height'}
sheet = 1;
xlRange = 'A1';
xlswrite(filename,A,sheet,xlRange)
filename = sprintf('%s' , currentFolder , '\Datasets\after Throwing results.xlsx');
A = {'ID' , 'Number of Throwing' , 'Body Position(X)', 'Body Position(Y)','Body Position(Z)','Grasping Position(X)' ,'Grasping Position(Y)','Grasping Position(Z)', 'Grasping Hand','Grasping Direction' , 'catched' ,'User Score' , 'Calculated Hardness'}
sheet = 1;
xlRange = 'A1';
xlswrite(filename,A,sheet,xlRange)


order = 2;
save('order.mat','order');