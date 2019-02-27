function [A,B,C,D] = ABCD(freq,len,refra_ind,pol,angle)
% freq is the operating frequency
% len is the thickness of the layer
% refra_ind is the refractive index
% pol is the polarization

eta = 120*pi/refra_ind; % characteristic impedance
beta = 2*pi*freq/3e8*refra_ind; % propagation constant
if pol == 'te'
    Z = eta/cos(angle);
else
    Z = eta*cos(angle);
end
betaz = beta*cos(angle); % projection of propagation constant along direction of propagation
% compute ABCD parameters
A = cos(betaz*len);
B = 1j*Z*sin(betaz*len);
C = 1j/Z*sin(betaz*len);
D = A;
end