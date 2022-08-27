% params
freq = 8000;
base_ratio = 2^(1/12);

% generate table
base_freq = [220, 440, 880];
f_tune_base = [-4, -2, 0, 2, 3, 5, 7]; % F G A bB C D E F
freq_list = base_freq'.*(base_ratio.^ f_tune_base);
freq_table = reshape(freq_list, [3, 7]);
% melody settings
song_list = [
    freq_table(2,5), 1;
    freq_table(2,5), 0.5;
    freq_table(2,6), 0.5;
    freq_table(2,2), 2;
    freq_table(2,1), 1;
    freq_table(2,1), 0.5;
    freq_table(1,6), 0.5; 
    freq_table(2,2), 2;
];

disp(song_list);

beat = 0.5;
a = 5*exp(1);
b = 5;
lambda = [1, 1.4572, 0.9587, 1.0999, 0.0523, 0.1099, 0.3589, 0.1240, 0.1351, 0.0643, 0.0019];

% generate music
[t, song_data] = generate_music(song_list, beat, a, b, lambda, freq);
plot(t, song_data);
sound(song_data, freq);
audiowrite('hw_1_2_3_10.wav', song_data, freq);