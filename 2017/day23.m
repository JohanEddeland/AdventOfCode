% Initialize all registers to 0
registers = 'abcdefgh';
for k = 1:length(registers)
    thisChar = registers(k);
    eval([thisChar ' = 0;']);
end

% Read all operations into the cell array allOperations
fid = fopen('day23input.txt');
allOperations = {};
tline = fgetl(fid);
while ischar(tline)
    allOperations{end+1} = tline; %#ok<*SAGROW>
    tline = fgetl(fid);
end
fclose(fid);

contFlag = 1;
operationNumber = 1;
lastFrequency = -1;
thisTime = 0;
nTimesMulInvoked = 0;
while contFlag
    thisTime = thisTime+1;
    if thisTime == 5
        5;
    end
    oper = strsplit(allOperations{operationNumber});
    cmd = oper{1}; % Command, e.g. "mul" or "add"
    arg1 = oper{2};
    
    % Check if arg 1 is a character
    if isnan(str2double(arg1))
        if ~exist(arg1, 'var')
            eval([arg1 ' = 0;']);
        end
    end
    if length(oper) > 2
        arg2 = oper{3};
        if isnan(str2double(arg2))
            if ~exist(arg2, 'var')
                eval([arg2 ' = 0;']);
            end
        end
    end
    
    switch cmd
        case 'set'
            eval([arg1 ' = ' arg2 ';']);
            operationNumber = operationNumber + 1;
        case 'sub'
            eval([arg1 ' = ' arg1 ' - ' arg2 ';']);
            operationNumber = operationNumber + 1;
        case 'mul'
            eval([arg1 ' = ' arg1 ' * ' arg2 ';']);
            nTimesMulInvoked = nTimesMulInvoked + 1;
            operationNumber = operationNumber + 1;
        case 'jnz'
            if eval(arg1) ~= 0
                operationNumber = operationNumber + eval(arg2);
            else
                operationNumber = operationNumber + 1;
            end
        otherwise
            error('Unknown command');
    end
    
    if operationNumber > length(allOperations) || ...
            operationNumber < 1
        contFlag = 0;
    end
end

disp(['Day 23, part 1: ' num2str(nTimesMulInvoked)]);