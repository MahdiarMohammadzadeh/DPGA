function plotResults(t,y,name)

figure('Renderer', 'painters', 'Position', [0 0 1800 950] , 'Name' , [name , ' Results']) ;
%t and y
subplot(3,3,1);
plot(y,'k')
hold on
plot(t,'r:')
legend('Outputs','Targets');
title(name);
hold off

subplot(3,3,2);
surfc(y,'FaceColor','b');
hold on
surfc(t,'FaceColor','r','LineStyle',':')
legend('Outputs','Interceptions','Targets');
title('Surface Plot for outputs and targets');

%corrolation plot
subplot(3,3,3);
plot(t,y,'k','Marker','o');
hold on
xmin = min(min(t),min(y));
xmax = max(max(t),max(y));
plot([xmin xmax] , [xmin xmax],'b','LineWidth',2);
R = corr(t',y');
title(['Rx= ', num2str(R(1))]);

subplot(3,3,4);
plot(t,y,'k','Marker','o');
hold on
xmin = min(min(t),min(y));
xmax = max(max(t),max(y));
plot([xmin xmax] , [xmin xmax],'b','LineWidth',2);
R = corr(t',y');
title(['Ry= ', num2str(R(2))]);

subplot(3,3,5);
plot(t,y,'k','Marker','o');
hold on
xmin = min(min(t),min(y));
xmax = max(max(t),max(y));
plot([xmin xmax] , [xmin xmax],'b','LineWidth',2);
R = corr(t',y');
title(['Rz= ', num2str(R(3))]);

%error
subplot(3,3,6);
e = t - y;
plot(e');
legend('Error x','Error y','Error z');
MSE = mean(e'.^2);
RMSE = sqrt(MSE);
title({['MSE(x)= ', num2str(MSE(1)) , ', RMSE(x)= ' , num2str(RMSE(1))]; ...
    ['MSE(y)= ', num2str(MSE(2)) , ', RMSE(y)= ' , num2str(RMSE(2))]; ...
    ['MSE(z)= ', num2str(MSE(3)) , ', RMSE(z)= ' , num2str(RMSE(3))]});

%Error Histogram
subplot(3,3,7);
histfit(e(1,:),50);
emean = mean(e');
eStd = std(e');
title(['\muX= ' num2str(emean(1)) ' \sigmaX= ' num2str(eStd(1))]);

subplot(3,3,8);
histfit(e(2,:),50);
emean = mean(e');
eStd = std(e');
title(['\muY= ' num2str(emean(2)) ' \sigmaY= ' num2str(eStd(2))]);

subplot(3,3,9);
histfit(e(3,:),50);
emean = mean(e);
eStd = std(e');
title(['\muZ= ' num2str(emean(3)) ' \sigmaZ= ' num2str(eStd(3))]);
end