fid = fopen('day10input.txt');
lengths = fscanf(fid, '%d,');
fclose(fid);

list = 0:255;

skipSize = 0;
currentPos = 1;

for k = 1:length(lengths)
    thisLength = lengths(k);
    
    % Get the subset which is as long as thisLength
    if currentPos + thisLength - 1 > length(list)
        % Circular
        moreThanEnd = currentPos + thisLength - 1 - length(list);
        partialVector = [list(currentPos:end) list(1:moreThanEnd)];
        partialVector = flip(partialVector);
        list(currentPos:end) = partialVector(1:length(partialVector) - moreThanEnd);
        list(1:moreThanEnd) = partialVector(end - moreThanEnd + 1:end);
        
    else
        % Simple
        partialVector = list(currentPos:currentPos+thisLength - 1);
        partialVector = flip(partialVector);
        list(currentPos:currentPos + thisLength - 1) = partialVector;
    end
    
    currentPos = currentPos + thisLength + skipSize;
    currentPos = mod(currentPos, length(list));
    skipSize = skipSize + 1;
end

answer = list(1)*list(2);
disp(['Day 10, part 1: ' num2str(answer)]);


% Part 2
lengthsString = fileread('day10input.txt');

lengths = double(lengthsString(1:end-1));

lengths(end+1:end+5) = [17, 31, 73, 47, 23];

list = 0:255;
skipSize = 0;
currentPos = 1;

for k = 1:64
    [list, skipSize, currentPos] = runOneRound(list, skipSize, currentPos, lengths);
end

% list contains sparse hash
finalHash = '';
for k = 1:16
    thisVec = list(16*(k-1) + 1:16*k);
    thisResult = myXOR(thisVec);
    finalHash = [finalHash dec2hex(thisResult, 2)]; %#ok<AGROW>
end

disp(['Day 10, part 2: ' lower(finalHash)]);



function [list, skipSize, currentPos] = runOneRound(list, skipSize, currentPos, lengths)
for k = 1:length(lengths)
    thisLength = lengths(k);
    
    % Get the subset which is as long as thisLength
    if currentPos + thisLength - 1 > length(list)
        % Circular
        moreThanEnd = currentPos + thisLength - 1 - length(list);
        partialVector = [list(currentPos:end) list(1:moreThanEnd)];
        partialVector = flip(partialVector);
        list(currentPos:end) = partialVector(1:length(partialVector) - moreThanEnd);
        list(1:moreThanEnd) = partialVector(end - moreThanEnd + 1:end);
        
    else
        % Simple
        partialVector = list(currentPos:currentPos+thisLength - 1);
        partialVector = flip(partialVector);
        list(currentPos:currentPos + thisLength - 1) = partialVector;
    end
    
    currentPos = currentPos + thisLength + skipSize;
    currentPos = mod(currentPos, length(list));
    if currentPos == 0
        currentPos = length(list);
    end
    skipSize = skipSize + 1;
end


end

function result = myXOR(vector)

result = bitxor(vector(1), vector(2));
for k = 3:length(vector)
    result = bitxor(result, vector(k));
end


end
