function [ FSMC ] = FSMC_chain( control, SNR,nr_states)
%This function creates an object containing all the information required
%to describe a Markov chain. The Markov chain captures the behaviour of the
%passed in SNR values

% INPUT:  m x 1     SNR: vector containing the SNR values
%         1 x 1     nr_states: number of states of the Markov Chain

% OUTPUT:  m x 1   states: FSMC state of the channel    
%%
FSMC = {};

[SNR_thresholds,SNR_recval]=lloyds(SNR,nr_states);  

states = FSMC_states(control,SNR,SNR_thresholds,nr_states);

P_steadystate = FSMC_steadyStates(control,states,nr_states);

P_transition = FSMC_transition(control,states,nr_states);
for i =1:size(P_transition,2)
    P_transition(i,:)=P_transition(i,:)/P_steadystate(i);
end

FSMC.states=states;
FSMC.SNR_thres=SNR_thresholds;
FSMC.SNR_recval=SNR_recval;
FSMC.minval = min(SNR);
FSMC.maxval = max(SNR);
FSMC.P_steadystate = P_steadystate;
FSMC.P_transition=P_transition;
end

