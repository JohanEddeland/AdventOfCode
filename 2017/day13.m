%% Part 1
% 036 32 13 70
% Depth 2
time = linspace(0,10, 1000);
scannerPos = getScannerPos(3,time);
plot(time, scannerPos);
shg;
disp('Depth 2');
disp(num2str(getScannerPos(2,1)))
disp(num2str(getScannerPos(2,2)))
disp(num2str(getScannerPos(2,3)))
disp(num2str(getScannerPos(2,4)))
disp(num2str(getScannerPos(2,5)))
disp(num2str(getScannerPos(2,6)))
% 1 1
% 2 2
% 3 1
% 4 2
% 5 1
% 6 2

disp('Depth 3');
disp(num2str(getScannerPos(3,1)))
disp(num2str(getScannerPos(3,2)))
disp(num2str(getScannerPos(3,3)))
disp(num2str(getScannerPos(3,4)))
disp(num2str(getScannerPos(3,5)))
disp(num2str(getScannerPos(3,6)))
%%
fid = fopen('day13input.txt');
tline = fgetl(fid);
layers = [];
while ischar(tline)
    splitStrings = strsplit(tline, ':');
    layerString = regexprep(splitStrings{1}, '\s+', '');
    depthString = regexprep(splitStrings{2}, '\s+', '');
    layer = eval(layerString);
    depth = eval(depthString);
    matlabLayer = layer + 1; % Indexing from 1 instead of zero
    layers(matlabLayer) = depth;
    tline = fgetl(fid);
end
fclose(fid);
layerDirection = ones(1, length(layers));

tripSeverity = Inf; % Total trip severity
delay = 0;

layersFromStart = layers;

while tripSeverity > 0
    layers = layersFromStart;
    if delay == 1
        disp(['Day 13, part 1: ' num2str(tripSeverity)]);
    end
    tripSeverity = 0;
    currentLayerNumber = 1;
    for k = delay+1:length(layers) + delay
        if mod(k, 1000) == 0
            disp(k);
        end
        % We now move into layer 1
        
        % Check if there is a scanner here
        thisLayer = layers(currentLayerNumber);
        if thisLayer == 0
            % Do nothing
        elseif getScannerPos(thisLayer, k) == 1
            tripSeverity = tripSeverity + (k-1)*length(thisLayer);
            if delay > 0
                break;
            end
        end
        currentLayerNumber = currentLayerNumber + 1;
        
    end
    delay = delay + 1;
end

bestDelay = delay - 1;
disp(['Day 13, part 2: ' num2str(bestDelay)]);

function scannerPos = getScannerPos(depth, time)
offset = mod(time - 1, 2*(depth - 1));
if offset < depth
    scannerPos = offset + 1;
else
    scannerPos = 2*(depth-1) - offset + 1;
end
end