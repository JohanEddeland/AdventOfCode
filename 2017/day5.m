% Part 1
fid = fopen('day5input.txt');
data = fscanf(fid, '%d');

continueFlag = 1;

currentIndex = 1;
numSteps = 0;

while continueFlag
    jumpToTake = data(currentIndex);
    data(currentIndex) = data(currentIndex) + 1;
    
    currentIndex = currentIndex + jumpToTake;
    numSteps = numSteps + 1;
    if currentIndex > length(data) || currentIndex < 1
        continueFlag = 0;
    end
end

fclose(fid);

disp(['Day 5, part 1: ' num2str(numSteps)]);

% Part 2
fid = fopen('day5input.txt');
data = fscanf(fid, '%d');

continueFlag = 1;

currentIndex = 1;
numSteps = 0;

while continueFlag
    jumpToTake = data(currentIndex);
    if jumpToTake >= 3
        data(currentIndex) = data(currentIndex) - 1;
    else
        data(currentIndex) = data(currentIndex) + 1;
    end
    
    currentIndex = currentIndex + jumpToTake;
    numSteps = numSteps + 1;
    if currentIndex > length(data) || currentIndex < 1
        continueFlag = 0;
    end
end

fclose(fid);

disp(['Day 5, part 2: ' num2str(numSteps)]);

