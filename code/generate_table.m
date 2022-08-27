function [freq_table] = generate_table(major)
base_ratio = 2^(1/12);
base_freq = [110, 220, 440, 880];
C_tune_base = [3, 5, 7, 8, 10, 12, 14];

% ref: https://zhuanlan.zhihu.com/p/36706001
switch (major)
    case('C')
        tune_base = C_tune_base;
    case('C sharp')
        tune_base = C_tune_base + 1;
    case('D flat')
        tune_base = C_tune_base + 1;
    case('D')
        tune_base = C_tune_base + 2;
    case('D sharp')
        tune_base = C_tune_base + 3;
    case('E flat')
        tune_base = C_tune_base + 3;
    case('E')
        tune_base = C_tune_base + 4;
    case('F')
        tune_base = C_tune_base + 5;
    case('F sharp')
        tune_base = C_tune_base - 6;
    case('G flat')
        tune_base = C_tune_base - 6;
    case('G')
        tune_base = C_tune_base - 5;
    case('G sharp')
        tune_base = C_tune_base - 4;
    case('A flat')
        tune_base = C_tune_base - 4;
    case('A')
        tune_base = C_tune_base - 3;
    case('A sharp')
        tune_base = C_tune_base - 2;
    case('B flat')
        tune_base = C_tune_base - 2;
    case('B')
        tune_base = C_tune_base - 1;
    otherwise
        ME = MException('major not supported. Supported majors: A-G (flat/sharp)');
        throw(ME);
end
freq_list = base_freq'.*(base_ratio.^ tune_base);
freq_table = reshape(freq_list, [4, 7]);
end

