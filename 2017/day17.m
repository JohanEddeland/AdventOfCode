% Part 1
nSteps = 376; % Puzzle input
nTimes = 2017;
buffer1 = runBuffer(nSteps, nTimes);
idx = find(buffer1 == 2017); 
disp(['Day 17, part 1: ' num2str(buffer(idx + 1))]);

% Part 2
nTimes = 50000000;
answer = runBuffer2(nSteps, nTimes);
disp(['Day 17, part 2: ' num2str(answer)]);

function buffer = runBuffer(nSteps, nTimes)
buffer = 0;
currentPos = 1; % MATLAB indexing

for k = 1:nTimes
    % Step forward nSteps times, then we have the new position
    currentPos = mod(currentPos + nSteps - 1, k) + 1;
    
    % Get the first part of the vector, the last part of the vector, and
    % insert k
    firstPart = buffer(1:currentPos);
    secondPart = buffer(currentPos+1:end);
    buffer = [firstPart k secondPart];
    
    % Increase the position by 1
    currentPos = currentPos + 1;
    if currentPos == length(buffer) + 1
        currentPos = 1;
    end
end
end

function lastNumberAtIndex2 = runBuffer2(nSteps, nTimes)
% Part 2 buffer
currentPos = 1; % MATLAB indexing

lastNumberAtIndex2 = -1; % We want to find number at index 2 (MATLAB index)

for k = 1:nTimes
    % Step forward nSteps times, then we have the new position
    currentPos = mod(currentPos + nSteps - 1, k) + 1;
    
    if currentPos == 1
        lastNumberAtIndex2 = k;
    end
    
    % Increase the position by 1
    currentPos = currentPos + 1;
    if currentPos == k + 2
        currentPos = 1;
    end
end
end