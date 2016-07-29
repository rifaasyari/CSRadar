function blur = B(rt,rr,r,r0,f0,f)
% sigma_hat returns the estimated RCS of the point at location r, where 
% the transmitter and receiver at time n are located at rt(n,:) and rr(n,:)
% respectively.
% 
% Let N be the number of timesteps and K the number of frequency steps
%
% rt: a matrix of size N x 3 that contains the position of the transmitter at each
% timestep
%
% rr: a matrix of size N x 3 that contains the position of the receivers at each
% timestep. (assuming only 1 receive)
% 
% r: a vector of size 3 representing a point of interest to determine the blur
%
% r0: a vector of size 3 representing a point of interest to determine the blur
%
% f0: the carrier frequency
%
% f: a K dimensional vector containing the stepped frequencies

c = 3E8;
K = length(f);
N = size(rt,1);

uf = u(rt,rr,r) * ones(1,K); % Nx1 * 1xK = NxK

% calculate distances  with or without approximations
distance = D(rt,rr,r); % Nx1 * 1xK = NxK
distance0 = D(rt,rr,r0); % Nx1 * 1xK = NxK
% distance = D2(rt,rr,r); % Nx1 * 1xK = NxK ## 2nd order approximation
% distance = D1(rt,rr,r); % Nx1 * 1xK = NxK ## 1st order approximation

[fn,tn] = meshgrid(f, distance/c);
[fn0,tn0] = meshgrid(f, distance0/c);

N_r = sum(uf(:));

blur = 1/N_r*sum(sum(uf.*exp(2j*pi*(f0+fn).*(tn-tn0))));