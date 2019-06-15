function [R_event_dur,stats]=event_duration(R_01_events)
%This function calculates some statistics for the duration of the rain
%events of each month. 
%INPUT: {1x12} R_01_events: cell array containing the rain events per month
%
%OUTPUT: {1x12} R_event_dur:   cell array containing the rain event lengths
%                              per month
%        12x2   R_event_stats: table with mean and variance of rain event
%                              lengths per month. Frist entry of every row
%                              is the mean and the second one the variance.
%%
R_event_dur={};
for i=1:12
    lengths=zeros(length(R_01_events{i}),1);
    for j=1:length(R_01_events{i})
        lengths(j)=length(R_01_events{i}{j});
    end
    R_event_dur{i}=lengths;
end

for i=1:12  
    stats(i,1)=mean(R_event_dur{i});
    stats(i,2)=var(R_event_dur{i});
end

end

