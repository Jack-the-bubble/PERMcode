data = createTraitsMatrix();
figure(2)
plot(data);




function traits = createTraitsMatrix()
    traits = [];
    for i=1:1:3
        nazwa = sprintf('cut/dwa_%g.wav',i);
        freq = findAvgFreq(nazwa);
        traits = [traits freq];
    end
end


function freq = findAvgFreq(path)
    [samples, Fs] = audioread(path);
    windows = floor(length(samples)/32);
    overlap = 0;
    figure(1);
    spectrogram(samples, windows, overlap, [], Fs, 'yaxis');
    [s,w,t,P,fc] = spectrogram(samples, windows, overlap, [], Fs, 'yaxis');
    s=abs(s);

    % liczenie średniej energii i odcylenia std w każdym oknie
    power = zeros(32, 1);
    for j = 1:32
        for i = 1:513
            power(j) = power(j)+s(i, j)^2;
        end
    end

    freq = zeros(32, 1);
    for j = 1:32
        for i = 1:513
            freq(j) = freq(j)+w(i)*(s(i, j)^2)/(power(j));
        end
    end

    mean_ = sum(freq)/32;
    std_ = std(freq);
    freq = (freq - mean_)/std_;
end