for i=1:size(rain_att,1)
    for j =1:size(rain_att,2)
        rain_att(i,j) = rainpl(d,f,x(i,j));
    end
end 

rain_att = zeros(8760,60);

for i=1:size(rain_att,1)
    for j =1:size(rain_att,2)
        if x(i,j)==0
            effpl(i,j)=0;
        else
         term1 = 0.477*d^0.633*x(i,j)^(0.073*0.757)*f^0.123;
         term2 = 10.579*(1-exp(-0.024*d));
         effpl(i,j) = 1/(term1-term2);
        end
    end
end 

r_test = linspace(0.001,70,1000);

for i=1:length(r_test)
    term1 = 0.477*d^0.633*r_test(i)^(0.073*0.757)*f^0.123;
    term2 = 10.579*(1-exp(-0.024*d));
    effpl_test(i) = 1/(term1-term2);
end

plot(effpl_test*d)
