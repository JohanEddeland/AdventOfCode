% Part 1
fid = fopen('day4input.txt');
tline = fgetl(fid);
nGoodPhrases = 0;
while ischar(tline)
    listOfStrings = strsplit(tline, ' ');
    uniqueList = unique(listOfStrings);
    if length(listOfStrings) == length(uniqueList)
        nGoodPhrases = nGoodPhrases + 1;
    end
    tline = fgetl(fid);
end
fclose(fid);

disp(['Day 4, part 1: ' num2str(nGoodPhrases)]);

% Part 2
fid = fopen('day4input.txt');
tline = fgetl(fid);
nGoodPhrases = 0;
while ischar(tline)
    listOfStrings = strsplit(tline, ' ');
    
    for k = 1:length(listOfStrings)
        listOfStrings{k} = sort(listOfStrings{k});
    end
    uniqueList = unique(listOfStrings);
    if length(listOfStrings) == length(uniqueList)
        nGoodPhrases = nGoodPhrases + 1;
    end
    tline = fgetl(fid);
end
fclose(fid);

disp(['Day 4, part 2: ' num2str(nGoodPhrases)]);