function G_DL = radial_weight(vk_D, vr_dir_L)
% radial_weight - 
%
% G_D = radial_weight(vk_D, vr_dir)
%
% INPUTS
% vk_D - vector object containing direction values
% vr_dir -  vector with spatial direction/orientation of receiver
%
% OUTPUTS
% G_D - matrix
%
% DESCRIPTION
% 
%

  %% unit vector 
  vr_dir_L = normalize(vr_dir_L);
  r_dir_xyz_L = get(vr_dir_L, 'cartesian'); % got cartesian values
  L = size(r_dir_xyz_L, 2);

  %% directions
  k_rtp_D = get(vk_D, 'spherical'); % got spherical values
  D = size(k_rtp_D, 2); % direction

  G_DL = zeros(D, L);
  for l = 1:L
    for d = 1:D
      theta = k_rtp_D(2, d);
      phi   = k_rtp_D(3, d);

      G_DL(d, l) = ...                                  
          (r_dir_xyz_L(1, l) * sin(theta) * cos(phi) + ...   
           r_dir_xyz_L(2, l) * sin(theta) * sin(phi) + ...
           r_dir_xyz_L(3, l) * cos(theta));
    end
  end
