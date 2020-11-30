% 1 Syntax
% ========
% 
%   ,----
%   | y = trg(m, x)
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
%   - x : numeric argument
%   - m : order
% 
% 
% 4 Return Values
% ===============
% 
%   y
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
 function D_OB = sphericalazimuth(N_order, phi_B, S_type)
 if nargin < 3
   S_type = 'complex';
 end

 D_OB = zeros((N_order+1)^2, length(phi_B));
 switch S_type 
   case 'complex'
     for n= 0:N_order
       for m = -n:n
         o = n^2+n+m+1;
         D_OB(o,:) = exp(1i*m*phi_B);
       end
     end
   case {'real_signed', 'real'}
     for n= 0:N_order
       for m = -n:n
         o = n^2+n+m+1;
         D_OB(o,:) = trg(m, phi_B);
       end
     end
   case 'real_unsigned'
     for n= 0:N_order
       for m = -n:n
         o = n^2+n+m+1;
         D_OB(o,:) = trh(m, phi_B);
       end
     end
   otherwise
     error('Unknown spherical azimuth type %s!', S_type);
 end
