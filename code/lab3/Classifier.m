% classifier - main script
% recognizes given sample by comparing to average teaching samples
clear all
pocz = 1;
prepare_for_recognition = 1;
toRec = load('toRec/raz_6.mat');



if prepare_for_recognition == 1
    teachAverage('raz', pocz, 3, 32);
    teachAverage('dwa', pocz, 3, 32);
    teachAverage('trzy', pocz, 3, 32);
end


% check if it belongs to the first class
base = load('prepared/raz_avg.mat');
errorSum = zeros(3, 3);
errorSum(1, :)=calculate_error2(toRec, base);

% check if it belongs to second class
base = load('prepared/dwa_avg.mat');
errorSum(2, :)=calculate_error2(toRec, base);

% check if it belongs to third class
base = load('prepared/trzy_avg.mat');
errorSum(3, :)=calculate_error2(toRec, base);

% find rows with smallest value in each column
[minPom, minCount] = min(errorSum);

% how many times has each class occured
p(1) = sum(minCount == 1);
p(2) = sum(minCount == 2);
p(3) = sum(minCount == 3);

% find the class that occured most times
[idx, class]= max(p);

% check if it is the lone leader and no more classes occured the same
% amount of times
check = sum(p == p(class));
if check > 1
    errVal = 0;
else
    errVal =  sum(errorSum(class, :));
end
    
if errVal< 200 & errVal > 0
    if class == 1
        disp('raz');
    elseif class == 2
        disp('dwa');
    elseif class == 3
        disp('trzy');
    end
%     if voting couldn't determine the command, try the overall error
elseif errVal == 0
    [minEr, index] = min([sum(errorSum(1, :)) sum(errorSum(2, 1:3)) sum(errorSum(3,1:3))]);
    if minEr < 250
        if index == 1
            disp('raz');
        elseif index == 2
            disp('dwa');
        elseif index == 3
            disp('trzy');
        end
    else
        disp('could not recognize');
    end
%     if voting was finished correctly but the error was too big, do not
%     recognize
else
    disp('could not recognize');
end
% [minEr, index] = min(errorSum);
% if minEr < 250
%     if index == 1
%         disp('raz');
%     elseif index == 2
%         disp('dwa');
%     elseif index == 3
%         disp('trzy');
%     end
% else
%     disp('not recognized');
% end

function errorSum = calculate_error3(toRec, base)
     errorSum = zeros(1, 3);
    figure(1)
    hRC = histogram(linearMap(toRec.energyCenters), 32);

    figure(2)
    hBC = histogram(linearMap(base.energyCenters), 32);

    errorSum(1, 1) = sum(abs(hBC.BinCounts-hRC.BinCounts).^2);

    figure(1)
    hRM = histogram(linearMap(toRec.Ampmeans), 32);
    figure(2)
    hBM = histogram(linearMap(base.Ampmeans), 32);

    errorSum(1, 2) = sum((hBM.BinCounts-hRM.BinCounts).^2);

    figure(1)
    hRD = histogram(linearMap(toRec.deviations), 32);

    figure(2)
    hBD = histogram(linearMap(base.deviations), 32);

    errorSum(1, 3) = sum((hBD.BinCounts-hRD.BinCounts).^2);
end

% every feature is calculated separately
function errorSum = calculate_error2(toRec, base)
    errorSum = zeros(1, 3);
    errorSum(1, 1) = sum((toRec.energyCenters - base.energyCenters).^2);
    errorSum(1, 2) = sum((toRec.Ampmeans - base.Ampmeans).^2);
    errorSum(1, 3) = sum((toRec.deviations - base.deviations).^2);
end

% all errors are added in one class
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