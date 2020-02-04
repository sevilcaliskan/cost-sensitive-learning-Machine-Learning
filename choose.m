% choose new population
function newPop = choose(pop, fitn, crRate, mRate, selection)
popNum = size(pop,1);
fNum = size(pop,2);

% number of parents to be moved directly and to be crossovered
newPop = zeros(popNum, fNum);
crNum = round(crRate*popNum) + mod(round(crRate*popNum),2);
select = popNum - crNum;
%fitn = fitness(obj);

% choose with tournament for directly moved
if strcmp(selection,'tournament')
    i = 1;
    while i <= select
        rn1 = random('unid',size(pop,1));
        rn2 = random('unid',size(pop,1));
        if (rn1~=rn2)
            mxfit = max(fitn(rn1), fitn(rn2));
            idx = double(mxfit == fitn(rn1))*rn1 + (1 - double(mxfit == fitn(rn1)))*rn2;
            newPop(i,:) = pop(idx,:);
            pop(idx,:) = [];
            fitn(idx) = [];
            i = i + 1;
        end
    end
end

% choose with roulette wheel for directly moved
if strcmp(selection,'roulette')
    cumP = zeros(1,popNum);
    fitB = 0;
    for i= 1:popNum
        cumP(1,i) = fitn(1,i) + fitB;
        fitB = cumP(1,i);
    end
    
    chosen = zeros(1,select);
    i=1;
    while i <= select
        rnd = rand;
        indices = rnd < cumP;
        idx = find(indices,1);
        if ~ismember(idx, chosen);
            newPop(i,:) = pop(idx,:);
            chosen(1,i) = idx;
            i = i + 1;
        end
    end
    pop(chosen,:) = [];
end

% crossover the rest
newPop(select+1:popNum,:) = crossover(pop);
% mutate new population
newPop = mutate(newPop, mRate);
end