% Example script for UQ eccentricity of 9cell TESLA

clear all; close all
addpath(genpath(pwd))

iF = 1; %increasing factor (iF) for the uncertainties to avoid high requirements for the resolution
        %for better visibility of the deformations, set to, e.g., iF = 50

% Load eccentricity data
nKL = 7;         %no. of Karhunen-Loève (K-L) deformation modes
load ('eig_dec.mat');

% Change unit to millimeter and multiply with increasing factor 
mu = iF*1e-3*mu; %displacements of mean geometry
T = iF*1e-3*T;   %displacements of deformation modes

% Load 9cell TESLA
load ('tesla.mat');

% Points along the axis (iris positions)
axis = [0 0.0560 0.1714 0.2868 0.4022 ... 
    0.5175 0.6329 0.7483 0.8637 0.9791 1.0361];

% Compute deformation crv for K-L modes
[crv_mu, crv_t] = basic_deformations (mu, T, tesla(1).knots{3}, axis);

%% Deform TESLA for current parametric point
z = rand(nKL, 1) %p = random variables, e.g. normally distributed
t = 5;           %scaling parameter

crv_def = crv_mu;
for imode = 1:nKL
    crv_def.coefs(1:2,:) = crv_def.coefs(1:2,:) + t * z(imode) * crv_t(imode).coefs(1:2,:);
end

% Create 3D deformation
tesla_def = tesla;
warp = cell (1, numel (tesla));
for iptc = 2:5 % Keep the central patch (iptc = 1) fixed to keep the axis fixed
    dim = size (tesla(iptc).coefs);

    warp{iptc} = zeros ([2 dim(2:end)]);
    for iz = 1:dim(end)
        warp{iptc}(1,:,:,iz) = repmat (crv_def.coefs(1,iz), dim(2:3)) .* squeeze (tesla(iptc).coefs(4,:,:,iz));
        warp{iptc}(2,:,:,iz) = repmat (crv_def.coefs(2,iz), dim(2:3)) .* squeeze (tesla(iptc).coefs(4,:,:,iz));
    end
    tesla_def(iptc).coefs(1:2,2:end,:,:) = tesla_def(iptc).coefs(1:2,2:end,:,:) + warp{iptc}(:,2:end,:,:); % N.B.: the inner interface (side 1) is kept fixed
end

% Plot the deformed cavity
figure()
for j = 1:5
    nrbplot(tesla_def(j), [5, 5, 300])
    hold on
    view(0,0)   % XZ
end
title(['Deformed cavity with t = ', num2str(t), ' increased by factor ', num2str(iF)])