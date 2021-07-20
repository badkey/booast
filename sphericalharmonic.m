% 1 Syntax
% ========
% 
%   ,----
%   | Y_OAB = sphericalharmonic(N_order, theta_A, phi_B, norm, type)
%   `----
% 
% 
% 2 Description
% =============
% 
%   If the number of input arguments is < 5, the calculation would be done
%   for a 'complex' type of a spherical harmonic. If the number of input
%   arguments is < 4, the calculation would be done for a 'norm'
%   normalization type case.
% 
%   Harmonics are returned in rows of p (e.g. row = 1 -> m = 0, row = 2 ->
%   m = 1) after e.g. Poletti.
% 
% 
% 3 Input Arguments
% =================
% 
%   N_order
%         Ambisonics order
%   theta_A
%         vector representing the calculation range of inclination theta
%   phi_B
%         vector representing the calculation range of azimuth phi
%   norm
%         string with type of normalization:
%          'norm'                 fully normalized                      
%          'N3D'                  normalized                            
%          'sch0' or 'SN3D'       seminormalazed                        
%          'sch1'                 Schmidt-Semi-normalized (Matlab(tm))  
%          'sconv'                norm. over all spherical convolutions 
%          'planewave_impinging'  norm. for plane waves                 
%   type
%         type of the spherical harmonic:
%          'real', 'real_signed', 'real_unsigned'  or 'complex' 
% 
% 
% 4 Return Values
% ===============
% 
%   Y_OAB
%         matrix of the spherical harmonics values
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
function Y_OAB = sphericalharmonic(N_order, theta_A, phi_B, norm, type)
if nargin < 5
  type = 'complex';
end
if nargin < 4
  norm = 'norm';
end
O = (N_order+1)^2;

%% Normierungsfaktor
N_O = sphericalnormalisation(N_order, norm);

%% Legendrefunktionen
P_OA = sphericallegendre(N_order, theta_A);

%% Deklinationsfunktion
D_OB = sphericalazimuth(N_order, phi_B, type);

%% Speicher klarmachen:
Y_OAB = zeros(O, length(theta_A), length(phi_B));

%% Kugelflächenfunktion
for o = 1:O
  Y_OAB(o, :, :) = N_O(o) * P_OA(o, :).' * D_OB(o, :);
end
