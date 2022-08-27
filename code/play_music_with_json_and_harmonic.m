function [t, song_data] = play_music_with_json_and_harmonic(json_path, harmonic_full_data)
    % load json and get elements
    json_data = loadjson(json_path);
    major = json_data.major;
    beat = json_data.beat;
    freq = json_data.freq;
    song_raw_data = json_data.data;
    
    % genetate table
    freq_table = generate_table(major);
    
    % generate song_list
    song_list = [];
    for i = 1:length(song_raw_data)
        tune_data = freq_table(song_raw_data(i,1), song_raw_data(i,2));
        continue_time = song_raw_data(i,3);
        song_list = [song_list; tune_data, continue_time];
    end

    % play music
    % generate music
    [t, song_data] = generate_music_with_harmonic(song_list, beat, 5*exp(1), 5, harmonic_full_data, freq);
    sound(song_data, freq);
end

