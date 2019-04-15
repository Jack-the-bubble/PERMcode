function prepare_to_rec(num)
    for i = 1: num
        featuresPrepare(strcat('cut/raz_', num2str(i), '.wav'), strcat('raz_', num2str(i)), 'teach');
        featuresPrepare(strcat('cut/dwa_', num2str(i), '.wav'), strcat('dwa_', num2str(i)), 'teach');
        featuresPrepare(strcat('cut/trzy_', num2str(i), '.wav'), strcat('trzy_', num2str(i)), 'teach');
end