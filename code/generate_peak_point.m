function [y_1,y_2,y_3,y_4,y_4_minus,peak_idx] = generate_peak_point(wav_data, window_name, window_length, bias)

% step 1
y_1 = wav_data.^2;

% step 2
switch (window_name)
    case('boxcar')
        y_2 = conv(y_1, boxbar(window_length));
    case('hanning')
        y_2 = conv(y_1, hanning(window_length));
    case('hamming')
        y_2 = conv(y_1, hamming(window_length));
    case('blackman')
        y_2 = conv(y_1, blackman(window_length));
    otherwise
        ME = MException('window not supported');
        throw(ME);
end

y_2 = y_2(1:end-window_length+1);

% step 3
y_3 = diff(y_2);
y_3 = [y_3;0];

% step 4
y_4 = max(y_3,0);
y_4_minus = max(y_4 - bias,0);

% step 5
interval_array = [];
interval_array(1,1) = 0;
peak_idx = [];
index = 1;
for i = 1:length(y_4_minus)-1
    if(y_4_minus(i) == 0 && y_4_minus(i+1) > 0)
        interval_array(index, 1) = i;
    end
    if(y_4_minus(i) > 0 && y_4_minus(i+1) == 0)
        interval_array(index, 2) = i + 1;
        [~, idx] = max(y_4_minus(interval_array(index, 1):interval_array(index, 2)));
        if(interval_array(index, 1) ~= 0)
            idx = idx + interval_array(index, 1);
            peak_idx = [peak_idx, idx];
        end
        index = index + 1;
    end
end


