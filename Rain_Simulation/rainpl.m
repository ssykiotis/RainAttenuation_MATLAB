function L = rainpl(R,f,rr,el_in,tau_in)
%rainpl    Path loss due to rain
%   L = rainpl(R,F,RR) returns the path loss, L (in dB), due to rain with a
%   given rain rate. R is an length-M vector whose entries represent the
%   propagation distances (in meters). F is an length-N vector whose
%   entries represent the signal carrier frequency (in Hz). RR is a scalar
%   indicating the rain rate (in mm/h).
%
%   L is an MxN matrix whose elements represents the path loss of each
%   propagation path under corresponding frequency.
%
%   L = rainpl(R,F,RR,EL) specifies the elevation angle (in degrees) of the
%   propagation path in EL. EL can be either a scalar or a vector. If EL is
%   a scalar, all propagation paths have the same elevation angle. If EL is
%   a vector, its length must be M so each element in EL is the elevation
%   angle of the corresponding propagation path in R. The default value of
%   EL is 0.
%
%   L = rainpl(R,F,RR,EL,TAU) specifies the polarization tilt angle (in
%   degrees) of the signal in TAU. TAU can be either a scalar or a vector.
%   If TAU is a scalar, all propagation paths have the same tilt angle. If
%   TAU is a vector, its length must be M so each element in TAU is the
%   tilt angle of the signal of the corresponding propagation path. The
%   default value of TAU is 0, representing horizontal polarization.
%
%   The ITU rain model is valid between 1 to 1000 GHz.
%
%   % Examples:
%
%   % Example 1:
%   %   Compute the path loss of a 3 km link at 1 GHz due to a rain rate of
%   %   95 mm/h. 
%   
%   L = rainpl(3000,1e9,95)
%
%   % Example 2:
%   %   Plot the attenuation model for a rain rate of 95 mm/h from 1 GHz to
%   %   1000 GHz.
%
%   freq = (1:1000)*1e9;
%   L = rainpl(1e3,freq,95);
%   loglog(freq/1e9,L); grid on;
%   xlabel('Frequency (GHz)'); ylabel('Rain attenuation (dB/km)')
%
%   See also fogpl, fspl, gaspl.

%   Copyright 2015-2016 The MathWorks, Inc.

% References
% [1] Recommendation ITU-R P.838-3, 2005
% [2] John Seybold, Introduction to RF Propagation, Wiley, 2005

%#codegen

narginchk(3,5);

validateattributes(R, {'double'}, {'nonnan','nonempty','real', ...
    'nonnegative','vector','finite'}, 'rainpl', 'R');
validateattributes(f, {'double'}, {'finite','nonempty','real', ...
    'vector','positive','>=',1e9,'<=',1000e9}, 'rainpl', 'F');
validateattributes(rr, {'double'}, {'finite','nonnan','nonempty'...
    'nonnegative','scalar'}, 'rainpl', 'RR');

M = numel(R);

if nargin >= 4 
    if isscalar(el_in)
        el = repmat(el_in,1,M);
    else
        el = el_in;
    end
    validateattributes(el, {'double'}, {'finite','nonnan','nonempty', ...
        'real','vector','numel',M}, 'rainpl', 'EL');
else
    el = zeros(1, M);
end

if nargin == 5
    if isscalar(tau_in)
        tau = repmat(tau_in,1,M);
    else
        tau = tau_in;
    end    
    validateattributes(tau, {'double'}, {'finite','nonnan','nonempty', ...
        'real','vector','numel',M}, 'rainpl', 'TAU');
else
    tau = zeros(1, M);
end

gamma = rainatt(f(:).',rr,el(:),tau(:));
d0 = 35*exp(-0.015*rr);
Rkm = R(:)/1e3;
Rkm = Rkm./(1+Rkm./d0);
L = bsxfun(@times,Rkm,gamma);

end

function gamma = rainatt(f,rr,el,tau)

[kH,kV,alphaH,alphaV] = rainattcoeff(f);

k = bsxfun(@plus,kH+kV,bsxfun(@times,(kH-kV),cosd(el).^2.*cosd(2*tau)))/2;
alpha = bsxfun(@plus,kH.*alphaH+kV.*alphaV,...
    bsxfun(@times,(kH.*alphaH-kV.*alphaV),cosd(el).^2.*cosd(2*tau)))./(2*k);

gamma = k.*rr.^alpha;

end

function [kH,kV,alphaH,alphaV] = rainattcoeff(f)

fGHz = f/1e9;  % convert to GHz

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

tempkH = bsxfun(@rdivide,bsxfun(@minus,log10(fGHz),kHtab(:,2)),kHtab(:,3));
log10kH = sum(bsxfun(@times,kHtab(:,1),exp(-tempkH.^2)))+...
    kHm.*log10(fGHz)+kHc;
kH = 10.^log10kH;

tempkV = bsxfun(@rdivide,bsxfun(@minus,log10(fGHz),kVtab(:,2)),kVtab(:,3));
log10kV = sum(bsxfun(@times,kVtab(:,1),exp(-tempkV.^2)))+...
    kVm.*log10(fGHz)+kVc;
kV = 10.^log10kV;

tempalphaH = bsxfun(@rdivide,bsxfun(@minus,log10(fGHz),alphaHtab(:,2)),alphaHtab(:,3));
alphaH = sum(bsxfun(@times,alphaHtab(:,1),exp(-tempalphaH.^2)))+...
    alphaHm.*log10(fGHz)+alphaHc;

tempalphaV = bsxfun(@rdivide,bsxfun(@minus,log10(fGHz),alphaVtab(:,2)),alphaVtab(:,3));
alphaV = sum(bsxfun(@times,alphaVtab(:,1),exp(-tempalphaV.^2)))+...
    alphaVm.*log10(fGHz)+alphaVc;

end

% [EOF]