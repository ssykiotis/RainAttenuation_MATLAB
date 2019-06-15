cdfplot(R_01(:));
title('Empirical CDF of converted R_{01} values');
xlabel('R_{01} [mm/hr]');
ylabel('F (R_{01})');

figure(2);
cdfplot(nonzeros(R_01(:)));
title('Empirical CDF of nonzero converted R_{01} values');
xlabel('R_{01} [mm/hr]');
ylabel('F (R_{01})');

figure(3)
stem(100*P_0,'LineWidth',1);
set(gca,'xlim',[0 13]);
title('Probability of rain in Berlin per month');
xlabel('Month');
ylabel(' P_{rain} [%]');
grid on;

figure(4);
cdfplot(total_att(:));
title('Empirical CDF of  rain attenuation values');
xlabel('Rain attenuation [dB]');
ylabel('F');

figure(5);
cdfplot(nonzeros(total_att(:)));
title('Empirical CDF of nonzero rain attenuation values');
xlabel('Rain attenuation [dB]');
ylabel('F');

figure(6);
cdfplot(SNR_reshaped);
title('Empirical CDF of simulated SNR values');
xlabel('SNR [dB]');
ylabel('F');
xlim([0 32]);
