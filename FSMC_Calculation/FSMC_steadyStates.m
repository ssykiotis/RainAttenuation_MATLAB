function [ P_steadystate ] = FSMC_steadyStates( control,states,nr_states )
%This function returns a vector that contains the FSMC steady-state
%probabilities.

% INPUT:  m x 1     states: vector containing the FSMC states
%         1 x 1     nr_states: number of states of the Markov Chain
%
% OUTPUT:  n x 1    P_steadystate: steady-state FSMC probabilities 
%%

P_steadystate = zeros(nr_states,1);

for i=1:nr_states
    P_steadystate(i) = length(find(states==i))/length(states);
end

