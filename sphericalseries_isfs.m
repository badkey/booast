% 1 Syntax
% ========
% 
%   ,----
%   | F_OCABF = sphericalseries_isfs(f_OCF, Y_OAB)
%   `----
% 
% 
% 2 Description
% =============
% 
%   precalculation of ISF
% 
% 
% 3 Input Arguments
% =================
% 
%   f_OCF
%         spherical fourier series coefficient
%   Y_OAB
%         spherical harmonics
% 
% 
% 4 Return Values
% ===============
% 
%   F_OCABF
%         intermediate result
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
function F_OCABF = sphericalseries_isfs(f_OCF, Y_OAB)

  O = size(f_OCF, 1);
  C = size(f_OCF, 2);
  F = size(f_OCF, 3);
  A = size(Y_OAB, 2);
  B = size(Y_OAB, 3);
  F_OCABF = zeros(O, C, A, B, F);
  
  for o = 1:O
    for c = 1:C
      for f = 1:F
        F_OCABF(o, c, 1:A, 1:B, f) = f_OCF(o,c,f) * Y_OAB(o, 1:A, 1:B);
      end
    end
  end
