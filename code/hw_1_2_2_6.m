[data, freq] = audioread('data/original/fmt.wav');
sound(data, freq);

figure(1);
len = length(data);
t = linspace(0, (len-1)/freq, len);
plot(t, data);
