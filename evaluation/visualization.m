function [  ] = visualization( SNR_reshaped,partition,states )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

figure(1);
plot(SNR_reshaped);
title('SNR Values for a year','FontSize',22);
xlabel('Minutes');
ylabel('SNR [dB]');
grid on;
set(gca,'FontSize',18)

figure(2);
plot(SNR_reshaped(1:1440));
title('SNR Values for a day with light rain','FontSize',22);
xlabel('Minutes');
ylabel('SNR [dB]');
grid on;
set(gca,'FontSize',18)


figure(3);
plot(SNR_reshaped(352000:353440));
title('SNR Values for a day with heavy rain','FontSize',22);
xlabel('Minutes');
ylabel('SNR [dB]');
grid on;
set(gca,'FontSize',18)



figure(4);
histogram(SNR_reshaped,partition);
title('Histogram with optimal SNR Thresholds as boundaries');
xlabel('SNR [dB]');


figure(5);
histogram(SNR_reshaped,partition);
title('Histogram with optimal SNR Thresholds as boundaries(zoomed)');
ylim([0 5000]);
xlabel('SNR [dB]');

figure(6);
histogram(states);
title('Histogram of FSMC states (zoomed)');
xlabel('State');
ylim([0 5000]);

figure(7);
histogram(states);
title('Histogram of FSMC states');
xlabel('State');







end

