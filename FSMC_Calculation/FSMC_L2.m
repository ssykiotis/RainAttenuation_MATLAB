function [ FSMC_L2 ] = FSMC_L2( control, SNR )

%This function creates an object containing all the information required
%to describe a Markov chain per month. The Markov chain captures the behaviour of the
%passed in SNR values

% INPUT:  m x 1     SNR: vector containing the SNR values       

% OUTPUT:  1 x 12   FSMC: struct containing all essential FSMC information
%                         for every month
%%

nr_states = control.FSMC_states;
FSMC_L2 = {};

SNR_perMonth = {};
start = 1;
ending =0;
for i=1:12
    ending = ending+control.monthhours(i)*60;
    SNR_perMonth{i}=SNR(start:ending);    
    start=ending+1;
end

for i=1:12
    FSMC_L2{i} = FSMC_chain(control,SNR_perMonth{i},nr_states);
end

end

