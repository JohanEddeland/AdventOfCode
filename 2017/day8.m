% Part 1
clear

% First, initialize all variables to 0
fid = fopen('day8input.txt');
tline = fgetl(fid);

while ischar(tline)
    splitStrings = strsplit(tline);
    thisVar = splitStrings{1};
    eval([thisVar ' = 0;']);
    tline = fgetl(fid);
end
fclose(fid);

% Now, all variables have values. Parse the file again to execute
fid = fopen('day8input.txt');
tline = fgetl(fid);

maxValueEver = -Inf;

while ischar(tline)
    splitStrings = strsplit(tline);
    thisVar = splitStrings{1};
    operation = splitStrings{2};
    value = splitStrings{3};
    
    condVar = splitStrings{5};
    condOper = splitStrings{6};
    condValue = splitStrings{7};
    
    if strcmp(condOper, '!=')
        condOper = '~=';
    end
    
    if eval([condVar condOper condValue])
        if strcmp(operation, 'dec')
            eval([thisVar ' = ' thisVar ' - ' value ';']);
        else
            eval([thisVar ' = ' thisVar ' + ' value ';']);
        end
    end
    if eval(thisVar) > maxValueEver
        maxValueEver = eval(thisVar);
    end
    tline = fgetl(fid);
end
fclose(fid);

maxValue = -Inf;

listOfVariables = whos;

for k = 1:length(listOfVariables)
    if strcmp(listOfVariables(k).class, 'double')
        thisVal = eval(listOfVariables(k).name);
        if thisVal > maxValue
            maxValue = thisVal;
        end;
    end
end

disp(['Day 8, part 1: ' num2str(maxValue)]);
disp(['Day 8, part 2: ' num2str(maxValueEver)]);