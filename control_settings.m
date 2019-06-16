function [ control ] = control_settings(  )
% In this function, the control parameters for the simulation are set.
%The geographical coordinates (latitude,longitude) for some exemplary 
%locations are provided.



% Input:  None
% Output: 1x1 struct
%%
%San Jose
% control.locLat = 9.928069;
% control.locLon = -84.090729;

%Cairo
% control.locLat = 30.044420;
% control.locLon = 31.235712;

%Phoenix
% control.locLat = 33.4484;
% control.locLon = -112.07404;

%Berlin
control.locLat = 52.5200;                                 
control.locLon = 13.4050;
 
% Moscow
% control.locLat = 55.755825;
% control.locLon = 37.617298;

%Greenland
%control.locLat = 71.706940;
%control.locLon = -42.604301;


control.monthdays =[31;28;31;30;31;30;31;31;30;31;30;31]; %%number of days in each month
control.monthhours = control.monthdays*24;                %%number of hours in each month

control.f = 60e09;                                        %%Transmission frequency in Hz
control.dist = 1000;                                      %%Link Length in m

control.SNRval = 30;                                      %%Ideal transmission SNR
control.AWGN_noise=30;                                    %%Strenght of AWGN

control.FSMC_gran = 'monthly';                            %%temporal granularity of Markov chain. Possible values: monthly, annually
control.FSMC_states=7;                                    %%Number of FSMC states

end
