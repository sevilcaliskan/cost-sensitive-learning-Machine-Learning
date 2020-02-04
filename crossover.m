% cross over the given parents
function pop = crossover(pop)
popNum = size(pop,1);
fNum = size(pop,2);
% shuffle the parents
idx = randperm(popNum);
pop = pop(idx,:);

% cross over from given random point each couple
i = 1;
while i < popNum
    crossP = random('unid',fNum);
    crs = pop(i,crossP:fNum);
    pop(i,crossP:fNum) = pop(i +1 ,crossP:fNum);
    pop(i +1 ,crossP:fNum) = crs;
    i = i + 2;
end

% correct for feature 21.
if fNum == 21
    pop(:,21) = pop(:,20).*pop(:,19);
end
end