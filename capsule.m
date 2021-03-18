function [p_sam_LFD] = capsule(vr_mic_L, k_F, vk_D, alpha, N_disk, R_disk)
 % capsule - simulates capsules exposed to a plane wave
 %
vr_sam_N = positions('circle', N_disk, R_disk);
%% mic positions
L = numel(vr_mic_L);
r_mic_xyz_L = get(vr_mic_L, 'cartesian');

%% rotate sample points
vr_sam_NL = rotate(vr_sam_N, vr_mic_L);
r_sam_xyz_NL = get(vr_sam_NL, 'cartesian');
size_mic = size(r_sam_xyz_NL); % 3xNxL
N = size_mic(2);

%% translate sample points
for l = 1:L
  r_sam_xyz_NL(1:3, 1:N, l) = r_sam_xyz_NL(1:3, 1:N, l) + r_mic_xyz_L(1:3, l) * ones(1, N);
end
vr_sam_NL = vector(r_sam_xyz_NL, 'cartesian');
p_sam_NLFD = planewave(vr_sam_NL, scale(k_F, vk_D));
%% add pressure and velocity
G_DL = radial_weight(vk_D, vr_mic_L);
for l = 1:L
  for d = 1:size(G_DL, 1)
    s_sam_NLFD(:,l,:,d) = (alpha + (1-alpha) * G_DL(d,l)) .* ...
			  p_sam_NLFD(:, l, :, d);
  end
end

%% summarise sample points, discard leading dimension 1, reshape
p_sam_LFD = permute(sum(s_sam_NLFD, 1), [2, 3, 4, 1]);
