load('data/original/Guitar.MAT');
freq = 8000;
len_realwave = length(realwave);
len_wave2proc = length(wave2proc);
t_realwave = linspace(0, (len_realwave-1)/freq, len_realwave);
t_wave2proc = linspace(0, (len_wave2proc-1)/freq, len_wave2proc);

% plot
figure(1);
plot(t_realwave, realwave);
xlabel('t (8kHz Sampled)');
ylabel('realwave');

figure(2);
plot(t_wave2proc, wave2proc);
xlabel('t (8kHz Sampled)');
ylabel('wave2proc');

figure(3);
plot(t_wave2proc, wave2proc - realwave);
xlabel('t (8kHz Sampled)');
ylabel('wave2proc - realwave');

% resample
realwave_resample = resample(realwave, 50, 1);
len_realwave_resample = length(realwave_resample);
single_period_data = 0;
for i = 0:1:9
    single_period_data = single_period_data + realwave_resample(i*(len_realwave_resample/10)+1:(i+1)*(len_realwave_resample/10));
end
single_period_data = single_period_data / 10;
repeated_data = repmat(single_period_data, [10, 1]);
repeated_data = resample(repeated_data, 1, 50);

figure(4);
subplot(3,1,1);
plot(t_wave2proc, repeated_data);
xlabel('t (8kHz Sampled)');
ylabel('realwave after averaged');

subplot(3,1,2);
plot(t_wave2proc, wave2proc);
xlabel('t (8kHz Sampled)');
ylabel('wave2proc');

subplot(3,1,3);
plot(t_wave2proc, wave2proc - repeated_data);
xlabel('t (8kHz Sampled)');
ylabel('wave2proc - repeated data');

