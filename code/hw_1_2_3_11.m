% params
freq = 8000;
base_ratio = 2^(1/12);

% generate harmonic data
[data, ~] = audioread('data/original/fmt.wav');
harmonic_full_data = get_harmonic(data, freq);

% generate table
base_freq = [220, 440, 880];
f_tune_base = [-4, -2, 0, 2, 3, 5, 7]; % F G A bB C D E F
freq_list = base_freq'.*(base_ratio.^ f_tune_base);
freq_table = reshape(freq_list, [3, 7])/2^(1/2);
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

beat = 0.5;
a = 5 * exp(1);
b = 5;

% generate music
[t, song_data] = generate_music_with_harmonic(song_list, beat, a, b, harmonic_full_data, freq);

plot(t, song_data);
sound(song_data, freq);
audiowrite('hw_1_2_3_11.wav', song_data, freq);