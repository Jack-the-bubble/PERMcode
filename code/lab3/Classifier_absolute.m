%classifier that compares directly to teaching samples, not averages

% number of teaching samples in each class
numOfTeach = 4;
toRec = load('toRec/dwa_8.mat');

errorSum = zeros(numOfTeach, 3);

for i = 1:numOfTeach
   % check if it belongs to the first class
base = load(strcat('prepared/raz_', num2str(i),'.mat'));
errorSum(i, 1)=calculate_error(toRec, base);

% check if it belongs to second class
base = load(strcat('prepared/dwa_', num2str(i),'.mat'));
errorSum(i, 2)=calculate_error(toRec, base);

% check if it belongs to third class
base = load(strcat('prepared/trzy_', num2str(i),'.mat'));
errorSum(i, 3)=calculate_error(toRec, base);
    
    
end

[minEr, index] = min(min(errorSum));

if minEr < 1000
    if index == 1
        disp('raz');
    elseif index == 2
        disp('dwa');
    elseif index == 3
        disp('trzy');
    end
else
    disp('not recognized');
end

function errorSum = calculate_error(toRec, base)
    figure(1)
    hRC = histogram(linearMap(toRec.energyCenters), 32);

    figure(2)
    hBC = histogram(linearMap(base.energyCenters), 32);

    errorSum = sum(abs(hBC.BinCounts-hRC.BinCounts).^2);

    figure(1)
    hRM = histogram(linearMap(toRec.Ampmeans), 32);
    figure(2)
    hBM = histogram(linearMap(base.Ampmeans), 32);

    errorSum = errorSum + sum((hBM.BinCounts-hRM.BinCounts).^2);

    figure(1)
    hRD = histogram(linearMap(toRec.deviations), 32);

    figure(2)
    hBD = histogram(linearMap(base.deviations), 32);

    errorSum = errorSum + sum((hBD.BinCounts-hRD.BinCounts).^2);
end

function linearized = linearMap(set)
    Max = max(set);
    Min = min(set);
    a = 1/(Max-Min);
    b= 1 -(Max*a);
    linearized = a*set+b;
end 