clear all;
run('signal_mix_task1');

% aa = randn*2;
% bb = randn*10;
% cc = randn*pi;
aa = rand(size(T))*0.8;
bb = rand(size(T))*0.8;
cc = rand(size(T))*pi;

% for i = 1:1000
%   x(i) = x(i) + aa * cos(2 * pi * bb * t(i) + cc);
% end

xZasz = x+ aa.*cos(2* pi * bb.*t+cc);

% transformata Fouriera
Y = fft(xZasz);     % transformata Fouriera

a = abs(Y);     % amplituda sygnału
a = a/L;        % normalizacja amplitudy
a = a(1:L/2+1); % wycięcie istotnej części spektrum
a(2:end-1) = 2*a(2:end-1);

F = angle(Y);   % faza sygnału
F = F(1:L/2+1); % wycięcie istotnej części spektrum


% rozkład amplitudy i częstotliwości
% figure;
% subplot(2, 1, 1);
% plot(a);
% xlabel('frequency');
% ylabel('amplitude');
% subplot(2, 1, 2);
% plot(F);
% xlabel('frequency');
% ylabel('faze');

% sygnał zaszumiony na tle oryginalnego
figure
plot(xZasz);
hold on
run('signal_mix_task1');
plot(x);

% wybranie 3 największych amplitud do odzyskania sygnału, znalezienie
% częstotliwości
maxAmps(1) = max(a);
I = find(a == maxAmps(1));
a = [a(1:I(1)-1) a(I(1)+1:end)];
maxAmps(2) = max(a);
I(2) = find(a == maxAmps(2));
a = [a(1:I(2)-1) a(I(2)+1:end)];
maxAmps(3) = max(a);
I(3) = find(a == maxAmps(3));
% przesunięcie fazowe
for i =1:3
    g(i)=F(I(i));
end

xOdz = zeros(size(t));
for i = 1:N
  xOdz = xOdz + A(i) * cos(2 * pi * B(i) * t + C(i));
end
% porównanie sygnału zaszumionego z odzyskanym
% figure
% plot(xZasz);
% hold on
% plot(xOdz);


% porównanie z sygnałem oryginalnym
figure;
plot(xOdz);
hold on
run('signal_mix_task1');
plot(x);
