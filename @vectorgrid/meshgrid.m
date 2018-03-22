function [x_YXZ, y_YXZ, z_YXZ] = meshgrid(st, X_idx, Y_idx, Z_idx, S_type)
  if nargin < 5
    S_type = 'cartesian';
  end
  dim_XYZ = size(st);

  if nargin < 4 Z_idx = 1:dim_XYZ(3); end
  if nargin < 3 Y_idx = 1:dim_XYZ(2); end
  if nargin < 2 X_idx = 1:dim_XYZ(1); end

  % default: wandle vectorgrid in Vektor mit kartesischen Werten
  s_xyz_L = get(vector(st), S_type);

  % sortiere Werte a la Meshgrid aus Matlab
  s_xyz_XYZ = reshape(s_xyz_L, [3, dim_XYZ]);
  s_xyz_YXZ = permute(s_xyz_XYZ, [1, 3, 2, 4]);

  % output variables
  dim_YXZ = dim_XYZ([2, 1, 3]);
  x_YXZ = reshape(s_xyz_YXZ(1,:,:,:), dim_YXZ);
  y_YXZ = reshape(s_xyz_YXZ(2,:,:,:), dim_YXZ);
  z_YXZ = reshape(s_xyz_YXZ(3,:,:,:), dim_YXZ);
end
