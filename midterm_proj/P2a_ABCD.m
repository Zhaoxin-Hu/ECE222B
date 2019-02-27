% Zhaoxin Hu, z1hu, A53273948
% P2a reflection coefficient
clc
clf
close all
clearvars

% input parameters
theta1 = pi/4; % incident angle
nlayer = 3; % number of layers
er = [1;4;1]; % relative permittivity
d = [0;1e-2;0]; % dielectric thickness (unit:m)
freq_start = 10; % start freq (unit:GHz)
freq_stop = 10; % stop freq (unit:GHz)
nfreq = 1; % number of frequency points
pol = 'te'; % polarization

% computation
refra_ind = sqrt(er); % index of refraction
freq = linspace(freq_start,freq_stop,nfreq)*1e9; % frequency range (unit:Hz)
thetaN = asin(refra_ind(1)/refra_ind(end)*sin(theta1));
if pol == 'te'
    ZL = 120*pi/refra_ind(end)/cos(thetaN); % char impedance of the load
    Z1 = 120*pi/refra_ind(1)/cos(theta1); % char impedance of the first medium
else
    ZL = 120*pi/refra_ind(end)*cos(thetaN); % char impedance of the load
    Z1 = 120*pi/refra_ind(1)*cos(theta1); % char impedance of the first medium
end
theta = zeros(nlayer,1);
gamma = zeros(nfreq,1);
for f = 1:nfreq
    ABCDmat = eye(2);
    for i = 2:nlayer-1
        theta(i) = asin(refra_ind(1)/refra_ind(i)*sin(theta1));
        [Atemp,Btemp,Ctemp,Dtemp] = ABCD(freq(f),d(i),refra_ind(i),pol,theta(i));
        ABCDmat = ABCDmat*[Atemp,Btemp;Ctemp,Dtemp];
    end
    Zin = (ABCDmat(1,1)*ZL+ABCDmat(1,2))/(ABCDmat(2,1)*ZL+ABCDmat(2,2));
    gamma(f) = z2s(Zin,Z1);
end

% plot gamma on a Smith chart
% figure
% smithplot(gamma)