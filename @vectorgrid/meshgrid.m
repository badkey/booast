  function [x_YXZ, y_YXZ, z_YXZ] = meshgrid(st, S_type)

  
  % Copyright (c) 2018-2021 Johann-Markus Batke (johann-markus.batke@hs-emden-leer.de)
  % 
  % Permission is hereby granted, free of charge, to any person obtaining a copy
  % of this software and associated documentation files (the "Software"), to deal
  % in the Software without restriction, including without limitation the rights
  % to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  % copies of the Software, and to permit persons to whom the Software is
  % furnished to do so, subject to the following conditions:
  % 
  % The above copyright notice and this permission notice shall be included in all
  % copies or substantial portions of the Software.
  % 
  % THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  % IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  % FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  % AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  % LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  % OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  % SOFTWARE.
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
