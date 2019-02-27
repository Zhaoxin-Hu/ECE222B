clc
clf
close all
clearvars

% input parameters
f = 10e9;
omega = 2*pi*f;
d = 1e-2;
er1 = 1;
er2 = 4;
theta1 = pi/2+1j*[0:0.01:0.5];
c = 3e8;

% computation
theta2 = asin(sqrt(er1/er2)*sin(theta1));
r12 = (cos(theta2)-cos(theta1)/sqrt(er2))./(cos(theta2)+cos(theta1)/sqrt(er2));
k2 = omega/c*sqrt(er2);
ph_shift = exp(-1j*2*k2*d*cos(theta2));
var = r12.^2.*ph_shift;

% plot var
figure
plot(imag(theta1),rad2deg(angle(var)))