% gamma_r = csvread('specatts.csv');

rr = linspace(0.001, 70,1000);

%%%%%%%%%%%%%%%%%%%%%%
% Rain dependency plots
f=20;
d = [10,100,500,1000]/1000;
r_rain = zeros(4,length(rr));
gamma_r_rain = zeros(length(rr),1);
for j=1:length(d)
    for i=1:length(rr)
         [gamma,factor] = effplfactor(d(j),rr(i),f);
         if factor>2.5
             factor=2.5;
         end
         r_rain(j,i) = factor;
         gamma_r_rain(i) = gamma;
    end
end

f=60;
r_rain2 = zeros(4,length(rr));
gamma_r_rain2 = zeros(length(rr),1);
for j=1:length(d)
    for i=1:length(rr)
          [gamma,factor] = effplfactor(d(j),rr(i),f);
         if factor>2.5
             factor=2.5;
         end
         r_rain2(j,i) = factor;
         gamma_r_rain2(i) = gamma;
    end
end

for i=1:length(d)
    for j=1:size(r_rain,2);
        effpl_rain(i,j)  = r_rain(i,j)*d(i);
        effpl_rain2(i,j) = r_rain2(i,j)*d(i);
    end
end

for i=1:length(d)
    for j=1:size(r_rain,2);
    total_rain(i,j)  = effpl_rain(i,j)*gamma_r_rain(j);
    total_rain2(i,j) = effpl_rain2(i,j)*gamma_r_rain(j);
    end
end



