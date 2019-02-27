clc
clf
close all
clearvars

% input parameters
f = 10e9; % frequency
pol = 'te'; % polarization
d = 1e-2; % slab thickness
er1 = 1; % dielectric constant of medium 1
er2 = 4; % dielectric constant of medium 2
theta1 = pi/4; % incident angle
c = 3e8; % speed of light

% computation
omega = 2*pi*f;
theta2 = asin(sqrt(er1/er2)*sin(theta1));
if pol == 'te'
    r12 = (cos(theta2)/sqrt(er1)-cos(theta1)/sqrt(er2))./(cos(theta2)/sqrt(er1)+cos(theta1)/sqrt(er2)); 
else
    r12 = (cos(theta1)/sqrt(er1)-cos(theta2)/sqrt(er2))./(cos(theta1)/sqrt(er1)+cos(theta2)/sqrt(er2));
end
r21 = -r12;
t12 = 1+r12;
t21 = 1+r21;

k2 = omega/c*sqrt(er2);
ph_shift = exp(-1j*2*k2*d*cos(theta2));
gamma = r21+t21*t12*r12*1/(1-r12^2*ph_shift)