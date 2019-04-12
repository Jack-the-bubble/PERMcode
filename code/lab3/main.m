clear all;
[s1, Fs] = audioread('cut/dwa_1.wav');
s1;
windows = floor(length(s1)/32);
ovrlap = 0;
spectrogram(s1, windows, ovrlap, [], Fs, 'yaxis');
[s, w, t, P, fc] = spectrogram(s1, windows, ovrlap, [], Fs, 'yaxis')
s=abs(spectrogram(s1, windows, ovrlap, [], Fs, 'yaxis'));
figure(2)
plot(s);

% liczenie średniej energii i odcylenia std w każdym oknie
sum1 = zeros(32, 1);
for j = 1:32
    for i = 1:513
        sum1(j) = sum1(j)+s(i, j)^2;
    end
    sum1(j) = sum1(j)/513;
end
figure(3)

bigMean1 = sum(sum1)/32;
bigStd1 = std(sum1);
sum1 = (sum1 - bigMean1)/bigStd1;
plot(sum1)


% nagranie dwa_2
[s_2, Fs] = audioread('cut/dwa_2.wav');
figure(1)
windows = floor(length(s_2)/32);
ovrlap = 0;
% spectrogram(s2, windows, ovrlap, [], Fs, 'yaxis');
[s2, w, t, P, fc] = spectrogram(s_2, windows, ovrlap, [], Fs, 'yaxis')
s2=abs(spectrogram(s_2, windows, ovrlap, [], Fs, 'yaxis'));

% liczenie średniej energii i odcylenia std w każdym oknie
sum2 = zeros(32, 1);
for j = 1:32
    for i = 1:513
        sum2(j) = sum2(j)+s2(i, j)^2;
    end
    sum2(j) = sum2(j)/513;
end
figure(3)

bigMean2 = sum(sum2)/32;
bigStd2 = std(sum2);
sum2 = (sum2 - bigMean2)/bigStd2;

%nagranie dwa_3
[s_3, Fs] = audioread('cut/dwa_3.wav');
windows = floor(length(s_3)/32);
ovrlap = 0;
% spectrogram(s3, windows, ovrlap, [], Fs, 'yaxis');
[s3, w, t, P, fc] = spectrogram(s_3, windows, ovrlap, [], Fs, 'yaxis')
s3=abs(spectrogram(s_3, windows, ovrlap, [], Fs, 'yaxis'));

% liczenie średniej energii i odcylenia std w każdym oknie
sum3 = zeros(32, 1);
for j = 1:32
    for i = 1:513
        sum3(j) = sum3(j)+s3(i, j)^2;
    end
    sum3(j) = sum3(j)/513;
end
figure(3)

bigMean3 = sum(sum3)/32;
bigStd3 = std(sum3);
sum3 = (sum3 - bigMean3)/bigStd3;

%nagranie dwa_4
[s_4, Fs] = audioread('cut/dwa_4.wav');
windows = floor(length(s_4)/32);
ovrlap = 0;
% spectrogram(s3, windows, ovrlap, [], Fs, 'yaxis');
[s4, w, t, P, fc] = spectrogram(s_4, windows, ovrlap, [], Fs, 'yaxis')
s4=abs(spectrogram(s_4, windows, ovrlap, [], Fs, 'yaxis'));

% liczenie średniej energii i odcylenia std w każdym oknie
sum4 = zeros(32, 1);
for j = 1:32
    for i = 1:513
        sum4(j) = sum4(j)+s4(i, j)^2;
    end
    sum4(j) = sum4(j)/513;
end
figure(3)

bigMean4 = sum(sum4)/32;
bigStd4 = std(sum4);
sum4 = (sum4 - bigMean4)/bigStd4;



