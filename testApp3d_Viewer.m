clear all ; close all ; clc;

colorDevice = imaq.VideoDevice('kinect',1);
depthDevice = imaq.VideoDevice('kinect',2);

step(colorDevice);
step(depthDevice);

colorImage = step(colorDevice);
depthImage = step(depthDevice);

ptCloud = pcfromkinect(depthDevice,depthImage,colorImage);

player = pcplayer(ptCloud.XLimits,ptCloud.YLimits,ptCloud.ZLimits,...
	'VerticalAxis','y','VerticalAxisDir','down');

xlabel(player.Axes,'X (m)');
ylabel(player.Axes,'Y (m)');
zlabel(player.Axes,'Z (m)');

for i = 1:500    
   colorImage = step(colorDevice);  
   depthImage = step(depthDevice);
 
   ptCloud = pcfromkinect(depthDevice,depthImage,colorImage);
 
   view(player,ptCloud);
   i
end
