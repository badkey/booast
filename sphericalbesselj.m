% 1 Syntax
% ========
% 
%   ,----
%   | J_sph_CF = sphericalbesselj(N_order, x_CF);
%   `----
% 
% 
% 2 Description
% =============
% 
%   spherical bessel function at order N
% 
% 
% 3 Input Arguments
% =================
% 
%   x_CF
%         C x F matrix
% 
% 
% 4 Return Values
% ===============
% 
%   J_sph_CF
%         C x F matrix
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

function J_sph_CF = sphericalbesselj(N_order, x_CF)
  
  C = size(x_CF, 1);
  F = size(x_CF, 2);
  L = C*F;
  x_L = reshape(x_CF, 1, L);
  J_sph_L = zeros(L, 1);
  
  % finde Nullen im Argument
  idx_zero = (x_L == 0);

  % Ergebnis zuweisen
  if N_order == 0
    J_sph_L(idx_zero) = 1;
  else
    J_sph_L(idx_zero) = 0;
  end

  % finde den Rest
  idx_nzero = (x_L ~= 0);

  % Ergebnis zuweisen
  J_sph_L(idx_nzero) = sqrt(pi ./ (2*x_L(idx_nzero))) .* ...
      besselj(N_order + 0.5, x_L(idx_nzero));

  % Form retten
  J_sph_CF = reshape(J_sph_L, C, F);
