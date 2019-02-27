% Zhaoxin Hu, z1hu, A53273948
% P2a dispersion relation
clc
clf
close all
clearvars

% input parameters
inc_angle = pi/4; % incident angle
nlayer = 3; % number of layers
er = [1;4;1]; % relative permittivity
d = [0;1e-2;0]; % dielectric thickness (unit:m)
freq_start = 1; % start freq (unit:GHz)
freq_stop = 40; % stop freq (unit:GHz)
nfreq = 40; % number of frequency points


refra_ind = sqrt(er); % refractive index
freq = linspace(freq_start,freq_stop,nfreq)*1e9; % frequency range (unit:Hz)

kz = zeros(nfreq,nlayer); % projection of prop const on the axis of prop, a column corresponds to a layer
% compute and plot dispersion relation
for i = 1:nlayer
    % check whether we have propagation in the i-th layer
    % isprop = (sin(inc_angle)<sqrt(refra_ind(i)/refra_ind(1)));
    kz(:,i) = 2*pi*freq/3e8*sqrt2(er(i)-er(1)*(sin(inc_angle)^2));
    figure
    plot(freq/1e9,kz(:,i))
    xlabel('freq (GHz)')
    ylabel('kz (rad/m)')
    title(['Dispersion relation in medium ',num2str(i)])
    legend(['medium ', num2str(i)])
end
