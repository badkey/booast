% 1 Syntax
% ========
% 
%   ,----
%   | C_OCFD = sphericalseries_sfc(A_OFD, B_OFD, r_C, R_src, k_F)
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
%   - A_OFD - matrix of HOA coefficients
%   - B_OFD - matrix of HOA coefficients
%   - r_C - radius ???
%   - R_src - source radius
%   - k_F - vector of a wave number values for a given frequency range
% 
% 
% 4 Return Values
% ===============
% 
%   - C_OCFD - multi-dimensional matrix of the spherical FT coefficients
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
%   sphericalbessel, sphericalhankel
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
function C_OCFD = sphericalseries_sfc(A_OFD, B_OFD, r_C, R_src, k_F)

  % Speicher klarmachen
  O = size(A_OFD, 1);
  F = size(A_OFD, 2);
  D = size(A_OFD, 3);
  C = length(r_C);
  C_OCFD = zeros(O, C, F, D);
  
  % Wertebereich aufteilen
  ind_ext  = find(r_C <= R_src); % exterior case
  ind_int  = find(r_C >  R_src); % interior case

  % entsprechende spezielle Funktionen berechnen
  N_order = sqrt(O) - 1;
  if ~isempty(ind_ext)
    j_OCF = sphericalbessel(N_order, r_C(ind_ext).'*k_F);
  end
  if ~isempty(ind_int)
    h_OCF = sphericalhankel(N_order, r_C(ind_int).'*k_F);
  end
  
  % sph. fourier coeff. berechnet
  for d = 1:D
    for f = 1:F
      for c = 1:length(ind_ext)
        C_OCFD(:,ind_ext(c), f, d) = A_OFD(:,f,d) .* j_OCF(:,c,f);
      end
      for c = 1:length(ind_int)
        C_OCFD(:,ind_int(c), f, d) = B_OFD(:,f,d) .* h_OCF(:,c,f);
      end
    end
  end
