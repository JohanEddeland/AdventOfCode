% Part 1

% fid = fopen('day6input.txt');
% blocks = fscanf(fid, '%d');
% blocks = blocks';
% allBlocksSeen = blocks;
% 
% continueFlag = 1;
% 
% answer = 0;
% 
% while continueFlag
%     [number, idx] = max(blocks);
%     blocks(idx) = 0;
%     for k = 1:number
%         if idx < length(blocks)
%             idx = idx + 1;
%         else
%             idx = 1;
%         end
%         blocks(idx) = blocks(idx) + 1;
%     end
%     allBlocksSeen(end+1, :) = blocks; %#ok<*SAGROW>
%     
%     if size(allBlocksSeen, 1) ~= size(unique(allBlocksSeen, 'rows'), 1)
%         continueFlag = 0;
%     end
%     answer = answer + 1;
%     disp(answer);
% end
% 
% fclose(fid);

answer = 11137;

disp(['Day 6, part 1: ' num2str(answer)]);

% Part 2

fid = fopen('day6input.txt');
blocks = fscanf(fid, '%d');
blocks = blocks';

allBlocksSeen = blocks;

continueFlag = 1;

answer = 0;

while continueFlag
    [number, idx] = max(blocks);
    blocks(idx) = 0;
    for k = 1:number
        if idx < length(blocks)
            idx = idx + 1;
        else
            idx = 1;
        end
        blocks(idx) = blocks(idx) + 1;
    end
    allBlocksSeen(end+1, :) = blocks; %#ok<*SAGROW>
    
    if size(allBlocksSeen, 1) ~= size(unique(allBlocksSeen, 'rows'), 1)
        interestingBlock = allBlocksSeen(end, :);
        interestingIndex = find(ismember(allBlocksSeen, interestingBlock, 'rows'), 1);
        part2answer = size(allBlocksSeen, 1) - interestingIndex;
        continueFlag = 0;
    end
    answer = answer + 1;
    disp(answer);
end

fclose(fid);

disp(['Day 6, part 2: ' num2str(part2answer)]);