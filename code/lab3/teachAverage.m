% create average of teaching samples
%file name - base name of the sample we want to take average of
% samples_num - number of files we want to take average of
% windows - number of values in each feature type in each sample 

function teachAverage(file_name, pocz, samples_num, windows)
    
    energyCenters = zeros(windows, 1);
    Ampmeans = zeros(windows, 1);
    deviations = zeros(windows, 1);
    for i = pocz:samples_num
        l = load(strcat('prepared/', file_name, '_', num2str(i), '.mat'));
        energyCenters = energyCenters+l.energyCenters;
        Ampmeans =Ampmeans + l.Ampmeans;
        deviations =deviations + l.deviations;
    end
    energyCenters = energyCenters/samples_num;
    Ampmeans =Ampmeans /samples_num;
    deviations =deviations /samples_num;
    save(strcat('prepared/', file_name, '_avg'), 'energyCenters', 'Ampmeans', 'deviations');
end