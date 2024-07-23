function [ output_args ] = hardnessCalc( graspingHand,  trackedLeftHandBT, trackedRightHandBT, graspingPosition )

if strcmp(graspingHand,'Left')
    work = abs(sqrt((trackedLeftHandBT.^2) - (graspingPosition.^2)));
    output_args = work(1) + work(2) + work(3) ; 
else
    work = abs(sqrt((trackedRightHandBT.^2) - (graspingPosition.^2)));
    output_args = work(1) + work(2) + work(3) ; 
end

