% Part 1
fid = fopen('day16input.txt');
inp = fscanf(fid, '%s');
fclose(fid);

allCommands = strsplit(inp, ',');

startOrder = 'abcdefghijklmnop';
order = startOrder;
contFlag = 1;
oneCycle = 0;

allCombinations = {order};

while contFlag
    for k = 1:length(allCommands)
        thisCommand = allCommands{k}; % e.g. "s1" or "x3/4"
        
        thisMove = thisCommand(1); % e.g. "s" or "x"
        if thisMove == 's'
            spinSize = str2double(thisCommand(2:end)); % e.g. 3 or 15
            order = [order(end-spinSize+1:end) order(1:end-spinSize)];
        elseif thisMove == 'x'
            commandPart2 = thisCommand(2:end); % e.g. "3/4" or "10/11"
            slashIndex = strfind(commandPart2, '/');
            pos1 = eval(commandPart2(1:slashIndex - 1)) + 1; % Need to change to MATLAB indexing
            pos2 = eval(commandPart2(slashIndex+1:end)) + 1;
            pos1Char = order(pos1);
            pos2Char = order(pos2);
            
            order(pos1) = pos2Char;
            order(pos2) = pos1Char;
        elseif thisMove == 'p'
            pos1Char = thisCommand(2);
            pos2Char = thisCommand(4);
            
            pos1 = find(order == pos1Char);
            pos2 = find(order == pos2Char);
            
            order(pos1) = pos2Char;
            order(pos2) = pos1Char;
        else
            error('Unallowed move!');
        end
    end
    
    oneCycle = oneCycle + 1;
    if isequal(order, startOrder)
        contFlag = 0;
    else
        % Add the order to allCombinations to be used later
        allCombinations{end+1} = order;
    end
end

rem = mod(1000000000, oneCycle);
answerPart2 = allCombinations{rem + 1};

disp(['Day 16, part 1: ' order]);
disp(['Day 16, part 2: ' answerPart2]);