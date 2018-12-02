
% Part 1
fid = fopen('day2input.txt');
data = fscanf(fid, '%f %f', [16 16]);
data = data';

maxValues = max(data,[],2);
minValues = min(data,[],2);
answer = sum(maxValues - minValues);

disp(['Day 2, part 1: ' num2str(answer)]);

% Part 2
answer = 0;

for row = 1:size(data,1)
    numToAdd = -1;
    for col = 1:size(data,2)
        for col2 = col+1:size(data,2)
            maxVal = max(data(row, col), data(row, col2));
            minVal = min(data(row, col), data(row, col2));
            if mod(maxVal, minVal) == 0
                numToAdd = maxVal/minVal;
                break;
            end
        end
        if numToAdd > -1
            break;
        end
    end
    answer = answer + numToAdd;
end

disp(['Day 2, part 2: ' num2str(answer)]);
fclose(fid);