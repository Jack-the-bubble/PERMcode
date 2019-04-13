% classifier - main script
% recognizes given sample by comparing to average teaching samples

prepare_for_recognition = 1;

if prepare_for_recognition == 1
    teachAverage('dwa', 2, 32);
end

l = load('prepared/dwa_avg.mat')
% energyCenters= zeros(

function linearized = linearMap(set)
    Max = max(set);
    Min = min(set);
    a = 1/(Max-Min);
    b= 1 -(Max*a);
    linearized = a*set+b;
end