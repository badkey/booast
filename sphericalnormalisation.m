% 1 Syntax
% ========
% 
%   ,----
%   | N_O = sphericalnormalisation(N_order, norm)
%   `----
% 
% 
% 2 Description
% =============
% 
%   Calculates the normalization factor for a given harmonic order and
%   normalization type.  If the type of normalization is not defined at
%   the output, full normalization 'norm' will be performed.
% 
% 
% 3 Input Arguments
% =================
% 
%   N_order
%         order of a spherical harmonic
%   norm
%         type of normalization:
%          'norm'                 fully normalized;                     
%          'N3D'                  normalized;                           
%          'sch0' or 'SN3D'       seminormalazed                        
%          'sch1'                 Schmidt-Semi-normalized (Matlab)      
%          'sconv'                norm. over all spherical convolutions 
%          'planewave_impinging'  norm. for plane waves                 
% 
% 
% 4 Return Values
% ===============
% 
%   - N_O - corresponding normalization factor
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

function N_O = sphericalnormalisation(N_order, norm)
  if nargin < 2
    norm = 'norm';
  end
  N_O = zeros((N_order+1)^2, 1);

  if strcmp(norm, 'norm')
    % fully normalised
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        N_O(o) = sqrt((2*n + 1)/(4*pi) * ...
			 factorial(n-abs(m))/...
			 factorial(n+abs(m)));
	 end
    end
 
  elseif strcmpi(norm, 'N3D')
    % 3D after Daniel
    % führt zu Energie = 4 pi
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        N_O(o) = sqrt((2*n + 1) * ...
			 factorial(n-abs(m))/...
			 factorial(n+abs(m)));
	 end
    end  

  elseif strcmpi(norm, 'SN3D')
    % Schmidt semi norm, see Wikipedia
    % SN3D
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        N_O(o) = sqrt(factorial(n-abs(m))/...
			 factorial(n+abs(m)));
	 end
    end  

  elseif strcmp(norm, 'sch1')
    % Schmidt semi norm, siehe Matlab -- mit Wurzel 2
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        if m ~= 0
          N_O(o) = sqrt(2*factorial(n-abs(m))/...
                        factorial(n+abs(m)));
        else
          N_O(o) = 1;
        end
	 end
    end  

  elseif strcmp(norm, 'sconv')
    % spherical convolution
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        N_O(o) = (2*pi) * sqrt((4*pi)/(2*n + 1));
	 end
    end  

  elseif strcmp(norm, 'planewave')
    % plane wave
    for n = 0:N_order
	 for m = -n:n
        o = n^2+n+m+1;
        N_O(o) = 4*pi*1i^n;
	 end
    end  

  else
    error('Unknown norm ''%s''', norm);
  end
