function [ states ] = FSMC_states( control,SNR,SNR_thres,nr_states )
%This function returns a vector that contains the FSMC states that the
%channel is at. In order to do that, the
%function requires the SNR thresholds between the states.

% INPUT:  m x 1     SNR: vector containing the SNR values
%         n x 1     SNR_thres: vector containing the SNR Thresholds between
%                              the states
%         1 x 1     nr_states: number of states of the Markov Chain

% OUTPUT:  m x 1   states: FSMC state of the channel    
%%
x = SNR;
states=zeros(length(x),1);
for i=1:length(x)
    j=nr_states-1;
    while(j>0)
        if x(i)>SNR_thres(j)
           states(i)=j+1;
           break;
        end
        j=j-1;
    end
    if (j==0)
        states(i)=1;
    end  
end  

end

