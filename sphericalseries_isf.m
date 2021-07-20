% *** Syntax
% 
% *** Description
% 
% *** Input Arguments
% 
% *** Return Values
% 
% *** Examples
% 
% *** Tips
% 
% *** Alternatives
% 
% *** See Also
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
function F_CABF = sphericalseries_isf(f_OCF, Y_OAB, perm)

% sphericalseries_isf - performs inverse spherical Fourier transform
%
% F_CABF = sphericalseries_isf(f_OCF, Y_OAB, perm)
% 
% INPUTS
% f_OCF
% Y_OAB
% perm - permutation matrix
%
% OUTPUTS
% F_CABF
%
% DESCRIPTIOn
% If the number of input arguments is less than 3, the permutation matrix perm is emty, so no
% permutation is done.
%

  if nargin < 3
    perm = [];
  end
  
  % Summanden der ISFT berechnet:
  F_OCABF = sphericalseries_isfs(f_OCF, Y_OAB);

  % über Summenindex o addiert; verbleibende Dimension O = 1
  % anschließend wegschieben (d.h. F_CBAF1 entsteht; squeeze geht
  % nicht, da andere Dimensionen mit 1 mitwegfallen würden)
  F_CABF = shiftdim(sum(F_OCABF, 1), 1);

  % falls gesetzt, permutieren
  if ~isempty(perm)
    F_CABF = permute(F_CABF, perm);
  end
