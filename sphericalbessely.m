% 1 Syntax
% ========
% 
%   ,----
%   | N_sph = sphericalbessely(n, x)
%   `----
% 
% 
% 2 Description
% =============
% 
%   2nd kind Bessel function is computed for each element of x.If the
%   input argument (element of a matrix x) is = 0, the output has a value
%   NaN.
% 
% 
% 3 Input Arguments
% =================
% 
%   - n - Ambisonics order
%   - x - matrix to return the result (should not have more than 2
%     dimensions)
% 
% 
% 4 Return Values
% ===============
% 
%   - N_sph - matrix of the 2nd kind Bessel function values
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
%   bessely
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

function N_sph = sphericalbessely(n, x)

  idx_zero = find(x == 0);
  if length(idx_zero) ~= 0
    disp(['sphericalneumann: found zeros in input argument: setting ' ...
          'to NaN!']);
    idx_zero
    x(idx_zero) = nan;
  end
  
  % sph. Besselfunktion der 2. Art für pos. Arg.
  N_sph = (pi ./ (2*abs(x))).^0.5 .* bessely(n + 0.5, abs(x));

  % finde neg. Arg.
  idx_neg = (x < 0);
  
  % Vorzeichen für neg. Arg. retten (vlg. Gumerov/Duraiswami Glg. 2.1.90)
  N_sph(idx_neg) = (-1)^(n+1) * N_sph(idx_neg);

  N_sph = reshape(N_sph, size(x));
