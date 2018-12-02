%% Part 1
map = [];
fid = fopen('day22input.txt');
tline = fgetl(fid);
while ischar(tline)
    lineVector = [];
    for k = 1:length(tline)
        if tline(k) == '#'
            lineVector(k) = 1;
        elseif tline(k) == '.'
            lineVector(k) = 0; %#ok<*SAGROW>
        else
            error('Should not happen (only want # or .');
        end
    end
    map(end+1,:) = lineVector;
    tline = fgetl(fid);
end
fclose(fid);

% We have everything loaded into the map - now, transform it from a map,
% into a list of coordinates that are infected. (All coordinates that are
% not in the list are NOT infected)
infectedX = [];
infectedY = [];

x0 = ceil(size(map,2)/2); % x origin
y0 = ceil(size(map,1)/2);
for row = 1:size(map, 1)
    for col = 1:size(map, 2)
        if map(row, col) == 1
            % Infected state - calculate coordinates based on where the
            % origin is
            infectedX(end+1) = col - x0;
            infectedY(end+1) = y0 - row;
        end
    end
end

% Everything is initialized, now we can start walking around as the virus
currentX = 0;
currentY = 0;
currentDir = 'u'; % up

nBursts = 10000; % Bursts of activity

answer = 0; % Bursts of activity that caused an infection
for k = 1:nBursts
    infectedIndex = find(infectedX == currentX & infectedY == currentY);
    if infectedIndex
        % Infected state
        currentDir = turnRight(currentDir);
        infectedX(infectedIndex) = [];
        infectedY(infectedIndex) = [];
    else
        % Non-infected state
        currentDir = turnLeft(currentDir);
        
        infectedX(end+1) = currentX;
        infectedY(end+1) = currentY;
        answer = answer + 1;
    end
    % Move forward one step
    if currentDir == 'u'
        currentY = currentY + 1;
    elseif currentDir == 'r'
        currentX = currentX + 1;
    elseif currentDir == 'd'
        currentY = currentY - 1;
    elseif currentDir == 'l'
        currentX = currentX - 1;
    end
end

disp(['Day 22, part 1: ' num2str(answer)]);

%% Part 2
map = [];
fid = fopen('day22input.txt');
tline = fgetl(fid);
while ischar(tline)
    lineVector = [];
    for k = 1:length(tline)
        if tline(k) == '#'
            lineVector(k) = 1;
        elseif tline(k) == '.'
            lineVector(k) = 0; %#ok<*SAGROW>
        else
            error('Should not happen (only want # or .');
        end
    end
    map(end+1,:) = lineVector;
    tline = fgetl(fid);
end
fclose(fid);

% We have everything loaded into the map - now, transform it from a map,
% into a list of coordinates that are infected. (All coordinates that are
% not in the list are NOT infected)
infectedX = [];
infectedY = [];
weakenedX = [];
weakenedY = [];
flaggedX = [];
flaggedY = [];

x0 = ceil(size(map,2)/2); % x origin
y0 = ceil(size(map,1)/2);
for row = 1:size(map, 1)
    for col = 1:size(map, 2)
        if map(row, col) == 1
            % Infected state - calculate coordinates based on where the
            % origin is
            infectedX(end+1) = col - x0;
            infectedY(end+1) = y0 - row;
        end
    end
end

% Everything is initialized, now we can start walking around as the virus
currentX = 0;
currentY = 0;
currentDir = 'u'; % up

nBursts = 10000000; % Bursts of activity

answer = 0; % Bursts of activity that caused an infection
for k = 1:nBursts
    if mod(k, 100000) == 0
        disp([num2str(100*k/nBursts) ' %']);
    end
    infectedIndex = find(infectedX == currentX & infectedY == currentY);
    weakenedIndex = find(weakenedX == currentX & weakenedY == currentY);
    flaggedIndex = find(flaggedX == currentX & flaggedY == currentY);
    if infectedIndex
        % Infected state
        currentDir = turnRight(currentDir);
        infectedX(infectedIndex) = [];
        infectedY(infectedIndex) = [];
        
        flaggedX(end+1) = currentX;
        flaggedY(end+1) = currentY;
    elseif weakenedIndex
        % Weakened states become infected
        weakenedX(weakenedIndex) = [];
        weakenedY(weakenedIndex) = [];
        
        infectedX(end+1) = currentX;
        infectedY(end+1) = currentY;
        
        answer = answer + 1;
        
    elseif flaggedIndex
        % Flagged state
        flaggedX(flaggedIndex) = [];
        flaggedY(flaggedIndex) = [];
        
        
        currentDir = turnLeft(currentDir);
        currentDir = turnLeft(currentDir);
    else
        % Non-infected state
        % Clean nodes become weakened
        currentDir = turnLeft(currentDir);
        
        weakenedX(end+1) = currentX;
        weakenedY(end+1) = currentY;
    end
    % Move forward one step
    if currentDir == 'u'
        currentY = currentY + 1;
    elseif currentDir == 'r'
        currentX = currentX + 1;
    elseif currentDir == 'd'
        currentY = currentY - 1;
    elseif currentDir == 'l'
        currentX = currentX - 1;
    end
end

disp(['Day 22, part 2: ' num2str(answer)]);


function newDir = turnRight(currentDir)
if currentDir == 'u'
    newDir = 'r';
elseif currentDir == 'r'
    newDir = 'd';
elseif currentDir == 'd'
    newDir = 'l';
elseif currentDir == 'l'
    newDir = 'u';
else
    error('Should not happen');
end
end

function newDir = turnLeft(currentDir)
if currentDir == 'u'
    newDir = 'l';
elseif currentDir == 'l'
    newDir = 'd';
elseif currentDir == 'd'
    newDir = 'r';
elseif currentDir == 'r'
    newDir = 'u';
else
    error('Should not happen');
end
end