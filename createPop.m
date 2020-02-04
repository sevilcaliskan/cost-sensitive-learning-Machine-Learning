%create population randomly
function pop = createPop(popNum, colNum)
pop = round(rand(popNum,colNum));
if colNum == 21
    pop(:,21) = pop(:,20).*pop(:,19);
end
end


