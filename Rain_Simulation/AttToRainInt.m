function [ R_res ] = AttToRainInt( P_ideal,P_rainy,f,d,el,tau )
%This function calculates the Rain intensity value that corresponds to a
%certain rain attenuation value.

% INPUT:  1x1    P_ideal: Path attenuation under ideal weather conditions.
%         1x1    P_rainy: Path attenuation during a rain event. 
%         1x1    f:       Frequency [GHz]
%         1x1    d:       link distance [km]
%         1x1    el:      elevation path angle (default 0)
%         1x1    tau:     polarization tilt angle (default 0)
% 
%
% OUTPUT:  1x1 R_res: Rain intensity value [mm/hr]
%%
if (nargin==4)
    el=0;
    tau=0;
end

AttDiff = P_rainy-P_ideal;
[kH,kV,alphaH,alphaV] = rainattcoeff(f);
k = (kH+kV+(kH-kV)*(cos(el)^2)*cos(2*tau))/2;
alpha = (kH*alphaH+kV*alphaV+(kH*alphaH-kV*alphaV)*(cos(el)^2)*cos(2*tau))/(2*k);

t2 = 10.579*(1-exp(-0.024*d));
t1 = 0.477*d^0.633*f^0.123;

t1_new = t1*AttDiff/(k*d);
t2_new = t2*AttDiff/(k*d);


syms R;
assume(R,'real');
eqn = t1_new*R^(alpha*0.073)-R^alpha-t2_new ==0;

R_res = vpasolve(eqn,R);
R_res = double(R_res);

end



function [kH,kV,alphaH,alphaV] = rainattcoeff(f)

kHtab = [-5.33980 -0.10008 1.13098; ...
         -0.35351 1.26970 0.45400; ...
         -0.23789 0.86036 0.15354; ...
         -0.94158 0.64552 0.16817];
kHm = -0.18961;
kHc = 0.71147;

kVtab = [-3.80595 0.56934 0.81061; ...
         -3.44965 -0.22911 0.51059; ...
         -0.39902 0.73042 0.11899; ...
         0.50167 1.07319 0.27195];
kVm = -0.16398;
kVc = 0.63297;

alphaHtab = [-0.14318 1.82442 -0.55187; ...
             0.29591 0.77564 0.19822; ...
             0.32177 0.63773 0.13164; ...
             -5.37610 -0.96230 1.47828; ...
             16.1721 -3.29980 3.43990];
alphaHm = 0.67849;
alphaHc = -1.95537;

alphaVtab = [-0.07771 2.33840 -0.76284; ...
             0.56727 0.95545 0.54039; ...
             -0.20238 1.14520 0.26809; ...
             -48.2991 0.791669 0.116226; ...
             48.5833 0.791459 0.116479];
alphaVm = -0.053739;
alphaVc = 0.83433;

tempkH = bsxfun(@rdivide,bsxfun(@minus,log10(f),kHtab(:,2)),kHtab(:,3));
log10kH = sum(bsxfun(@times,kHtab(:,1),exp(-tempkH.^2)))+...
    kHm.*log10(f)+kHc;
kH = 10.^log10kH;

tempkV = bsxfun(@rdivide,bsxfun(@minus,log10(f),kVtab(:,2)),kVtab(:,3));
log10kV = sum(bsxfun(@times,kVtab(:,1),exp(-tempkV.^2)))+...
    kVm.*log10(f)+kVc;
kV = 10.^log10kV;

tempalphaH = bsxfun(@rdivide,bsxfun(@minus,log10(f),alphaHtab(:,2)),alphaHtab(:,3));
alphaH = sum(bsxfun(@times,alphaHtab(:,1),exp(-tempalphaH.^2)))+...
    alphaHm.*log10(f)+alphaHc;

tempalphaV = bsxfun(@rdivide,bsxfun(@minus,log10(f),alphaVtab(:,2)),alphaVtab(:,3));
alphaV = sum(bsxfun(@times,alphaVtab(:,1),exp(-tempalphaV.^2)))+...
    alphaVm.*log10(f)+alphaVc;

end