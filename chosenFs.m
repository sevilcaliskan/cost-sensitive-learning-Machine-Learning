% create new datasets with chosen features
function [newtrain, newtest] = chosenFs(train,test, pop)
newtrain = cell(1,size(pop,1));
newtest = cell(1,size(pop,1));

% create train set for each population
for i = 1:size(pop,1)
    trainp = train;
    j = size(pop,2);
    while j~=0
        if pop(i,j)== 0
            trainp(:,j)=[];
        end
        j = j-1;
    end
    newtrain{1,i} = trainp;
end

% create test set for each population
for i = 1:size(pop,1)
    testp = test;
    j = size(pop,2);
    while j~=0
        if pop(i,j)== 0
            testp(:,j)=[];
        end
        j = j-1;
    end
    newtest{1,i} = testp;
end
end