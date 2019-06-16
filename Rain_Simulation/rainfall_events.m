function [ R_01_events ] = rainfall_events( control,R_01_perMonth )
%This function takes the monthly real-world values of rainrate and splits
%them into rain events. As a rain event we define a series of at least 1
%non-zero rain values.
% INPUT: {1 x 12} R_01         : R_01_perMonth cell array with rain 
%                                values per month
% 
% OUTPUT: {1 x 12} R_01_events: cell array containing the rain events per
%                               month 
%%
months = size(R_01_perMonth,2);
R_01_events = {};

for i=1:months
    
    R_01 = R_01_perMonth{i};            %current month values
    events = {};
    e=1;
    h = size(R_01,1);
    data_years = size(R_01,2);
    
    for k=1:data_years
        j = 1;
        while(j<=h)
            if R_01(j,k)~=0
                l = 1;
                if (j+l<h)
                    while(R_01(j+l,k)~=0)
                        l=l+1;
                        if ((j+l)>h)
                            break;
                        end
                    end
                end
                events{e}=R_01(j:(j+l-1),k);
                e=e+1;
            j=j+l;
            else
                j=j+1;
            end
        end 
    end
    R_01_events{i}=events;
end

end

