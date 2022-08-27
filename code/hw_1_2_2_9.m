[data, freq] = audioread('data/original/fmt.wav');
sound(data, freq);

figure(1);
len = length(data);
t = linspace(0, (len-1)/freq, len);
[y_1, y_2, y_3, y_4, y_4_minus, pos] = generate_peak_point(data, 'hanning', len/100, 0.001);

subplot(6,1,1);
plot(t, data);
ylabel('input');

subplot(6,1,2);
plot(t, y_1);
ylabel('y_1');

subplot(6,1,3);
plot(t, y_2);
ylabel('y_2');

subplot(6,1,4);
plot(t, y_3); 
ylabel('y_3');

subplot(6,1,5);
plot(t, y_4);
ylabel('y_4');

subplot(6,1,6);
plot(t, y_4_minus);
ylabel('y_4 after bias');
hold on;

for i = 1:length(pos)
    idx = pos(i);
    plot(t(idx),y_4_minus(idx),'*');
end

% 29 max vals
figure(2);
interval_len = 200;
interval_len_2 = 300;
base_freq_list = [];
harmonic_wave_weight = [];
for i = 1:1:28
    subplot(5,6,i);
    idx_1 = pos(i);
    idx_2 = pos(i+1);
    data_repeat = repmat(data(idx_1:idx_2), [100, 1]);
    [f,p] = generate_fft(data_repeat, freq);
    [max_p, idx] = max(p); % max value
    max_f = f(idx); % max freq
    plot(f,p);
    hold on;
    max_p_base_final = 0;
    idx_base_final = 0;
    idx_final = 0;
    for n = 1:6
        pos_2 = round(idx/n);
        [max_p_base, idx_base] = max(p(pos_2-interval_len:pos_2+interval_len));
        if(max_p_base >= 0.2*max_p)
            max_p_base_final = max_p_base;
            idx_base_final = idx_base;
            idx_final = pos_2-interval_len+idx_base;
        end
    end
    base_freq_list = [base_freq_list, f(idx_final)];
    for n = 1:10
        pos_2 = round(idx_final*n);
        [max_p_base, idx_base] = max(p(pos_2-interval_len_2:pos_2+interval_len_2));
        if(max_p_base >= 0.05*max_p)
            idx_final_2 = pos_2-interval_len_2+idx_base;
            harmonic_wave_weight(i,n) = max_p_base/max_p_base_final;
            plot(f(idx_final_2), max_p_base, '*');
            hold on;
        else
            harmonic_wave_weight(i,n) = 0;
        end
    end
    % index_final_list = [index_final_list, index_final]; 
end

csvwrite('harmonic_wave_weight.csv', harmonic_wave_weight);
% base_freq_list = sort(base_freq_list);

standard_freq_list = [];
for base_freq = base_freq_list
    standard_freq_list = [standard_freq_list, search_in_standard_table(base_freq)];
end

disp(standard_freq_list);

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
    disp([str2double(key{1}), averaged_harmonic_wave_data(key{1}) / averaged_harmonic_wave_data_num(key{1})]);
    averaged_harmonic_wave_data_result = [averaged_harmonic_wave_data_result; [str2double(key{1}), averaged_harmonic_wave_data(key{1}) / averaged_harmonic_wave_data_num(key{1})]];
end

csvwrite('averaged_harmonic_wave_data_result.csv', averaged_harmonic_wave_data_result);