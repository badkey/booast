% 1 Syntax
% ========
% 
%   ,----
%   | J_sph_OCF = sphericalbessel(N_order, x_CF)
%   `----
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
function J_sph_OCF = sphericalbessel(N_order, x_CF)

  if length(size(x_CF)) > 2
    error('Input argument must not have more than 2 dimensions.');
  end
  
  % Speicher
  O = (N_order+1)^2;
  C = size(x_CF, 1);
  F = size(x_CF, 2);
  J_sph_OCF = zeros(O, C, F);
  
  for n = 0:N_order
    J_CF = sphericalbesselj(n, x_CF);
    for m = -n:n
      J_sph_OCF(n^2+n+m+1, :, :) = J_CF;
    end
  end
