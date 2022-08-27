function [averaged_harmonic_wave_data_result] = get_harmonic(data, freq)

len = length(data);
[~, ~, ~, ~, ~, pos] = generate_peak_point(data, 'hanning', len/100, 0.001);

interval_len = 200;
interval_len_2 = 300;
base_freq_list = [];
harmonic_wave_weight = [];
for i = 1:1:length(pos) - 1
    idx_1 = pos(i);
    idx_2 = pos(i+1);
    data_repeat = repmat(data(idx_1:idx_2), [100, 1]);
    [f,p] = generate_fft(data_repeat, freq);
    [max_p, idx] = max(p); % max value
    max_p_base_final = 0;
    idx_final = 0;
    for n = 1:6
        pos_2 = round(idx/n);
        [max_p_base, idx_base] = max(p(pos_2-interval_len:pos_2+interval_len));
        if(max_p_base >= 0.2*max_p)
            max_p_base_final = max_p_base;
            idx_final = pos_2-interval_len+idx_base;
        end
    end
    base_freq_list = [base_freq_list, f(idx_final)];
    for n = 1:10
        pos_2 = round(idx_final*n);
        [max_p_base, idx_base] = max(p(pos_2-interval_len_2:pos_2+interval_len_2));
        if(max_p_base >= 0.05*max_p)
            harmonic_wave_weight(i,n) = max_p_base/max_p_base_final;
        else
            harmonic_wave_weight(i,n) = 0;
        end
    end
end

standard_freq_list = [];
for base_freq = base_freq_list
    standard_freq_list = [standard_freq_list, search_in_standard_table(base_freq)];
end

averaged_harmonic_wave_data = containers.Map;
averaged_harmonic_wave_data_num = containers.Map;
count = 1;
for standard_freq = standard_freq_list
    struct_idx = num2str(standard_freq);
    if(isfield(averaged_harmonic_wave_data, struct_idx))
        averaged_harmonic_wave_data(struct_idx) = averaged_harmonic_wave_data(struct_idx) + harmonic_wave_weight(count,:);
        averaged_harmonic_wave_data_num(struct_idx) = averaged_harmonic_wave_data_num(struct_idx) + 1;
    else
        averaged_harmonic_wave_data(struct_idx) = harmonic_wave_weight(count,:);
        averaged_harmonic_wave_data_num(struct_idx) = 1;
    end
    count = count + 1;
end

averaged_harmonic_wave_data_result = [];
for key = averaged_harmonic_wave_data.keys
    averaged_harmonic_wave_data_result = [averaged_harmonic_wave_data_result; [str2double(key{1}), averaged_harmonic_wave_data(key{1}) / averaged_harmonic_wave_data_num(key{1})]];
end

end
