%probability of rain
figure(1)
bar(100*P_0,0.4);
ylim([0 100]);
xlim([0.5 12.5]);
set(gca,'XTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
set(gca,'FontSize',14);
% title('Monthly probability of rain, equatorial climate ');
title('Monthly probability of rain, arid climate ');
% title('Monthly probability of rain, warm temperate climate ');
% title('Monthly probability of rain, snow climate ');
grid on;

% cdf of nonzero hourly rain values
figure(2)
cdfplot(nonzeros(R_60(:)));
xlabel('Rain Intensity [mm/hr]');
title('Empirical CDF of non-zero R_{60} values');
set(gca,'FontSize',12);

%cdf of nonzero minutewise rain values
figure(3)
cdfplot(nonzeros(R_01(:)));
xlabel('Rain Intensity [mm/hr]');
title('Empirical CDF of non-zero R_{01} values');
set(gca,'FontSize',12);

%%%%%%%% RAINVALUES STATS%%%%%%%%%
for i=1:12
    x = R_01_perMonth{i};
    x_n = nonzeros(x);
%     stats(i,1) = length(x_n)/(size(x,1)*size(x,2))*100; 
    stats(i,1) = prctile(x_n,25);
    stats(i,2) = prctile(x_n,50);
    stats(i,3) = prctile(x_n,75);
    stats(i,4) = prctile(x_n,100);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%simulated rain values-1year
figure(4)
x = custom_reshape(R_minute);
plot(x);
ylabel('Rain Intensity [mm/hr]');
xlabel('Month');
title('Generated rain intensity values for 1 year');
set(gca,'Xtick',[44640 84960 129600 172800 217440 260640 305280 349920 393120 437760 480960 525600]);
set(gca,'XtickLabels',{'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sept' 'Oct' 'Nov' 'Dec'})
grid on;
xlim([1 525601]);

% SNR diagram-Year
figure(5)
x = SNR_reshaped;
plot(x);
ylabel('Simulated channel SNR [dB]');
xlabel('Month');
title('Simulated SNR values for 1 year');
set(gca,'Xtick',[44640 84960 129600 172800 217440 260640 305280 349920 393120 437760 480960 525600]);
set(gca,'XtickLabels',{'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sept' 'Oct' 'Nov' 'Dec'})
grid on;
set(gca,'FontSize',12);
xlim([1 525601]);
ylim([27 30.5]);


%SNR  diagram-Jan
figure(6)
x = SNR_reshaped(1:44640);
plot(x);
ylabel('Channel SNR [dB]');
xlabel('Time');
title('Simulated SNR values, January');
set(gca,'Xtick',[10080 20160 30240 40320]);
set(gca,'XTickLabels',{'Week 1' 'Week 2' 'Week  3' 'Week 4'});
grid on;
set(gca,'FontSize',12);
xlim([1 44641]);
ylim([29.6 30.2]);

%SNR  diagram-June
figure(7)
x = SNR_reshaped(217440:260640); %June
% x = SNR_reshaped(260640:305280); %july
plot(x);
ylabel('Channel SNR [dB]');
xlabel('Time');
title('Simulated SNR values, June');
% title('Simulated SNR values for July');
set(gca,'Xtick',[10080 20160 30240 40320]);
set(gca,'XTickLabels',{'Week 1' 'Week 2' 'Week  3' 'Week 4'});
grid on;
set(gca,'FontSize',12);
xlim([1 43201]);
ylim([27 30.5]);

%%%%%%%%%%%%%%%Reconstructed diagrams %%%%%%%%%%%%%%%

%reconstructed SNR diagram-year
figure(8)
x = SNR_rec;
plot(x);
ylabel('Channel SNR [dB]');
xlabel('Month');
title('Reconstructed SNR values for 1 year');
set(gca,'Xtick',[44640 84960 129600 172800 217440 260640 305280 349920 393120 437760 480960 525600]);
set(gca,'XtickLabels',{'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sept' 'Oct' 'Nov' 'Dec'})
grid on;
set(gca,'FontSize',12);
xlim([1 525601]);
ylim([27 30.5]);

%reconstructed SNR  diagram-Jan
figure(9)
x = SNR_rec(1:44640);
plot(x);
ylabel('Channel SNR [dB]');
xlabel('Time');
title('Reconstructed SNR values,January');
set(gca,'Xtick',[10080 20160 30240 40320]);
set(gca,'XTickLabels',{'Week 1' 'Week 2' 'Week  3' 'Week 4'});
grid on;
set(gca,'FontSize',12);
xlim([1 44641]);
ylim([29.6 30.2]);


%reconstructed SNR  diagram-Jun
figure(10)
x = SNR_rec(217440:260640); %June
% x = SNR_rec(260640:305280); %july
plot(x);
ylabel('Channel SNR [dB]');
xlabel('Time');
title('Reconstructed SNR values,June');
% title('Reconstructed SNR values,July');
grid on;
set(gca,'FontSize',12);set(gca,'Xtick',[10080 20160 30240 40320]);
set(gca,'XTickLabels',{'Week 1' 'Week 2' 'Week  3' 'Week 4'});
xlim([1 43201]);
ylim([27 30.5]);

monthmin = [1 44640 84960 129600 172800 217440 260640 305280 349920 393120 437760 480960 525600];
%comparison
comp =zeros(13,4);
for i =1:12
    month_sim = SNR_reshaped(monthmin(i):monthmin(i+1));
    month_rec = SNR_rec(monthmin(i):monthmin(i+1));
   comp(i,1) = mean(month_sim);
   comp(i,2) = mean(month_rec);
   comp(i,3) = var(month_sim);
   comp(i,4) = var(month_rec);
end
comp(13,1) =   mean(SNR_reshaped);
comp(13,2) =   mean(SNR_rec);
comp(13,3) =   var (SNR_reshaped);
comp(13,4) =   var (SNR_rec);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(11);
x = csvread('ns3data.csv');
d = x(:,1);
att = x(:,2);
plot(d,att,'LineWidth',1.5);
grid on;
ylabel('Rain Attenuation [dB]');
xlabel('Distance [m]');
title('Rain Attenuation over distance, Ns-3 simulation');
% title('Reconstructed SNR values,July');
grid on;
set(gca,'FontSize',12);
xlim([1 1000]);