% Part 1
% getPoints('{{{}}}') % 6
% getPoints('{{},{}}') % 5
% getPoints('{{{},{},{{}}}}') % 16
% getPoints('{<a>,<a>,<a>,<a>}') % 1
% getPoints('{{<ab>},{<ab>},{<ab>},{<ab>}}') % 9
% getPoints('{{<!!>},{<!!>},{<!!>},{<!!>}}') % 9
% getPoints('{{<a!>},{<a!>},{<a!>},{<ab>}}') % 3

fid = fopen('day9input.txt');
tline = fgetl(fid);

data = '';

while ischar(tline)
    data = [data tline];
    tline = fgetl(fid);
end

[score, garbageCount] = getPoints(data);
disp(['Day 9, part 1: ' num2str(score)]);
disp(['Day 9, part 2: ' num2str(garbageCount)]);


function [score, garbageCount] = getPoints(group)


garbage = 0;
score = 0;
depth = 1;
garbageCount = 0;
passNext = 0;
for k = 1:length(group)
    thisChar = group(k);
    if passNext
        passNext = 0;
    elseif thisChar == '!'
        passNext = 1;
    elseif garbage && thisChar ~= '>'
        garbageCount = garbageCount + 1;
    elseif thisChar == '<'
        garbage = 1;
    elseif thisChar == '>'
        garbage = 0;
    elseif thisChar == '{'
        score = score + depth;
        depth = depth + 1;
    elseif thisChar == '}'
        depth = depth - 1;
    end
end

end