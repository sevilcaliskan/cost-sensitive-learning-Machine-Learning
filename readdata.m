% read data
anntrain = dlmread('ann-train.txt');
anntest = dlmread('ann-test.txt');
fid   = fopen('costs.txt');
costs = textscan(fid, '%s%f');
fclose(fid);

% add last column name
costs{1,1}(21,1)={'last'};
costs{1,1} = cellfun(@erasePunctuation, costs{1,1}, 'uniformoutput', false);

% create train - test 
train = anntrain;
test = anntest;
train(:,22)=[];
test(:,22)=[];
trainlabel = anntrain(:,22);
testlabel = anntest(:,22);

% % convert to table (for decision tree
% train = array2table(train, 'VariableNames',costs{1,1});
% test = array2table(test, 'VariableNames',costs{1,1});
% 
% % convert categorical features
% cellOfColumnNames = costs{1,1}(2:16);
% tblOut = [train(:,~ismember(train.Properties.VariableNames,cellOfColumnNames))...
% varfun(@categorical,train,'inputvariables',cellOfColumnNames)];
% % or, unpacked a little bit:
% newTable = varfun(@categorical,train,'inputvariables',cellOfColumnNames);
% tblOut = [train(:,~ismember(train.Properties.VariableNames,cellOfColumnNames))...
% newTable];
% train = tblOut;
% 
% tblOut = [test(:,~ismember(test.Properties.VariableNames,cellOfColumnNames))...
% varfun(@categorical,test,'inputvariables',cellOfColumnNames)];
% % or, unpacked a little bit:
% newTable = varfun(@categorical,test,'inputvariables',cellOfColumnNames);
% tblOut = [test(:,~ismember(test.Properties.VariableNames,cellOfColumnNames))...
% newTable];
% test = tblOut;

%%%%


% Go into GA
colNum = size(train,2);
popNum = colNum^2;
pop = createPop(popNum,colNum);
crRate = 0.5 ;
mRate = 0.001 ;
iteration = 150;

i = 0;
while i < iteration
    [newtrain, newtest] = chosenFs(train , test, pop);
    missccost = missclass(newtrain, newtest, trainlabel, testlabel);
    fcost = chosenCost(pop, costs);
    totalCost = missccost + fcost
    fit = fitness(totalCost);
    popB = pop;
    pop = choose(pop, fit, crRate, mRate, 'tournament');
    i = i + 1
end

%Age, sex, onthyroxine, queryonthyroxine, onantithyroidmedication, sick, 
%pregnant, thyroidsurgery, I131treatment, queryhypothyroid, queryhyperthyroid, 
%lithium, goiter, tumor, hypopituitary, psych, TSH, T3, TT4, T4U, last
