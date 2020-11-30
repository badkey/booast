% 1 Syntax
% ========
% 
% 
% 2 Description
% =============
% 
%   ,----
%   | [R_OCABF, S_OCABF] = sphericalseries_hoa_basis(N_order, R_src, ...
%   |                                            vg_CAB, k_F, ...
%   |                                            S_norm, S_type)
%   `----
% 
% 
%   returns spherical basis functions R = j_n Y and S = h_n Y
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

function [R_OCABF, S_OCABF] = sphericalseries_hoa_basis(N_order, R_src, ...
                                               vg_CAB, k_F, ...
                                               S_norm, S_type)

  if strcmp(type(vg_CAB), 'spherical')
    
    [r_C, theta_A, phi_B] = grid(vg_CAB);
    
    ind_ext  = find(r_C <= R_src); % exterior case
    ind_int  = find(r_C >  R_src); % interior case
    
    % Basisfunktionen als Summanden der inversen
    % sph. Fouriertransformation mit den Funktionen j_n und h_n
    % berechnet:
    Y_OAB = sphericalharmonic(N_order, theta_A, phi_B, S_norm, S_type);

    if ~isempty(ind_ext)
      j_OCF = sphericalbessel(N_order, r_C(ind_ext).'*k_F);
      R_OCABF = sphericalseries_isfs(j_OCF, Y_OAB);
    else
      R_OCABF = [];
    end

    if ~isempty(ind_int)
      h_OCF = sphericalhankel(N_order, r_C(ind_int).'*k_F);
      S_OCABF = sphericalseries_isfs(h_OCF, Y_OAB);
    else
      S_OCABF = [];
    end
  else 
    error('Vectorgrid need to be spherical (at least in a way...).');
  end
