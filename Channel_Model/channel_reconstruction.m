function SNR_rec=channel_reconstruction(control,FSMC)

%This function takes as input one (or more) FSMC) and creates an artificial 
%channel according to the probabilities of the Markov chain. 

% INPUT: {1x1} or 1{x12} FSMC: struct with Finite State Markov Chain info.
%                               
% 
% OUTPUT:  525600x1 SNR_rec: aritficial channel with SNR values for every
%                            minute of a year.
%%

if strcmp(control.FSMC_gran,'annually')
    SNR_rec = rec_annual(control,FSMC);
elseif strcmp(control.FSMC_gran,'monthly')
    SNR_rec = rec_monthly(control,FSMC);
end


end

function [SNR_rec] = rec_annual(control,FSMC)

chain_length = cumsum(control.monthhours);
chain_length = chain_length(length(chain_length))*60;
SNR_rec = zeros(chain_length,1);
p_steadystate = FSMC.P_steadystate';
P_t = FSMC.P_transition;
P_t_cum = cumsum(P_t,2);
states = 1:length(p_steadystate);

SNR_rec(1)= randsrc(1,1,[states;p_steadystate]);

for i=2:chain_length
    val = rand;
    prev_state = SNR_rec(i-1);
    k=1;
    while(val>P_t_cum(prev_state,k))
        k=k+1;
        if k==8
            k=7;
            break;
        end
    end
    SNR_rec(i)=k;
end

SNR_thres = FSMC.SNR_thres;
SNR_recval = FSMC.SNR_recval;
SNR_stateRange = diff([FSMC.minval SNR_thres FSMC.maxval]);

for i=1:chain_length
    mu = SNR_recval(SNR_rec(i));
    sigma = SNR_stateRange(SNR_rec(i))/4;
    SNR_rec(i)= normrnd(mu,sigma);
end

end


function [SNR_rec] = rec_monthly(control,FSMC)

 total_chain_length = cumsum(control.monthhours)*60;
 total_chain_length = total_chain_length(length(control.monthhours));
 counter =1;
 SNR_rec=zeros(total_chain_length,1);
 for month=1:12
    chain_length = control.monthhours(month)*60;
    SNR_rec_month = zeros(chain_length,1);
    FSMC_m = FSMC{month};
    p_steadystate = FSMC_m.P_steadystate';
    P_t = FSMC_m.P_transition;
    P_t_cum = cumsum(P_t,2);
    states = 1:length(p_steadystate);

    SNR_rec_month(1)= randsrc(1,1,[states;p_steadystate]);

    for i=2:chain_length
        val = rand;
        prev_state = SNR_rec_month(i-1);
        k=1;
        while(val>P_t_cum(prev_state,k))
            k=k+1;
            if k==8
                k=7;
                break;
            end
        end
        SNR_rec_month(i)=k;
    end

    SNR_thres = FSMC_m.SNR_thres;
    SNR_recval = FSMC_m.SNR_recval;
    SNR_stateRange = diff([FSMC_m.minval SNR_thres FSMC_m.maxval]);

    for i=1:chain_length
        mu = SNR_recval(SNR_rec_month(i));
        sigma = SNR_stateRange(SNR_rec_month(i))/4;
        SNR_rec_month(i)= normrnd(mu,sigma);
    end
    new_counter = counter + control.monthhours(month)*60;
    SNR_rec(counter:(new_counter-1))=SNR_rec_month;
    counter = new_counter;
end

end
