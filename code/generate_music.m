function [t,song_data] = generate_music(song_list, beat, a, b, lambdas, freq)
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
    count = 1;
    single_song_data = 0;
    for lambda = lambdas
        single_song_data = single_song_data + lambda * sin(2 * pi * count * single_freq .* t');
        count = count + 1;
    end
    single_envelope = make_envelope((t'-c)/single_time_length,a,b);
    masked_single_song_data = single_song_data .* single_envelope;
    envelope  = envelope + single_envelope;
    song_data = song_data + masked_single_song_data;
end
end

