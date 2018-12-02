% Part 1

clear;
% Read all operations into the cell array allOperations
fid = fopen('day18input.txt');
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
        case 'snd'
            lastFrequency = eval(arg1);
            operationNumber = operationNumber + 1;
        case 'set'
            eval([arg1 ' = ' arg2 ';']);
            operationNumber = operationNumber + 1;
        case 'add'
            eval([arg1 ' = ' arg1 ' + ' arg2 ';']);
            operationNumber = operationNumber + 1;
        case 'mul'
            eval([arg1 ' = ' arg1 ' * ' arg2 ';']);
            operationNumber = operationNumber + 1;
        case 'mod'
            eval([arg1 ' = mod(' arg1 ', ' arg2 ');']);
            operationNumber = operationNumber + 1;
        case 'rcv'
            if eval(arg1) ~= 0
                disp(['Recovered frequency ' num2str(lastFrequency)]);
                contFlag = 0;
            else
                operationNumber = operationNumber + 1;
            end
        case 'jgz'
            if eval(arg1) > 0
                operationNumber = operationNumber + eval(arg2);
            else
                operationNumber = operationNumber + 1;
            end
        otherwise
            error('Unknown command');
    end
end

% Part 2
clear
% Read all operations into the cell array allOperations
fid = fopen('day18input.txt');
allOperations = {};
tline = fgetl(fid);
while ischar(tline)
    allOperations{end+1} = tline; %#ok<*SAGROW>
    tline = fgetl(fid);
end
fclose(fid);

contFlag = 1;
cont1 = 1; % Flag telling whether program 1 wants to terminate
cont2 = 1; % Flag telling whether program 2 wants to terminate
nr1 = 1; % Operation number for process 1
nr2 = 1; % Operation number for process 2
queue1 = []; % Queue for process 1
queue2 = [];
program1Counter = 0; % Counter which counts how many times program 1 sends a value
lastFrequency = -1;
timeCounter = 0;

p2 = 0;
p1 = 1;
while contFlag
    timeCounter = timeCounter + 1;
    if mod(timeCounter, 1000) == 0
        disp(['1: ' num2str(nr1) ' --- 2: ' num2str(nr2)]);
    end
    cont1 = 1;
    cont2 = 1;
    %% First, process 1
    % For process 1, we will name all variables with an ending of 1, e.g.
    % variable "p" becomes "p1" etc. 
    oper1 = strsplit(allOperations{nr1});
    cmd1 = oper1{1}; % Command, e.g. "mul" or "add"
    arg1 = oper1{2};
    
    % Check if arg 1 is a character
    if isnan(str2double([arg1 '1']))
        arg1 = [arg1 '1']; %#ok<*AGROW>
        if ~exist(arg1, 'var')
            eval([arg1 ' = 0;']);
        end
    end
    if length(oper1) > 2
        arg2 = oper1{3};
        if isnan(str2double([arg2 '1']))
            arg2 = [arg2 '1'];
            if ~exist(arg2, 'var')
                eval([arg2 ' = 0;']);
            end
        end
    end
    
    switch cmd1
        case 'snd'
            % Send to process 2 <=> add arg1 to queue2
            queue2(end+1) = eval(arg1);
            program1Counter = program1Counter + 1;
            nr1 = nr1 + 1;
        case 'set'
            eval([arg1 ' = ' arg2 ';']);
            nr1 = nr1 + 1;
        case 'add'
            eval([arg1 ' = ' arg1 ' + ' arg2 ';']);
            nr1 = nr1 + 1;
        case 'mul'
            eval([arg1 ' = ' arg1 ' * ' arg2 ';']);
            nr1 = nr1 + 1;
        case 'mod'
            eval([arg1 ' = mod(' arg1 ', ' arg2 ');']);
            nr1 = nr1 + 1;
        case 'rcv'
            if isempty(queue1)
                % No element to receive - do nothing
                cont1 = 0;
            else
                % Receive the element and continue operation
                eval([arg1 ' = ' num2str(queue1(1)) ';']);
                queue1(1) = [];
                nr1 = nr1 + 1;
            end
        case 'jgz'
            if eval(arg1) > 0
                nr1 = nr1 + eval(arg2);
            else
                nr1 = nr1 + 1;
            end
        otherwise
            error('Unknown command');
    end
    
    %% Second, process 2
    oper2 = strsplit(allOperations{nr2});
    cmd2 = oper2{1}; % Command, e.g. "mul" or "add"
    arg1 = oper2{2};
    
    % Check if arg 1 is a character
    if isnan(str2double([arg1 '2']))
        arg1 = [arg1 '2']; %#ok<*AGROW>
        if ~exist(arg1, 'var')
            eval([arg1 ' = 0;']);
        end
    end
    if length(oper2) > 2
        arg2 = oper2{3};
        if isnan(str2double([arg2 '2']))
            arg2 = [arg2 '2'];
            if ~exist(arg2, 'var')
                eval([arg2 ' = 0;']);
            end
        end
    end
    
    switch cmd2
        case 'snd'
            % Send to process 2 <=> add arg1 to queue2
            queue1(end+1) = eval(arg1);
            nr2 = nr2 + 1;
        case 'set'
            eval([arg1 ' = ' arg2 ';']);
            nr2 = nr2 + 1;
        case 'add'
            eval([arg1 ' = ' arg1 ' + ' arg2 ';']);
            nr2 = nr2 + 1;
        case 'mul'
            eval([arg1 ' = ' arg1 ' * ' arg2 ';']);
            nr2 = nr2 + 1;
        case 'mod'
            eval([arg1 ' = mod(' arg1 ', ' arg2 ');']);
            nr2 = nr2 + 1;
        case 'rcv'
            if isempty(queue2)
                % No element to receive - do nothing
                cont2 = 0;
            else
                % Receive the element and continue operation
                eval([arg1 ' = ' num2str(queue2(1)) ';']);
                queue2(1) = [];
                nr2 = nr2 + 1;
            end
        case 'jgz'
            if eval(arg1) > 0
                nr2 = nr2 + eval(arg2);
            else
                nr2 = nr2 + 1;
            end
        otherwise
            error('Unknown command');
    end
    
    % Termination criterion
    if ~cont1 && ~cont2
        contFlag = 0;
    end
end

disp(['Day 18, part 2: ' num2str(program1Counter)]);