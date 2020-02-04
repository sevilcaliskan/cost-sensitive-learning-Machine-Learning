% calculate misclassification rate for each population
function [obj] = missclass(train, test, trainlabel, testlabel)
popNum = size(train,2);
obj = zeros(1, popNum);
for i = 1:popNum
    Mdl = fitctree(train{1,i},trainlabel);
    label = predict(Mdl,test{1,i});
    C = confusionmat(testlabel,label);
    missC = C.*(1-eye(size(C,1)));
    obj(1,i) = sum(sum(missC));
end
end