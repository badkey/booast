% 1 Syntax
% ========
% 
%   ,----
%   | A_OFD = sphericalseries_hoa_plane(N_order, theta_D, phi_D, S_norm, S_type, F, psi_D)
%   `----
% 
% 
% 2 Description
% =============
% 
%   calculates plane wave coefficients $A$ for a HOA representation.
% 
% 
% 3 Input Arguments
% =================
% 
%   N_order
%         Ambisonics order
%   theta_D
%         vector representing the calculation range of inclination theta
%   phi_D
%         vector representing the calculation range of azimuth phi
%   S_norm
%         string with type of normalization:
%          'norm'                 fully normalized;                     
%          'N3D'                  normalized;                           
%          'sch0' or 'SN3D'       seminormalazed                        
%          'sch1'                 Schmidt-Semi-normalized (Matlab)      
%          'sconv'                norm. over all spherical convolutions 
%          'planewave_impinging'  norm. for plane waves                 
%   S_type
%         type of the spherical harmonic: 'real', 'real_signed',
%         'real_unsigned' or 'complex'
%   F
%         number of frequency bins (having all the same value)
%   psi_D
%         weights for D input direction (optional argument)
% 
% 
% 4 Return Values
% ===============
% 
%   A_OFD
%         matrix of HOA coefficients
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
%   sphericalnormalisation, sphericalmodematrix
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

function A_OFD = sphericalseries_hoa_plane(N_order, theta_D, phi_D, ...
                                           S_norm, S_type, F, ...
                                           psi_D);
  D = length(theta_D);
  if nargin < 7
    psi_D = ones(1, D);
  end
  
  % Vorfaktor ebene Welle
  %N_O = sphericalnormalisation(N_order, 'planewave_impinging');
  N_O = sphericalnormalisation(N_order, 'planewave');
  
  % Modenmatrix für alle Einfallsrichtungen
  Psi_OD = sphericalmodematrix(N_order, theta_D, phi_D, ...
                               S_norm, S_type);

  % return: Die Koeffzi. der ebenen Welle sind frequenzunabhängig, nur
  % rein formal wird Dimension F mit aufgefüllt.
  A_OFD = zeros((N_order+1)^2, F, D);
  for f = 1:F
    for d = 1:D
      A_OFD(:,f,d) = psi_D(d) * (N_O .* Psi_OD(:,d));
    end
  end
