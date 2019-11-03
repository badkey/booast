  function [x_YXZ, y_YXZ, z_YXZ] = meshgrid(st, S_type)

  
    if nargin < 2
      %% default: wandle vectorgrid in Vektor mit kartesischen Werten
      S_type = 'cartesian';
    end
    dim_XYZ = size(st);

    s_xyz_L = get(vector(st), S_type);

    % sortiere Werte a la Meshgrid aus Matlab
    s_xyz_XYZ = reshape(s_xyz_L, [st.dims, dim_XYZ]);
    s_xyz_YXZ = permute(s_xyz_XYZ, [1, 3, 2, 4]);

    % output variables
    dim_YXZ = dim_XYZ([2, 1, 3]);
    switch st.dims
      case 2
	x_YXZ = reshape(s_xyz_YXZ(1,:,:,:), dim_YXZ);
	y_YXZ = reshape(s_xyz_YXZ(2,:,:,:), dim_YXZ);
        z_YXZ = []; % ugly, right?
      case 3
	x_YXZ = reshape(s_xyz_YXZ(1,:,:,:), dim_YXZ);
	y_YXZ = reshape(s_xyz_YXZ(2,:,:,:), dim_YXZ);
	z_YXZ = reshape(s_xyz_YXZ(3,:,:,:), dim_YXZ);
      otherwise
	error('corrupt dimensionality of vectorgrid.');
    end
  end
