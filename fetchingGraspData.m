function [trackedPositionOutput , jointCoordinates, graspingPosition , graspingHand , directionOfBody ] = fetchingGraspData(colorVid ,depthVid,imageAxisName)

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
        skeletonViewer(jointIndices, image, nSkeleton,imageAxisName);
        % Tracked Bodey Positions
        trackedPositions(1,:) = metaDataDepth.PositionDepthIndices(1,:);
        trackedPositions(2,:) = metaDataDepth.PositionDepthIndices(2,:);
        depthData = getsnapshot(depthVid);
        trackedPositions(3,:) = [0 0 0 0 0 0];
        for increment= 1 : 6
            trackedPositions(3,increment) = depthData(metaDataDepth.PositionDepthIndices(2,increment)+1,metaDataDepth.PositionDepthIndices(1,increment)+1);
        end
        trackedPositionOutput = transpose(metaDataDepth.PositionWorldCoordinates(:,trackedSkeletons));
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
        if trackedRightHandPosition(2) > trackedLeftHandPosition(2)
            graspingPosition = trackedLeftHandPosition;
            graspingHand = 'Left';
        else
            graspingPosition = trackedRightHandPosition;
            graspingHand = 'Right';
        end
        
        coorLeftShoulder
        coorRightShoulder
        [directionOfBody,shoulderSize] = bodyDirection(coorLeftShoulder,coorRightShoulder);
        directionOfBody
        shoulderSize

        %Break the Loop
        break;
    end
end

end

