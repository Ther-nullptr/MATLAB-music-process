load('data/original/Guitar.MAT');
freq = 8000;
len_wave2proc = length(wave2proc);
t_wave2proc = linspace(0, (len_wave2proc-1)/freq, len_wave2proc);

figure(1);

% FFT 1 period
[f1, p1] = generate_fft(wave2proc(1:round(len_wave2proc/10)), freq);
subplot(1,3,1);
plot(f1,p1);
title('1 period');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% FFT 10 periods
[f2, p2] = generate_fft(wave2proc, freq);
subplot(1,3,2);
plot(f2,p2);
title('10 periods');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% FFT 100 periods
[f3, p3] = generate_fft(repmat(wave2proc,[10,1]), freq);
subplot(1,3,3);
plot(f3,p3);
title('100 periods');
xlabel('f (Hz)');
ylabel('|P1(f)|');

f0 = round(freq*10/len_wave2proc);
result = [];
len_interval = 2;
len_pruned = round(length(f3)*(f0*12/4000));
len_per_peak = round(len_pruned/12);

for i = len_per_peak:len_per_peak:11*len_per_peak
    max_val = max(p3((i-len_interval):(i+len_interval)));
    result = [result, max_val];
end

result = result/result(1);
for i = 1:length(result)
    disp([i, result(i)]);
end
    
