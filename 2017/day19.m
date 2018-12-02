fid = fopen('day19input.txt');
tline = fgetl(fid);
currentLine = 1;
data = {};
while ischar(tline)
    data{currentLine} = tline;
    tline = fgetl(fid);
    currentLine = currentLine + 1;
end
fclose(fid);

% Start positions
thisRow = data{1};
row = 1;
col = find(thisRow == '|');
direction = 's';

answer = '';
contFlag = 1;
nSteps = 0;
while contFlag
    if col==90
        5;
    end
    thisRow = data{row};
    instruction = thisRow(col);
    if instruction == ' '
        contFlag = 0;
    elseif instruction == '+'
        % Need to change direction, cannot be the current direction
        previousDir = direction;
        if previousDir == 's' || previousDir == 'n'
            if col > 1
                if thisRow(col-1) ~= ' ' && thisRow(col-1) ~= '|'
                    direction = 'w';
                end
            end
            if col < length(thisRow)
                if thisRow(col+1) ~= ' ' && thisRow(col+1) ~= '|'
                    direction = 'e';
                end
            end
        elseif previousDir == 'w' || previousDir == 'e'
            if row > 1
                previousRow = data{row-1};
                if previousRow(col) ~= ' ' && previousRow(col) ~= '-'
                    direction = 'n';
                end
            end
            
            if row < length(data)
                nextRow = data{row+1};
                if nextRow(col) ~= ' ' && nextRow(col) ~= '-'
                    direction = 's';
                end
            end
        end
    elseif regexp(instruction, '[A-Z]')
        answer = [answer instruction];
    end
    if direction == 's'
        row = row + 1;
    elseif direction == 'n'
        row = row - 1;
    elseif direction == 'e'
        col = col + 1;
    elseif direction == 'w'
        col = col - 1;
    else
        error('Shouldnt happen');
    end
    nSteps = nSteps + 1;
end

nSteps = nSteps - 1;
disp(['Day 19, part 1: ' answer]);
disp(['Day 19, part 2: ' num2str(nSteps)]);