% Part 1
p = [];
v = [];
a = [];

fid = fopen('day20input.txt');
tline = fgetl(fid);
currentLine = 1;
data = {};
while ischar(tline)
    leftIndex = strfind(tline, '<');
    rightIndex = strfind(tline, '>');
    
    % Extract position
    thisP = tline(leftIndex(1) + 1:rightIndex(1) - 1);
    thisP = str2double(strsplit(thisP, ','));
    p(currentLine, 1) = thisP(1); %#ok<*SAGROW>
    p(currentLine, 2) = thisP(2);
    p(currentLine, 3) = thisP(3);
    
    % Extract velocity
    thisV = tline(leftIndex(2) + 1:rightIndex(2) - 1);
    thisV = str2double(strsplit(thisV, ','));
    v(currentLine, 1) = thisV(1);
    v(currentLine, 2) = thisV(2);
    v(currentLine, 3) = thisV(3);
    
    % Extract acceleration
    thisA = tline(leftIndex(3) + 1:rightIndex(3) - 1);
    thisA = str2double(strsplit(thisA, ','));
    a(currentLine, 1) = thisA(1);
    a(currentLine, 2) = thisA(2);
    a(currentLine, 3) = thisA(3);
    
    currentLine = currentLine + 1;
    tline = fgetl(fid);
end
fclose(fid);

contFlag = 1;
prevClosest = -1;
iterSinceChange = 1;
while iterSinceChange < 10000
    % Calculate closest particle to origin
    [~, closest] = min(sum(abs(p), 2));
    if closest == prevClosest
        iterSinceChange = iterSinceChange + 1;
    else
        disp(['Changed: ' num2str(prevClosest) ' to ' num2str(closest)]);
    end
    prevClosest = closest;
    
    % Find collisions
    [u,I,J] = unique(p, 'rows', 'first');
    hasDuplicates = size(u,1) < size(p,1);
    if hasDuplicates
        5;
    end
    [count, ~, idxcount] = histcounts(J,numel(I));
    idxkeep = count(idxcount)>1;
    p(idxkeep,:) = inf(size(p(idxkeep,:)));
    
    
    % Update velocity and position ...
    v = v + a;
    p = p + v;
end

particlesLeft = sum(p(:,1) < Inf);
disp(['Day 20, part 1: ' num2str(closest - 1) ' is closest']); % Need to convert MATLAB index to ordinary
disp(['Day 20, part 2: ' num2str(particlesLeft) ' particles left']);
