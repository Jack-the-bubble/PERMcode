% classifier - main script
% recognizes given sample by comparing to average teaching samples
clear all
pocz = 5
prepare_for_recognition = 1;
toRec = load('prepared/raz_8.mat');



if prepare_for_recognition == 1
    teachAverage('raz', pocz, 8, 32);
    teachAverage('dwa', pocz, 8, 32);
    teachAverage('trzy', pocz, 8, 32);
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