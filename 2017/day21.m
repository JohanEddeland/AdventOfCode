% Part 1
twoRulesStart = {}; % What pattern should 2x2 grid match
twoRulesEnd = {}; % Resulting 3x3 after applying rules

threeRulesStart = {};
threeRulesEnd = {};

fid = fopen('day21input.txt');
tline = fgetl(fid);
while ischar(tline)
    % Remove spaces
    tline = regexprep(tline, '\s+', '');
    
    % Split at "=>"
    splitStrings = strsplit(tline, '=>');
    
    strStart = splitStrings{1};
    strEnd = splitStrings{2};
    
    nSlashes = length(strfind(strStart, '/'));
    if nSlashes == 1
        twoRulesStart{end+1} = patternToMatrix(strStart);
        twoRulesEnd{end+1} = patternToMatrix(strEnd);
    elseif nSlashes == 2
        threeRulesStart{end+1} = patternToMatrix(strStart); %#ok<*SAGROW>
        threeRulesEnd{end+1} = patternToMatrix(strEnd);
    else
        error('Should not happen! Should only be 2x2 or 3x3 rules');
    end
    
    tline = fgetl(fid);
end
fclose(fid);

% Now we have all the rules, time to start doing the transformations
img = [0 1 0;0 0 1;1 1 1]; % Start image described in day 21

nIterations = 18;

for k = 1:nIterations
    % Divide the big image into "sub-squares"
    
    if mod(length(img), 2) == 0
        allSubSquares = getSubSquares(img, 2);
        currentMode = 2;
    elseif mod(length(img), 3) == 0
        allSubSquares = getSubSquares(img, 3);
        currentMode = 3;
    else
        error('Should not happen - Must be divisible by 2 or 3');
    end
    
    % We have sub-squares now - check which pattern they match!
    % Change the matrices in allSubSquares as soon as we find a match
    for nSquare = 1:numel(allSubSquares)
        thisSquare = allSubSquares{nSquare};
        if currentMode == 2
            newSquare = findAndApplyRule(thisSquare, twoRulesStart, twoRulesEnd);
        elseif currentMode == 3
            newSquare = findAndApplyRule(thisSquare, threeRulesStart, threeRulesEnd);
        end
        % Change allSubSquares to contain the TRANSFORMED version of the
        % square
        allSubSquares{nSquare} = newSquare;
    end
    
    % Finally, merge all the sub-squares into a big one (img)
    img = mergeSubSquares(allSubSquares);
    
    if k == 5
        pixelsOnAfter5 = sum(sum(img));
    end
end
pixelsOnAfter18 = sum(sum(img));
disp(['Day 21, part 1: ' num2str(pixelsOnAfter5) ' pixels on (after 5 iterations)']);
disp(['Day 21, part 2: ' num2str(pixelsOnAfter18) ' pixels on (after 5 iterations)']);

function outMatrix = patternToMatrix(pattern)

row = 1;
col = 1;
outMatrix = [];
for k = 1:length(pattern)
    if pattern(k) == '#'
        outMatrix(row, col) = 1; %#ok<*AGROW>
        col = col + 1;
    elseif pattern(k) == '.'
        outMatrix(row, col) = 0;
        col = col + 1;
    elseif pattern(k) == '/'
        row = row + 1;
        col = 1;
    else
        error('Should not happen! Should only be #, . or / in the pattern');
    end
end

end

function allSubSquares = getSubSquares(img, sizeOfSmallSquares)
% 3x3: 3n - 2
% 2x2: 2n - 1
allSubSquares = cell(length(img)/sizeOfSmallSquares);
for row = 1: length(img)/sizeOfSmallSquares
    for col = 1:length(img)/sizeOfSmallSquares
        allSubSquares{row, col} = img(sizeOfSmallSquares*row - sizeOfSmallSquares + 1:sizeOfSmallSquares*row, sizeOfSmallSquares*col - sizeOfSmallSquares + 1:sizeOfSmallSquares*col);
    end
end
end

function newSquare = findAndApplyRule(thisSquare, ruleStart, ruleEnd)
for k = 1:length(ruleStart)
    pattern = ruleStart{k};
    if isEqualWithRot(thisSquare, pattern)
        newSquare = ruleEnd{k};
        return
    end
end

% If we reach here, we did not manage to find a match - something is wrong
error('Did not find a match to the square');
end

function verdict = isEqualWithRot(matrix, pattern)
% Find out if the matrix matches the pattern, even when the pattern is
% rotated and flipped


% First, no rotation - standard, flip left right, and flip up-down
if isequal(matrix, pattern)
    verdict = 1;
    return
elseif isequal(matrix, flipud(pattern))
    verdict = 1;
    return
elseif isequal(matrix, fliplr(pattern))
    verdict = 1;
    return
end

% Now, do the same for three consecutive 90 degree rotations
for k = 1:3
    pattern = rot90(pattern);
    if isequal(matrix, pattern)
        verdict = 1;
        return
    elseif isequal(matrix, flipud(pattern))
        verdict = 1;
        return
    elseif isequal(matrix, fliplr(pattern))
        verdict = 1;
        return
    end
end

% If we reach here, we found NO match - verdict is 0 (did not match)
verdict = 0;
end

% [0 1;0 1] [1 2;1 2]
function img = mergeSubSquares(allSubSquares)
s = length(allSubSquares{1,1}); % Size of each sub-square
img = [];
for row = 1:length(allSubSquares)
    for col = 1:length(allSubSquares)
        thisSquare = allSubSquares{row, col};
        img(s*row - s + 1:s*row, s*col - s + 1:s*col) = thisSquare;
    end
end
end