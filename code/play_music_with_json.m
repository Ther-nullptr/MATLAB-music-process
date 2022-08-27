function [t, song_data] = play_music_with_json(json_path)
    % load json and get elements
    json_data = loadjson(json_path);
    major = json_data.major;
    beat = json_data.beat;
    freq = json_data.freq;
    lambda = json_data.lambda;
    song_raw_data = json_data.data;
    
     % genetate table
    freq_table = generate_table(major);
    song_list = [];
    
    % generate song_list
    for i = 1:length(song_raw_data)
        if(i ~= 0)
            tune_data = freq_table(song_raw_data(i,1), song_raw_data(i,2));
        else
            tune_data = 0;
        end
        continue_time = song_raw_data(i,3);
        song_list = [song_list;tune_data, continue_time];
    end
    
    % play music
    [t, song_data] = generate_music(song_list, beat, 5*exp(1), 5, lambda, freq);
    sound(song_data, freq);
end

