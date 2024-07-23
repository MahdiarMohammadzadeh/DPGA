function [ direction ,shoulderSize ] = bodyDirection( leftShoulderCoordinate , rightShoulderCoordinate )

%Left shoulder options
leftShoulderPositionX = leftShoulderCoordinate(1);
leftShoulderPositionZ = leftShoulderCoordinate(3);

%Right shoulder Options
rightShoulderPositionX = rightShoulderCoordinate(1);
rightShoulderPositionZ = rightShoulderCoordinate(3);

%Calculations

L1 = sqrt( leftShoulderPositionX^2 + leftShoulderPositionZ^2 );
angle1 = 90 - acosd(leftShoulderPositionZ/L1);

L2 = sqrt( rightShoulderPositionX^2 + rightShoulderPositionZ^2 );
angle2 = 90 - acosd(rightShoulderPositionZ/L2);

angle = angle1 + angle2;

shoulderSizeTemp = L1^2 + L2^2 - 2*L1*L2*cosd(angle);

direction = atand((rightShoulderPositionZ - leftShoulderPositionZ) / (rightShoulderPositionX - leftShoulderPositionX));
shoulderSize = shoulderSizeTemp + (abs(direction) * 0.3) ; 
end

