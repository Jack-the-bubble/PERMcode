% sound_path - path to the sound we want to process
% file_name - saved vectors will have a prefix specified here
% mode - a string which decides where the vectors will be saved
%       'teach' will save to prepared/ folder
%       'rec' will save to toRec/ folder

function [energyCenters, Ampmeans, deviations] = featuresPrepare(sound_path, file_name, mode)
    windowsNum = 32;
    % wgrywanie pliku
    [s1, Fs] = audioread(sound_path);
    %przygotowanie spektrogramu
    windows = floor(length(s1)/windowsNum);
    ovrlap = 0;

    % obserwacja wyników
    % spectrogram(s1, windows, ovrlap, [], Fs, 'yaxis');

    % pobranie macierzy transformat Fouriera oraz wektora częstotliwości
    [s, w] = spectrogram(s1, windows, ovrlap, [], Fs, 'yaxis')

    % Liczenie cech nagrania
    amps = abs(s);
    energyCenters= zeros(windowsNum, 1);
    Ampmeans = zeros(windowsNum, 1);
    deviations = zeros(windowsNum, 1)
    for i = 1:windowsNum
    %     Center of Energy
        energyCenters(i) = sum(w.*(amps(:, i).^2))/sum((amps(:, i).^2));
    %     średnia mocy
        Ampmeans(i) = mean(amps(:, i));
    %     odchylenie standardowe Center of gravity
        deviations(i) = std(w.*(amps(:, i)).^2)/sum((amps(:, i).^2));
    end

    % normalizacja cech
    COGmean = mean(energyCenters);
    COGdev = std(energyCenters);
    energyCenters = (energyCenters - COGmean)/COGdev;

    AmpMean = mean(Ampmeans);
    AmpDev = std(Ampmeans);
    Ampmeans = (Ampmeans - AmpMean)/AmpDev;

    devMean = mean(deviations);
    devDev = std(deviations);
    deviations = (deviations - devMean)/devDev;
    
    %zapis cech do późniejszego porównania w klasyfikatorze
    if strcmp(mode, 'teach')
        save(strcat('prepared/', file_name), 'energyCenters', 'Ampmeans', 'deviations');
    elseif strcmp(mode, 'rec')
        save(strcat('toRec/', file_name), 'energyCenters', 'Ampmeans', 'deviations');
    end
    
end
    
