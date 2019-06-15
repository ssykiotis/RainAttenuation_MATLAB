function R_minute = rain_simulation(control,R_01_events,P_0)
%% 
%This function simulates rainfall values for a whole year. It looks at each
%month separately and, according to the monthly probabiliy of rain, decides
%whether it will be raining or not for that hour of the month. If yes, it
%randomly picks a rain event of the real world data for the next hours.
%Every minute of the hour is assigned a rainvalue drawn from a gaussian
%distribution with the real-world value as mean and mean/3 as variance.

%INPUT: {1x12} R_01_events: cell array containing the real-world rain
%                           events per month
%       1x12   P_0:         monthly probability of rain

%OUTPUT: 8760x60 R_minute: matrix containing se simulated rainvalues for
%                          every minute of the year.

%%
hours_tot= cumsum(control.monthhours);
R_minute = zeros(hours_tot(12),60);


for month=1:12
    if month==1
    j=1;
    else
        j=hours_tot(month-1)+1;
    end
    hours=hours_tot(month);
    rain_events = R_01_events{month};
    while(j<=hours)
        p_rain = randsrc(1,1,[1,0;P_0(month),1-P_0(month)]);
        if (p_rain~=0)
            ev = datasample(rain_events,1);
            ev = ev{1};
            l = length(ev);
            if (j+l)>hours
                l=j-hours;
                ev=ev(1:l);
            end
            R_minute(j:(j+l-1),1)=ev;
            j=j+l;
        else
            j=j+1;
        end
    end
end


for i=1:size(R_minute,1)
    if R_minute(i,1)~=0
        mu = R_minute(i,1);
        sigma=R_minute(i,1)/3;
        for j=1:size(R_minute,2)
            val=normrnd(mu,sigma);
            while (val<0)
                val=normrnd(mu,sigma);
            end
            R_minute(i,j)=val;
        end
    end
end
end

% i =0;
% i=i+control.monthhours(j);
% p_raining_m = zeros(i,1);
% for k =1:i
%     p_raining_m(k) =randsrc(1,1,[1,0;P_0(j),1-P_0(j)]);
% end
% raining_hourly = cat(1,raining_hourly,p_raining_m);