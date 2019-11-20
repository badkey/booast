% 1 Syntax
% ========
% 
%   ,----
%   | p_CABF = sphericalseries_hoa(C_OF, F_OCBAF, D_OF, G_OCBAF)
%   `----
% 
% 
% 2 Description
% =============
% 
%   returns result of HOA series with coefficients C and D und basis
%   functions F and G. The second pair (D and G) is optional.
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
function p_CABF = sphericalseries_hoa(C_OF, F_OCABF, D_OF, G_OCABF)
  
  if length(size(F_OCABF)) < 3
    error('Function basis needs at least 3 dimensions.');
  end
  
  % berechne Ergebnis der Reihenentwicklung mit Koeffizienten C mit
  % Funktionsbasis F:
  if ~isempty(F_OCABF)
    p_CABF = sphericalseries(C_OF, F_OCABF);
  else
    p_CABF = [];
  end
  
  % falls zwei Koeffzi. und Basen übergeben, weitere Berechnung:
  if nargin == 4
    
    if ~isempty(G_OCABF)
      q_CABF = sphericalseries(D_OF, G_OCABF);
    else
      q_CABF = [];
    end

    % concatiniere 8) Ergebnis: 
    p_CABF = [p_CABF; q_CABF];
  end
  
function p_CABF = sphericalseries(C_OF, F_OCABF)
% bestimme Größe der Eingangsmatrizen 
  C = size(F_OCABF, 2);
  A = size(F_OCABF, 3);
  B = size(F_OCABF, 4);
  F = size(F_OCABF, 5);
  p_CABF = zeros(C, A, B, F);
  for f = 1:F
    for c = 1:C
      for a= 1:A
        for b = 1:B
          p_CABF(c, a, b, f) = C_OF(:,f).' *  F_OCABF(: ,c, a, b, f);
        end
      end
    end
  end
