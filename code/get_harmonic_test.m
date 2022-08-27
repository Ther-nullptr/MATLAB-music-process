[data, freq] = audioread('data/original/fmt.wav');

result = get_harmonic(data, 8000);
disp(result);