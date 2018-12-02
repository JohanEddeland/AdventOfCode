% Part 1

basicString = 'ffayrhll';

entireGrid = zeros(128);
for row = 0:127
    finalHash = getKnotHash([basicString '-' num2str(row)]);
    finalHash = hex2bin(finalHash);
    for col = 1:length(finalHash)
        entireGrid(row+1, col) = eval(finalHash(col));
    end
    %entireGrid{k + 1} = ;
end

totalUsedSquares = sum(sum(entireGrid));
disp(['Day 14, part 1: ' num2str(totalUsedSquares)]);

% entireGrid = [1 1 0 1 0 1 0 0;
%     0 1 0 1 0 1 0 1;
%     0 0 0 0 1 0 1 0;
%     1 0 1 0 1 1 0 1;
%     0 1 1 0 1 0 0 0];
% Part 2, calculate the regions
[~, numOfRegions] = bwlabel(entireGrid,4);

disp(['Day 14, part 2: ' num2str(numOfRegions)]);


function finalHash = getKnotHash(lengthsString)
lengths = double(lengthsString);

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
finalHash = lower(finalHash);
end

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


function binString = hex2bin(string)
binString = '';
for k = 1:length(string)
    thisChar = string(k);
    if strcmp(thisChar, 'a')
        thisNum = 10;
    elseif strcmp(thisChar, 'b')
        thisNum = 11;
    elseif strcmp(thisChar, 'c')
        thisNum = 12;
    elseif strcmp(thisChar, 'd')
        thisNum = 13;
    elseif strcmp(thisChar, 'e')
        thisNum = 14;
    elseif strcmp(thisChar, 'f')
        thisNum = 15;
    else
        thisNum = eval(thisChar);
    end
    thisBinNumber = dec2bin(thisNum, 4);
    binString = [binString char(thisBinNumber)];
end
end