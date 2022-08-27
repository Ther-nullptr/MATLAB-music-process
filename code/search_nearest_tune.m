function harmonic_weight = search_nearest_tune(full_harmonic_data, freq)
    freq_list = full_harmonic_data(:,1);
    [~, idx] = min(abs(freq_list-freq));
    harmonic_weight = full_harmonic_data(idx,2:end);
end

