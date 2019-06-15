function [ FSMC ] = FSMC_L1( control, SNR )

%This function creates an object containing all the information required
%to describe a Markov chain. The Markov chain captures the behaviour of the
%passed in SNR values

% INPUT:  m x 1     SNR: vector containing the SNR values       

% OUTPUT:  1 x 1   FSMC: struct containing all essential FSMC information
%%
nr_states = control.FSMC_states;

FSMC  = FSMC_chain( control, SNR,nr_states);

end

