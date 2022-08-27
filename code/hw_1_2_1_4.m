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

% envelope param settings
a = 5*exp(1);
b = 5;

% generate the music
beat = 0.5;
total_time_length = sum(song_list(:,2)) * beat;
t = linspace(0, total_time_length, total_time_length * freq);
song_data = 0;
envelope = 0;

for i = 1:1:length(song_list)
    single_freq = song_list(i,1);
    single_time_length = song_list(i,2) * beat;
    if i == 1
        c = 0;
    else 
        c = c + song_list(i-1,2) * beat;
    end
    single_song_data = sin(2 * pi * single_freq .* t') + 0.2 * sin(2 * pi * 2 * single_freq .* t') + 0.3 * sin(2 * pi * 3 * single_freq .* t');
    single_envelope = make_envelope((t'-c)/single_time_length,a,b);
    masked_single_song_data = single_song_data .* single_envelope;
    envelope  = envelope + single_envelope;
    song_data = song_data + masked_single_song_data;
end

% play and save the music
figure(1);
plot(t, song_data);
sound(song_data, freq);
audiowrite('hw_1_2_1_4.wav', song_data, freq);

figure(2);
plot(t(1:50), song_data(1:50));


