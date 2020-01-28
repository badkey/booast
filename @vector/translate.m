% 1 Syntax
% ========
% 
% 
% 2 Description
% =============
% 
% 
% 3 Input Arguments
% =================
% 
% 
% 4 Return Values
% ===============
% 
% 
% 5 Examples
% ==========
% 
% 
% 6 Tips
% ======
% 
% 
% 7 Alternatives
% ==============
% 
% 
% 8 See Also
% ==========
% 
% Copyright (c) 2018, 2919 Johann-Markus Batke (johann-markus.batke@hs-emden-leer.de)
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
function v_res_NL = translate(v_pos_N, v_trans_L)
  % get positions 
  r_pos_xyz_N = get(v_pos_N, 'cartesian');

  % preserve size
  size_pos = size(r_pos_xyz_N); % preserve size (e.g. 3xMxL)
  N = prod(size_pos(2:end)); % N = M*L
  r_pos_xyz_N = reshape(r_pos_xyz_N, [3, N]);

  % get rotation angles according to mathematically defined spherical coordinates
  r_trans_xyz_L = get(v_trans_L, 'cartesian');
  L = numel(v_trans_L);

  % allocate memory
  r_res_xyz_NL = zeros(3, N, L);
  for l = 1:L
    r_res_xyz_NL(1:3, 1:N, l) = r_pos_xyz_N + r_trans_xyz_L(:,l) * ones(1, N);
  end
  v_res_NL = vector(reshape(r_res_xyz_NL, [size_pos, L]), 'cartesian');
