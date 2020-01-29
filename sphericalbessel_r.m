% *** Syntax
% 
% ,----
% | J_r_OCF = sphericalbessel_r(N_order, x_CF)
% `----
% 
% 
% 
% *** Description
% 
% Similar with function sphericalbesselj, sphericalbessel_r deals with the
% case when Ambisonics coefficients are given as a vector.
% 
% *** Input Arguments
% 
% N_order - Ambisonics order x_CF - matrix to return the result (should
% not have more than 2 dimensions)
% 
% *** Return Values
% 
% J_r_OCF - multi-dimensional matrix with Bessel function calculation
% results
% 
% 
% *** Examples
% 
% *** Tips
% 
% *** Alternatives
% 
% *** See Also
% 
% sphericalbesseljr
% 

% Copyright (c) 2018-2020 Johann-Markus Batke (johann-markus.batke@hs-emden-leer.de)
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
  function J_r_OCF = sphericalbessel_r(N_order, x_CF)

  if length(size(x_CF)) > 2
    error('Input argument must not have more than 2 dimensions.');
  end
  
  % Speicher
  O = (N_order+1)^2;
  C = size(x_CF, 1);
  F = size(x_CF, 2);
  J_r_OCF = zeros(O, C, F);
  
  for n = 0:N_order
    J_r_CF = sphericalbesseljr(n, x_CF);
    for m = -n:n
      J_r_OCF(n^2+n+m+1, :, :) = J_r_CF;
    end
  end

function J_r_CF = sphericalbesseljr(n, x_CF)
% sphericalbesseljr - 1st derivative of the spherical Bessel's function of the first kind
%
% J_r_CF = sphericalbesseljr(n, x_CF)
%
% INPUTS
% n - Ambisonics order
% x_CF - matrix to return the result
%
% OUTPUTS
% J_r_CF - matrix of Bessel function's 1st derivative values
%
% DESCRIPTION
% The output matrix has the same dimensions as x_CF. 
% If the input argument (element of a matrix x_CF) is = 0 for the 1st order Ambisonics, resulting
% output would be = 1/3 (L'Hospital rule is applyed), for all other Ambisonics orders the output is 0
%  
% See also: sphericalbesselj

  S_size  = size(x_CF);
  x_L = reshape(x_CF, 1, prod(S_size));
  
  % Sonderbehandlung x == 0
  idx_zero = (x_L == 0);
  if n == 1
    J_r_L(idx_zero) = 1/3; % Sonderfall, mittels l'Hospital
                           % berechnet, ächz!
  else
    J_r_L(idx_zero) = 0;
  end
  
  % Rest
  idx_nzero = (x_L ~= 0);
  J_r_L(idx_nzero) = sphericalbesselj(n-1, x_L(idx_nzero)) - ...
      (n+1) * x_L(idx_nzero).^(-1) .* sphericalbesselj(n, x_L(idx_nzero));

  % Form wahren
  J_r_CF = reshape(J_r_L, S_size);
