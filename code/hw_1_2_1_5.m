% generate table
major_type = 'B flat';
freq_table = generate_table(major_type);

% params
freq = 8000;
song_list = [
        freq_table(2,5), 0.5;
        freq_table(1,6), 0.5;
        freq_table(2,1), 0.5;
        freq_table(2,5), 1;
        freq_table(1,6), 0.5;
        freq_table(2,1), 0.5;
        freq_table(2,5), 1; %
        freq_table(1,6), 0.5;
        freq_table(2,1), 0.5;
        freq_table(2,5), 1;
        freq_table(1,6), 1;
        freq_table(2,1), 0.5; %
        0, 0.5;
        freq_table(2,1), 1;
        freq_table(2,1), 1;
        freq_table(2,1), 1;
        freq_table(2,1), 0.5; %
        0, 0.5;
        freq_table(2,2), 1;
        freq_table(2,3), 1;
        freq_table(2,4), 1;
        freq_table(2,6), 0.5; %%
        freq_table(3,5), 0.5;
        freq_table(2,6), 0.5;
        freq_table(3,1), 0.5;
        freq_table(3,5), 1;
        freq_table(2,6), 0.5;
        freq_table(3,1), 0.5;
        freq_table(3,5), 1; %
        freq_table(2,6), 0.5;
        freq_table(3,1), 0.5;
        freq_table(3,5), 1;
        freq_table(2,6), 0.5;
        freq_table(3,3), 0.5; 
        freq_table(3,4), 0.5; %
        0, 0.5;
        freq_table(3,5), 2;
        freq_table(2,1), 0.5;
        freq_table(1,6), 0.5;
        freq_table(2,1), 0.5;%
        0, 2.5;
        freq_table(2,3), 2;
        freq_table(1,6), 2;%
        0, 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,2), 0.5; %
        0, 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,3), 0.5;
        freq_table(2,4), 0.5; %
        0, 0.5;
        freq_table(2,3), 2;
        freq_table(2,3), 1;
        freq_table(1,7), 0.5; %
        0, 2;
        freq_table(2,1), 0.5;
        freq_table(2,3), 1;
        freq_table(1,6), 0.5; %
        0, 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,2), 0.5; %
        0, 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,5), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,3), 0.5;
        freq_table(2,4), 0.5; %
        0, 0.5;
        freq_table(2,5), 1.5;
        freq_table(2,1), 0.5;
        freq_table(2,2), 0.5;
        freq_table(2,3), 0.5;
        freq_table(2,4), 0.5; %
        0, 2;
        freq_table(1,6), 0.5;
        freq_table(1,7), 0.5;
        freq_table(2,1), 0.5; 
        freq_table(2,5), 0.5; %
        % 0, 2.5;
        % freq_table(2,4), 0.5;
        % freq_table(2,3), 0.5;
        % freq_table(2,2), 4.5; %
        % freq_table(2,3), 1;
        % freq_table(2,4), 0.5;
        % freq_table(2,3), 1;
        % freq_table(2,2), 1;
        % freq_table(2,1), 4.5; %
        % 0, 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,2), 0.5;
        % freq_table(2,2), 0.5;
        % freq_table(2,2), 0.5; %
        % 0, 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,5), 0.5;
        % freq_table(2,2), 0.5;
        % freq_table(2,3), 0.5;
        % freq_table(2,4), 0.5; %
        % 0, 0.5;
        % freq_table(2,3), 1.5;
        % freq_table(2,1), 0.5;
        % freq_table(2,3), 0.5;
        % freq_table(2,6), 0.5;
        % freq_table(2,7), 0.5; %
        % freq_table(3,1), 4;
    ];
beat = 0.5;
a = 5*exp(1);
b = 5;
lambda_1 = 0.2;
lambda_2 = 0.1;

% generate music
[t, song_data] = generate_music(song_list, beat, a, b, [lambda_1, lambda_2], freq);
plot(t, song_data);
sound(song_data, freq);
audiowrite('hw_1_2_1_5.wav', song_data, freq);