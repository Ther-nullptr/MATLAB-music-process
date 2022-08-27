[data, freq] = audioread('data/original/fmt.wav');
sound(data, freq);

figure(1);
len = length(data);
t = linspace(0, (len-1)/freq, len);
[y_1, y_2, y_3, y_4, ~, ~] = generate_peak_point(data, 'hanning', len/100);

subplot(5,1,1);
plot(t, data);
ylabel('input');

subplot(5,1,2);
plot(t, y_1);
ylabel('y_1');

subplot(5,1,3);
plot(t, y_2);
ylabel('y_2');

subplot(5,1,4);
plot(t, y_3); 
ylabel('y_3');

subplot(5,1,5);
plot(t, max(y_4 - 0.001,0));
ylabel('y_4');
