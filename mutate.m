% mutate the given population
function pop = mutate(pop, mrate)
popNum = size(pop,1);
fNum = size(pop,2);
totalGen = popNum*fNum;

% calculate the number of total genes to be mutated
mNum = round(totalGen * mrate);
rndB = 0;
i = 0;
while i < mNum
    rnd = random('unid',fNum);
    if rnd~=rndB
       r = ceil(rnd/fNum);
       c = mod(rnd,fNum);
       if c==0
           c=fNum;
       end
       pop(r,c) = double(pop(r,c) == 0);
       i = i + 1;
       rndB = rnd;
    end
end

% correct for feature 21.
if fNum == 21
    pop(:,21) = pop(:,20).*pop(:,19);
end
end