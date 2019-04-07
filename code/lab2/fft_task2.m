run('signal_mix_task1');

Y = fft(x);     % transformata Fouriera

A = abs(Y);     % amplituda sygnału
A = A/L;        % normalizacja amplitudy
A = A(1:L/2+1); % wycięcie istotnej części spektrum
A(2:end-1) = 2*A(2:end-1);

F = angle(Y);   % faza sygnału
F = F(1:L/2+1); % wycięcie istotnej części spektrum

subplot(2, 1, 1);
plot(A);
xlabel('frequency');
ylabel('amplitude');
subplot(2, 1, 2);
plot(F);
xlabel('frequency');
ylabel('faze');