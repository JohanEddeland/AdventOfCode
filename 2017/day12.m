% Part 1
fid = fopen('day12input.txt');
tline = fgetl(fid);
currentLine = 1;
childrenList = {};
while ischar(tline)
    strList = strsplit(tline, '<->');
    children = strList{2};
    childrenVector = eval(['[' children ']']);
    childrenVector = childrenVector + 1;
    childrenList{currentLine} = childrenVector;
    
    tline = fgetl(fid);
    currentLine = currentLine + 1;
end
fclose(fid);


result = 0;
groups = {};
nGroups = 0;
for k = 1:length(childrenList)
    allReachableStates = cell(size(childrenList));
    visited = [];
    [reachableFromThis, allReachableStates, ~] = calculateReachableStates(allReachableStates, childrenList, k, visited);
    if find(reachableFromThis == 1)
        result = result + 1;
    end
    
    % Part 2
    groupAlreadyExists = 0;
    reachableFromThis = sort(reachableFromThis);
    for kk = 1:length(groups)
        if isequal(reachableFromThis, groups{kk})
            groupAlreadyExists = 1;
        end
    end
    
    if ~groupAlreadyExists
        nGroups = nGroups + 1;
        groups{end+1} = reachableFromThis;
    end
end

disp(['Day 12, part 1: ' num2str(result)]);
disp(['Day 12, part 2: ' num2str(nGroups)]);

function [reachableFromThis, allReachableStates, visited] = calculateReachableStates(allReachableStates, childrenList, childIndex, visited)
visited = [visited childIndex];
if isempty(allReachableStates{childIndex})
    % Has not been calculated before
    allReachableStates{childIndex} = childrenList{childIndex};
    reachableFromThis = childrenList{childIndex};
    tmpVector = childrenList{childIndex};
    for k = 1:length(tmpVector)
        if find(visited == tmpVector(k))
        %if 0
            % Already visited this one - reachTmp is just the index
            reachTmp = tmpVector(k);
        else
            [reachTmp, allReachableStates] = calculateReachableStates(allReachableStates, childrenList, tmpVector(k), visited);
        end
        reachableFromThis = [reachableFromThis reachTmp]; %#ok<*AGROW>
    end
    reachableFromThis = unique(reachableFromThis);
else
    % Has been calculated before
    reachableFromThis = allReachableStates{childIndex};
end

end