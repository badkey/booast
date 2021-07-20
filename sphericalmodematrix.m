% 1 Syntax
% ========
% 
%   ,----
%   | Psi_OL = sphericalmodematrix(N_order, theta_L, phi_L, S_norm, S_type)
%   `----
% 
% 
% 
%   % $Id$
% 
% 
% 2 Description
% =============
% 
%   sphericalmodematrix - returns Ambisonics complex conjugate values
% 
% 
% 3 Input Arguments
% =================
% 
%   - N_order - Ambisonics order
%   - theta_L - vector representing the calculation range of inclination
%     theta
%   - phi_L - vector representing the calculation range of azimuth phi
%   - S_norm - string with type of normalization: 'norm' - fully
%     normalized; 'N3D'- normalized; 'sch0' or 'SN3D'- seminormalazed
%     'sch1'- Schmidt-Semi-normalized (Matlab) 'sconv' - norm. over all
%     spherical convolutions 'planewave_impinging' - norm. for plane waves
% 
% 
% 4 Return Values
% ===============
% 
%   - Psi_OL - matrix of complex conjugate spherical harmonics values
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
%   sphericalharmonic
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
function Psi_OL = sphericalmodematrix(N_order, theta_L, phi_L, S_norm, S_type)
  if nargin < 5
    type = 'complex';
  end
  if nargin < 4
    norm = 'norm';
  end

  % Normierungsfaktor
  N_O = sphericalnormalisation(N_order, S_norm);
  
  % Legendrefunktionen
  P_OL = sphericallegendre(N_order, theta_L);

  % Deklinationsfunktion
  D_OL = sphericalazimuth(N_order, phi_L, S_type);

  % Kugelflächenfunktion
  Y_OL = diag(N_O) * P_OL .* D_OL;

  Psi_OL = conj(Y_OL);
