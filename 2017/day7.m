
fid = fopen('day7input.txt');
tline = fgetl(fid);

baseNames = {};
childrenNames = {};
children = struct();
currentLine = 1;
while ischar(tline)
    tline = regexprep(tline,'\s+','');
    splitStrings = strsplit(tline, '>');
    
    firstPartString = splitStrings{1};
    leftParIndex = strfind(firstPartString, '(');
    rightParIndex = strfind(firstPartString, ')');
    baseNames{end + 1} = firstPartString(1:leftParIndex - 1); %#ok<*SAGROW>
    weightString = firstPartString(leftParIndex+1:rightParIndex-1);
    children(currentLine).weight = str2double(weightString);
    if length(splitStrings) > 1
        secondPartString = splitStrings{2};
        childrenNamesSplit = strsplit(secondPartString, ',');
        children(currentLine).names = childrenNamesSplit;
        for k = 1:length(childrenNamesSplit)
            childrenNames{end+1} = childrenNamesSplit{k};
        end
    else
        children(currentLine).names = {};
    end
    tline = fgetl(fid);
    currentLine = currentLine + 1;
end
fclose(fid);

answer = setdiff(baseNames, childrenNames);
answer = answer{1};
disp(['Day 7, part 1: ' answer]);

getWeight(baseNames, children, answer);

function weight = getWeight(baseNames, children, child)

thisIndex = strcmp(baseNames, child);

if isempty(children(thisIndex).names)
    weight = children(thisIndex).weight;
else
    % Start with the current weight
    weight = children(thisIndex).weight;
    allNames = children(thisIndex).names;
    weightOfOneChild = getWeight(baseNames, children, allNames{1});
    for k = 1:length(allNames)
        thisChildWeight = getWeight(baseNames, children, allNames{k});
        if thisChildWeight ~= weightOfOneChild
            % Put debugger here to see solution
            5;
        end
        weight = weight + thisChildWeight;
    end
end

end