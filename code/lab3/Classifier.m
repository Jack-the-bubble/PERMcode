% classifier - main script
% recognizes given sample by comparing to average teaching samples
clear all
prepare_for_recognition = 1;
toRec = load('prepared/trzy_3.mat');



if prepare_for_recognition == 1
    teachAverage('raz', 3, 32);
    teachAverage('dwa', 3, 32);
    teachAverage('trzy', 3, 32);
end


% check if it belongs to the first class
base = load('prepared/raz_avg.mat');
errorSum(1)=calculate_error(toRec, base);

% check if it belongs to second class
base = load('prepared/dwa_avg.mat');
errorSum(2)=calculate_error(toRec, base);

% check if it belongs to third class
base = load('prepared/trzy_avg.mat');
errorSum(3)=calculate_error(toRec, base);


[minEr, index] = min(errorSum);
if minEr < 250
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
    hRC = histogram(toRec.energyCenters, 32);

    figure(2)
    hBC = histogram(base.energyCenters, 32);

    errorSum = sum(abs(hBC.BinCounts-hRC.BinCounts).^2);

    figure(1)
    hRM = histogram(toRec.Ampmeans, 32);
    figure(2)
    hBM = histogram(base.Ampmeans, 32);

    errorSum = errorSum + sum((hBM.BinCounts-hRM.BinCounts).^2);

    figure(1)
    hRD = histogram(toRec.deviations, 32);

    figure(2)
    hBD = histogram(base.deviations, 32);

    errorSum = errorSum + sum((hBD.BinCounts-hRD.BinCounts).^2);
end