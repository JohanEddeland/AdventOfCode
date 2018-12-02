% Part 1
width = 999;
mySquare = zeros(width);
x = ceil(width/2); % x position
y = ceil(width/2); % y position

startPointX = x;
startPointY = y;

myInput = 289326;

for currentNumber = 1:min(width^2, myInput)
    if x == 1
        up = 0;
    else
        up = mySquare(x-1,y);
    end
    
    if x == width
        down = 0;
    else
        down = mySquare(x+1,y);
    end
    
    if y == 1
        left = 0;
    else
        left = mySquare(x,y-1);
    end
    
    if y == width
        right = 0;
    else
        right = mySquare(x,y+1);
    end
    
    mySquare(x,y) = currentNumber;
    
    if currentNumber == myInput
        disp(['Day 3, part 1: ' num2str(abs(x - startPointX) + abs(y - startPointY))]);
    end
    
    if left ~= 0 && up == 0
        % Go up
        x = x-1;
    elseif down ~= 0
        % Go left
        y = y-1;
    elseif right ~=0
        % Go down
        x = x+1;
    else
        % Go right
        y = y+1;
    end
end

% Part 2

width = 999;
mySquare = zeros(width);
x = ceil(width/2); % x position
y = ceil(width/2); % y position

startPointX = x;
startPointY = y;

myInput = 289326;

% First iteration, add a 1
mySquare(x,y) = 1;
y = y+1;

for currentNumber = 2:min(width^2, myInput)
    if x == 1
        up = 0;
    else
        up = mySquare(x-1,y);
    end
    
    if x == width
        down = 0;
    else
        down = mySquare(x+1,y);
    end
    
    if y == 1
        left = 0;
    else
        left = mySquare(x,y-1);
    end
    
    if y == width
        right = 0;
    else
        right = mySquare(x,y+1);
    end
    
    % Calculate all diagonal values values around it
    if x == 1 || y == 1
        upleft = 0;
    else
        upleft = mySquare(x-1, y-1);
    end
    
    if x == 1 || y == width
        upright = 0;
    else
        upright = mySquare(x-1, y+1);
    end
    
    if x == width || y == 1
        downleft = 0;
    else
        downleft = mySquare(x+1, y-1);
    end
    
    if x == width || y == width
        downright = 0;
    else
        downright = mySquare(x+1, y+1);
    end
    
    mySquare(x,y) = up + down + left + right + ...
        upleft + upright + downleft + downright;
    
    if mySquare(x,y) > myInput
        disp(['Day 3, part 2: ' num2str(mySquare(x,y))]);
        break
    end
    
    if left ~= 0 && up == 0
        % Go up
        x = x-1;
    elseif down ~= 0
        % Go left
        y = y-1;
    elseif right ~=0
        % Go down
        x = x+1;
    else
        % Go right
        y = y+1;
    end
end