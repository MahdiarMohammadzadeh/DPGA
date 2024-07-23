  %Initialization
clear; close all; closepreview; clc;

hwInfo = imaqhwinfo('kinect')
if size(hwInfo.DeviceInfo,2) == 0
    error('No Kinect Connected');
    break
end

colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);

triggerconfig([colorVid depthVid],'manual');
colorVid.FramesPerTrigger = 1;
depthVid.FramesPerTrigger = 1;

depthSrc = getselectedsource(depthVid);

depthSrc.TrackingMode = 'Skeleton';
% depthSrc.BodyPosture = 'Seated';
figure;
preview(depthVid);

%Operation Loop
% 
while 1
%      Getting Data
    pause(0.5);
    start([colorVid depthVid]);
    trigger([colorVid depthVid]);
    %
    % [colorFrameData,colorTimeData,colorMetaData] = getdata(colorVid);
    % [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
    
    [frameDataColor] = getdata(colorVid);
    [frameDataDepth, timeDataDepth, metaDataDepth] = getdata(depthVid);
    
    stop([colorVid depthVid]);
    
    % Checking Data
    for i=1:depthVid.FramesPerTrigger
        %if any(metaDataDepth(i).IsPositionTracked ~= 0)|| any(metaDataDepth(i).IsSkeletonTracked ~= 0)
        if any(metaDataDepth(i).IsSkeletonTracked ~= 0)
            detected = i;
            break;
        else detected = 0;
        end
    end
    
    % Bodey Found
    if detected == 1
        % Fetching Skeleton Data
        trackedSkeletons = find(metaDataDepth(i).IsSkeletonTracked)
        jointCoordinates = metaDataDepth(i).JointWorldCoordinates(:, :, trackedSkeletons);
        jointIndices = metaDataDepth(i).JointImageIndices(:, :, trackedSkeletons);
        image = frameDataColor(:, :, :, i);
        nSkeleton = length(trackedSkeletons);
        figure
        skeletonViewerForTest(jointIndices, image, nSkeleton);
        % Tracked Bodey Positions
        trackedPositions(1,:) = metaDataDepth.PositionDepthIndices(1,:);
        trackedPositions(2,:) = metaDataDepth.PositionDepthIndices(2,:);
        depthData = getsnapshot(depthVid);
        trackedPositions(3,:) = [0 0 0 0 0 0];
        for increment= 1 : 6
            trackedPositions(3,increment) = depthData(metaDataDepth.PositionDepthIndices(2,increment)+1,metaDataDepth.PositionDepthIndices(1,increment)+1);
        end
        trackedPositions(:,trackedSkeletons)
        %Tracked Hands Positions , Height of body , Direction of the body
        if exist('trackedLeftHand')
            clear('trackedLeftHand');
            clear('trackedRightHand');
        end
        for increment2= 1 : size(jointIndices,3)
            trackedLeftHandOnImage(increment2,:)= uint16((jointIndices(8,:,increment2)+jointIndices(7,:,increment2))/2);
            trackedRightHandOnImage(increment2,:)= uint16((jointIndices(12,:,increment2)+jointIndices(11,:,increment2))/2);
            trackedLeftHandPosition(increment2,:)= double((jointCoordinates(8,:,increment2)+jointCoordinates(7,:,increment2))/2);
            trackedRightHandPosition(increment2,:)= double((jointCoordinates(12,:,increment2)+jointCoordinates(11,:,increment2))/2);
        
        end
        
        for increment3= 1 : size(jointIndices,4)
            coorLeftShoulder(increment3,:)= double((jointCoordinates(5,:,increment3)));
            coorRightShoulder(increment3,:)= double((jointCoordinates(9,:,increment3)));
        end
        for increment4= 1 : size(jointIndices,4)
            coorLeftPalm(increment4,:)= double((jointCoordinates(15,:,increment4)));
            coorRightPalm(increment4,:)= double((jointCoordinates(19,:,increment4)));
            coorHead(increment4,:)= double((jointCoordinates(4,:,increment4)));
        end
        trackedLeftHandOnImage
        trackedRightHandOnImage
        trackedLeftHandPosition
        trackedRightHandPosition
        coorLeftShoulder
        coorRightShoulder
        [directionOfBody,shoulderSize] = bodyDirection(coorLeftShoulder,coorRightShoulder);
        directionOfBody
        shoulderSize
        height = heightOfBody(coorLeftPalm,coorRightPalm,coorHead);
        height
        
        %Break the Loop
        break;
    end
end
