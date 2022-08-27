function [standard_freq] = search_in_standard_table(raw_freq)
base_ratio = 2^(1/12);
search_table = [];
for i = 0:48
    search_table = [search_table, 110 * base_ratio ^ i];
end
diff_abs = abs(search_table - raw_freq); 
[~, idx] = min(diff_abs);
standard_freq = search_table(idx);
end

