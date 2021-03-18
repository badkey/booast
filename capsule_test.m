if ~exist('R_disk')
  R_disk = 0.006;
end
if ~exist('N_disk')
  N_disk = 10;
end
vr_mic_L = positions('soundfieldmic');
%% wave numbers 
F = 3; f_F = linspace(80, 8000, F); % Hz 
omega_F = 2*pi*f_F; % Hz 
C_snd = 342; % m/s 
k_F = omega_F/C_snd; % wave number

%% sound field directions, e.g. a 2-sphere
A = 30; theta_A = linspace(0, pi, A);
B = 40; phi_B = linspace(0, 2*pi, B);
vg_AB = vectorgrid(1, theta_A, phi_B, 'spherical');
vk_D = vector(reshape(vg_AB, [A*B, 1]), 'spherical');
D = numel(vk_D);
%% weighting for radial portion of velocity
alpha = 0.6;
s_mic_LFD = capsule(vr_mic_L, k_F, vk_D, alpha, N_disk, R_disk);
whos;
