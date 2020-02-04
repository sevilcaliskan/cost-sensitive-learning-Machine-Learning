% calculate the fitness useing total cost
function fit = fitness(obj)
obj = 1./(obj); % we now that obj will never be zero since each feature have a cost
fit = obj./sum(obj);
end