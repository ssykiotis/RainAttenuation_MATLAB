function  [FSMC] = FSMC_calc(control,SNR_reshaped)
% This function calculates the parameters of the Finite State Markov Chain(s) 
% depending on the users input. 
% INPUT: 525600x1 SNR_reshaped: Simulated SNR values for every minute of
%                               the year
% 
% OUTPUT:  1x1 or 1x12 struct FSMC: struct with parameters of FSMC. If the
%                                   user chose monthly granularity, 
%                                   FSMC is a cell array 
%                                   of structs containing the FSMC parameters.
%%
if strcmp(control.FSMC_gran,'annually')
    FSMC = FSMC_L1(control, SNR_reshaped);
elseif strcmp(control.FSMC_gran,'monthly')
    FSMC = FSMC_L2(control,SNR_reshaped);
end

end