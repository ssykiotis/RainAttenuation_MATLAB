function [ SNR_final ] = SNR_values( control,total_att )
%This function returns a matrix with the simulated SNR per minute for a
%whole year. It takes a nominal ideal SNR value, adds white noise onto it
%and subtracts the total attenuation of the channel.

% INPUT:  1x1        control.AWGN_noise: value of intensity of AWGN
%         8760x60    total_att: total attenuation of the channel per
%                               minute
%
% OUTPUT:  8760x60 SNR_final: Simulated SNR values for a whole year    
%%
m=size(total_att,1);
n=size(total_att,2);

SNR=control.SNRval*ones(m,n);

SNR_noisy = awgn(SNR,control.AWGN_noise); %Add AWGN
SNR_final=SNR_noisy-total_att;

end

