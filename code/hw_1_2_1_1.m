close all;
clc;

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

% generate the music
beat = 0.5;
song_data = [];
for i = 1:1:length(song_list)
    single_freq = song_list(i,1);
    single_time_length = song_list(i,2) * beat;
    t = linspace(0, single_time_length, single_time_length * freq);
    single_song_data = sin(2 * pi * single_freq .* t');
    song_data = [song_data; single_song_data];
end

% play and save the music
plot([0:length(song_data)-1]/freq, song_data);
sound(song_data, freq);
audiowrite('hw_1_2_1_1.wav', song_data, freq);

