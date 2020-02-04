function [cVec,labels, sumOfSquares] = kmeans(train,k)
rowNum = size(train,1);
colNum = size(train,2);
cVecBefore = rand(k, colNum);

%Initialize centers randomly
cVec = zeros(k, colNum);
count = 0;
while count < k
    v = train(ceil(rand*rowNum),:);
    if sum(ismember(cVec,v,'rows'))==0
        count = count +1;
        cVec(count,:) = v;
    end
end

while ~isequal(cVec, cVecBefore)
    %calculate distance
    dist = pdist2(train, cVec);
    [~,idx] = min(dist,[],2);
    cVecBefore = cVec;
    %Find new centers
    for i=1:k
        cVec(i,:) = mean(train(idx==i,:),1);
    end
end
dist = pdist2(train, cVec);
[~,idx] = min(dist,[],2);
labels = idx;
sumOfSquares = 0;
for i=1:k
    sumOfSquares = sumOfSquares + sum(dist(idx==i,i), 'omitnan');
end
%figure
%silhouette(train, idx);

end
