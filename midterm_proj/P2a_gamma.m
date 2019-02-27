clc
clf
close all
clearvars

nlayer = 3; % number of layers
er = [1;4;1]; % relative permittivity
refra_ind = sqrt(er); % refractive index
d = [0;1e-2;0]; % dielectric thickness (single)
nfreq = 40; % number of frequency points
freq = linspace(1,40,nfreq)*1e9; % frequency
omega = 2*pi*freq; % angular frequency (single)
beta = refra_ind*omega/3e8; % propagation constant in each medium
theta = zeros(nlayer,1); % incident angle in each medium
theta(1) = pi/4;

% pol = 'te'
% compute theta
% Snell's law
% ni*sin(thetai) is const
for i = 2:nlayer
    theta(i) = asin(refra_ind(1)*sin(theta(1))/refra_ind(i));
end

% compute reflection coefficient
eta = 120*pi./refra_ind;
Z0 = eta./cos(theta);
elen = d.*beta;
gammain = zeros(nlayer,nfreq);
gammaL = zeros(nlayer,nfreq);
Zin = zeros(nlayer,nfreq);
ZL = zeros(nlayer,nfreq);

Zin(end,:) = Z0(end,:);
for i = nlayer-1:2
    ZL(i,:) = Zin(i+1,:);
    gammaL(i,:) = z2s(ZL(i,:),Z0(i));
    gammain(i,:) = gammaL(i,:).*exp(-1j*2*elen(i,:));
    Zin(i,:) = s2z(gammain(i,:),Z0(i));
end
ZL(1,:) = Zin(2,:);
gammaL(1,:) = z2s(ZL(1,:),Z0(1));

% plot gamma on a Smith chart
figure
smithplot(gammaL(1,:))