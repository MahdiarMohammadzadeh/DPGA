function [ heightOfBody] = heightOfBody( leftPalmCoordinate , rightPalmCoordinate , headCoordinate )

%Average of palm position

    palmCoordinate = double((leftPalmCoordinate(2) + rightPalmCoordinate(2)) / 2 );
    heightOfBody = headCoordinate(2) - palmCoordinate +0.17;
end

