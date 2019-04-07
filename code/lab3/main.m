clear all;
s1 = audioread('cut/dwa_2.wav');
figure(1)
s1
windows = 2048;
ovrlap = windows / 2;
spectrogram(s1, windows, ovrlap, [], 48000, 'yaxis')
s=abs(spectrogram(s1, windows, ovrlap, [], 48000, 'yaxis'));
figure(2)
plot(s);