figure(1)
plot(rr,r_rain,'LineWidth',2);
title('distance factor r over rain intensity, f=20GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('distance factor r');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(2)
plot(rr,r_rain2,'LineWidth',2);
title('distance factor r over rain intensity, f=60GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('distance factor r');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(3)
plot(rr,effpl_rain,'LineWidth',2);
title('effective path length over rain intensity, f=20GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('effective path length [km]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(4)
plot(rr,effpl_rain2,'LineWidth',2);
title('effective path length over rain intensity, f=60GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('effective path length [km]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(5)
plot(rr,total_rain,'LineWidth',2);
title('Total Attenuation over rain intensity, f=20GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(6)
plot(rr,total_rain2,'LineWidth',2);
title('Total Attenuation over rain intensity, f=60GHz');
xlabel('Rain intensity [mm/hr]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQUENCY DEPENDENCY PLOTS
f  = linspace(10,100,1000);
rr=2;
d = [10,100,500,1000]/1000;
r_freq = zeros(4,length(f));
gamma_r_freq = zeros(length(f),1);
for j=1:length(d)
    for i=1:length(f)
         [gamma,factor] = effplfactor(d(j),rr,f(i));
         if factor>2.5
             factor=2.5;
         end
         r_freq(j,i) = factor;
         gamma_r_freq(i) = gamma;
    end
end

rr=50;
r_freq2 = zeros(4,length(f));
gamma_r_freq2 = zeros(length(f),1);
for j=1:length(d)
    for i=1:length(f)
          [gamma,factor] = effplfactor(d(j),rr,f(i));
         if factor>2.5
             factor=2.5;
         end
         r_freq2(j,i) = factor;
         gamma_r_freq2(i) = gamma;
    end
end

for i=1:length(d)
    for j=1:size(r_freq,2);
        effpl_freq(i,j)  = r_freq(i,j)*d(i);
        effpl_freq2(i,j) = r_freq2(i,j)*d(i);
    end
end

for i=1:length(d)
    for j=1:size(r_freq,2);
    total_freq(i,j)  = effpl_freq(i,j)*gamma_r_freq(j);
    total_freq2(i,j) = effpl_freq2(i,j)*gamma_r_freq2(j);
    end
end

for i=1:length(d)
    for j=1:length(gamma_r_dist)
    test(i,j) = gamma_r_freq(j)*d(i);
    test2(i,j) = gamma_r_freq2(j)*d(i);
    end
end


figure(1)
plot(f,r_freq,'LineWidth',2);
title('distance factor r over frequency, R=2 mm/hr');
xlabel('Frequency [GHz]');
ylabel('distance factor r');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(2)
plot(f,r_freq2,'LineWidth',2);
title('distance factor r over frequency, R=50 mm/hr');
xlabel('Frequency [GHz]');
ylabel('distance factor r');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(3)
plot(f,effpl_freq,'LineWidth',2);
title('effective path length over frequency, R=2 mm/hr');
xlabel('Frequency [GHz]');
ylabel('effective path length [km]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(4)
plot(f,effpl_freq2,'LineWidth',2);
title('distance factor r over frequency, R=50 mm/hr');
xlabel('Frequency [GHz]');
ylabel('effective path length [km]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(5)
plot(f,total_freq,'LineWidth',2);
title('Total Attenuation over frequency, R=2 mm/hr');
xlabel('Frequency [GHz]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(6)
plot(f,total_freq2,'LineWidth',2);
title('Total Attenuation over frequency, R=50 mm/hr');
xlabel('Frequency [GHz]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(7)
plot(f,test,'LineWidth',2);
title('gamma_r*distance over frequency,  R=2 mm/hr');
xlabel('Frequency [GHz]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

figure(8)
plot(f,test2,'LineWidth',2);
title('gamma_r*distance over frequency,  R=50 mm/hr');
xlabel('Frequency [GHz]');
ylabel('Total Attenuation [dB]');
legend('d=10m','d=100m','d=500m','d=1km');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DISTANCE DEPENDENCY
d  = linspace(0.001,1,1000);
rr=2;
f = [20,40,60,100];

r_dist = zeros(4,length(d));
gamma_r_dist = zeros(length(d),1);
for j=1:length(f)
    for i=1:length(d)
         [gamma,factor] = effplfactor(d(i),rr,f(j));
         if factor>2.5
             factor=2.5;
         end
         r_dist(j,i) = factor;
         gamma_r_dist(i) = gamma;
    end
end

rr=50;
r_dist2 = zeros(4,length(d));
gamma_r_dist2 = zeros(length(d),1);
for j=1:length(f)
    for i=1:length(d)
          [gamma,factor] = effplfactor(d(i),rr,f(j));
         if factor>2.5
             factor=2.5;
         end
         r_dist2(j,i) = factor;
         gamma_r_dist2(i) = gamma;
    end
end

for i=1:length(f)
    for j=1:size(r_dist,2);
        effpl_dist(i,j)  = r_dist(i,j)*d(j);
        effpl_dist2(i,j) = r_dist2(i,j)*d(j);
    end
end

for i=1:length(f)
    for j=1:size(r_dist,2);
    total_dist(i,j)  = effpl_dist(i,j)*gamma_r_dist(j);
    total_dist2(i,j) = effpl_dist2(i,j)*gamma_r_dist2(j);
    end
end

figure(1)
plot(d,r_dist,'LineWidth',2);
title('distance factor r over distance, R=2 mm/hr');
xlabel('Distance [km]');
ylabel('distance factor r');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;

figure(2)
plot(d,r_dist2,'LineWidth',2);
title('distance factor r over distnce, R=50 mm/hr');
xlabel('Distance [km]');
ylabel('distance factor r');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;

figure(3)
plot(d,effpl_dist,'LineWidth',2);
title('effective path length over frequency, R=2 mm/hr');
xlabel('Distance [km]');
ylabel('effective path length [m]');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;

figure(4)
plot(d,effpl_dist2,'LineWidth',2);
title('distance factor r over frequency, R=50 mm/hr');
xlabel('Distance [km]');
ylabel('effective path length [m]');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;

figure(5)
plot(d,total_dist,'LineWidth',2);
title('Total Attenuation over frequency, R=2 mm/hr');
xlabel('Distance [km]');
ylabel('Total Attenuation [dB]');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;

figure(6)
plot(d,total_dist2,'LineWidth',2);
title('Total Attenuation over frequency, R=50 mm/hr');
xlabel('Distance [km]');
ylabel('Total Attenuation [dB]');
legend('f=20Ghz','f=40GHz','f=60GHz','f=100GHz');
grid on;




