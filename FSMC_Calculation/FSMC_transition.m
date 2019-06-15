function [ P_transition ] =FSMC_transition(control,states,nr_states)
%This function returns a matrix that contains the FSMC conditional transition
%probabilities.

% INPUT:  m x 1     states: vector containing the FSMC states
%         1 x 1     nr_states: number of states of the Markov Chain
%
% OUTPUT:  m x m   P_transition: FSMC transition probability matrix
%%

P_transition = zeros(nr_states);

for i=1:(length(states)-1)
    k = states(i);
    l = states(i+1);
    P_transition(k,l)=P_transition(k,l)+1;
end
P_transition=P_transition/length(states);
end

