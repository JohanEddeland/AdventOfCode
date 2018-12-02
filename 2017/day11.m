
distance = computeDistance('ne,ne,ne');

distance = computeDistance('ne,ne,sw,sw');

distance = computeDistance('ne,ne,s,s');

distance = computeDistance('se,sw,se,sw,sw');

stepsTaken = fileread('day11input.txt');

[distance, maxDistance] = computeDistance(stepsTaken); 


disp(['Day 11, part 1: ' num2str(distance)]);
disp(['Day 11, part 2: ' num2str(maxDistance)]);


function [distance, maxDistance] = computeDistance(stepsTaken)
allSteps = strsplit(stepsTaken, ',');

x = 0; % East
y = 0; % North-northwest
z = 0; % South-southwest
maxDistance = -Inf;

for k = 1:length(allSteps)
    thisStep = allSteps{k};
    thisStep = regexprep(thisStep, '\s+', '');
    
    if strcmp(thisStep, 'n')
        y = y + 1;
        z = z - 1;
    elseif strcmp(thisStep, 'ne')
        x = x + 1;
        z = z - 1;
    elseif strcmp(thisStep, 'se')
        y = y -1;
        x = x + 1;
    elseif strcmp(thisStep, 's')
        y = y - 1;
        z = z + 1;
    elseif strcmp(thisStep, 'sw')
        x = x - 1;
        z = z + 1;
    elseif strcmp(thisStep, 'nw')
        y = y + 1;
        x = x - 1;
    else
        error('Should not happen');
    end
    distance = (abs(x) + abs(y) + abs(z))/2;
    
    maxDistance = max(maxDistance, distance);
    
    %distance = max(abs(n), abs(ne));
    %distance = max(distance, abs(nw));
    5;
end


end