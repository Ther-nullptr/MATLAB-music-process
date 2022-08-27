function [f,P1] = generate_fft(signal, freq)

len = length(signal);
fft_result = fft(signal);
P2 = abs(fft_result);
P1 = P2(1:len/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = freq*(0:(len/2))/len;

end

