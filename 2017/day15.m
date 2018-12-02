% Part 1
startA = 289;
startB = 629;

factorA = 16807;
factorB = 48271;

prevA = startA;
prevB = startB;

numToDivide = 2147483647;

numIter = 40000000;

judgeTotal = 0;
for k = 1:numIter
    prevA = rem(prevA*factorA, numToDivide);
    prevB = rem(prevB*factorB, numToDivide);
    
    binA = dec2bin(prevA, 16);
    binB = dec2bin(prevB, 16);
    
    last16A = binA(end-15:end);
    last16B = binB(end-15:end);
    
    if strcmp(last16A, last16B)
        judgeTotal = judgeTotal + 1;
    end
end

%% Part 2
startA = 289;
startB = 629;

factorA = 16807;
factorB = 48271;

prevA = startA;
prevB = startB;

numToDivide = 2147483647;

numIter = 5000000;

judgeTotal = 0;

passedValuesA = {};
passedValuesB = {};
judgeComparedValues = 0;
while judgeComparedValues < numIter
    prevA = rem(prevA*factorA, numToDivide);
    prevB = rem(prevB*factorB, numToDivide);
    
    if mod(prevA, 4)==0
        binA = dec2bin(prevA, 16);
        last16A = binA(end-15:end);
        passedValuesA{end+1} = last16A;
    end
    
    if mod(prevB, 8) == 0
        binB = dec2bin(prevB, 16);
        last16B = binB(end-15:end);
        passedValuesB{end+1} = last16B;
    end
    
    if length(passedValuesB) > judgeComparedValues && length(passedValuesA) > judgeComparedValues
        judgeComparedValues = judgeComparedValues + 1;
        if strcmp(passedValuesA{judgeComparedValues}, passedValuesB{judgeComparedValues})
            judgeTotal = judgeTotal + 1;
        end
    end
    
end