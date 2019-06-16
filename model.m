% Simulation Script for RainAttenuationGenerator Model
clear
close all
clc
addpath(genpath('Channel_Model'),genpath('FSMC_Calculation'),genpath('Rain_Simulation'),genpath('Plots'),genpath('rain_data'),genpath('evaluation'));

%Control Data for simulation
control = control_settings();

%%
%Performing Rain Simulation

c_region = decide_cl_region(control);                       %decide to which climatic region belongs the given location

[ ~,MT, P_0,~] = ITU837( control );                         %%monthly probability of rain
P_0 = P_0/100;                                              %%Normalize probabilities to be [0,1]

R_01_perMonth = rain_values(control,c_region);

R_01_events = rainfall_events(control,R_01_perMonth);        %%split real-world data into rain events
% [R_event_dur,R_event_stats]=event_duration(R_01_events);   %%OPTIONAL: Statistics for rain events

R_minute = rain_simulation(control,R_01_events,P_0);         %%Rainrate Generator for every minute of the year

 rain_att = rain_attenuation(control,R_minute);              %%Attenuation due to rain
%%
%Channel Simulation

SNR = SNR_values(control,rain_att);
SNR_reshaped = custom_reshape(SNR);                         %% Simulated SNR values for a whole year

%%
%FSMC Calculation

FSMC = FSMC_calc(control,SNR_reshaped);

%%
%Channel Reconstruction
SNR_rec=channel_reconstruction(control,FSMC);               %%Artificial Channel using Markov Chains

%%
% visualization(SNR_reshaped,SNR_thresholds,states);
