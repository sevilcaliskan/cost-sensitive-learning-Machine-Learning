% calculate the total feature cost of population
function costVec = chosenCost(pop, costs)
costVec = zeros(1,size(pop,1));
calcCost = @(x) sum( x(1:20)'.*costs{1,2});
for i=1:size(pop,1)
    costVec(1,i) = calcCost(pop(i,:));
end
end
