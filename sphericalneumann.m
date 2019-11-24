% 1 Syntax
% ========
% 
%   ,----
%   | N_sph_OCF = sphericalneumann(N_order, x_CF)
%   `----
% 
% 
% 2 Description
% =============
% 
%   First derivative of the 2nd kind Bessel function is computed for each
%   element of x.If the input argument (element of a matrix x) is = 0, the
%   output has a value NaN.
% 
% 
% 3 Input Arguments
% =================
% 
%   - N_order - Ambisonics order
%   - x_CF - matrix to return the result (should not have more than 2
%     dimensions)
% 
% 
% 4 Return Values
% ===============
% 
%   - N_sph_OCF - multi-dimensional matrix with Neumann function
%     calculation results
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
%   sphericalbessely
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
function N_sph_OCF = sphericalneumann(N_order, x_CF)

  if length(size(x_CF)) > 2
    error('Input argument must not have more than 2 dimensions.');
  end

  % Speicher
  O = (N_order+1)^2;
  C = size(x_CF, 1);
  F = size(x_CF, 2);
  N_sph_OCF = zeros(O, C, F);

  for n = 0:N_order
    N_CF = sphericalbessely(n, x_CF);
    for m = -n:n
      N_sph_OCF(n^2+n+m+1, :, :) = N_CF;
    end
  end
