% 1 Syntax
% ========
% 
%   ,----
%   | P_OA = sphericallegendre(N_order, theta_A)
%   `----
% 
% 
% 2 Description
% =============
% 
%   Resulting matrix of Legendre function values has the dimensions
%   ((N_order+1)^2+1)xlength(theta_A).  For positive odd m a negative sign
%   is used.  No normalization is used.  Regarding normalization the
%   calculation is done for a symmetric calculation of m.
% 
%   - for $m >= 0$: $P_n^m(\cos(\theta )$ [including $(-1)^m$]
%   - for $m < 0:$ $(-1)^m P_n^{|m|}(\cos(\theta )$
% 
%   equivalent to (using legendre polynomial notation without
%   Condon-Shortley phase):
%   - for $m >= 0$: $(-1)^m P_n,|m|( \cos(\theta )$
%   - for $m < 0$: $P_n,|m|( \cos(\theta )$
% 
% 
% 3 Input Arguments
% =================
% 
%   N_order
%         order of the spherical harmonic
%   theta_A
%         vector representing the calculation range of inclination theta
% 
% 
% 4 Return Values
% ===============
% 
%   P_OA
%         matrix of Legendre function values
% 
% 
% 5 See Also
% ==========
% 
%   legendre
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

 function P_OA = sphericallegendre(N_order, theta_A)

   O = (N_order+1)^2;
   A = length(theta_A);  % Anzahl der theta Werte
   P_OA = zeros(O, A);   % Legendre polynom 1. art
   Q_OA = zeros(O, A);   % Legendre polynom 2. art
  
   for n = 0:N_order % order index
     % hier keine Normierung verwendet, stattdessen sphericalnormalisation
     % legendre polynomial includes the (-1)^m term
     P_QA = legendre(n, cos(theta_A));
     % size: (n+1)xA
     % P_n^m(cos(theta_A)) ist in Zeile m+1; m = 0..n
     % see: http://www.mathworks.com/help/techdoc/ref/legendre.html
     % P_n^m(x) = (-1)^m (1-x^2)^{m/2} \frac{\mathrm d^m}{\mathrm d x^m} P_n(x).
    
     % Indizes in der Koeffzi.-Pyramide links/mitte/rechts
     o_l = n^2+1;     % 1 + ACN(n, m=-n); ACN(n, m) = n*(n+1) + m;
     o_m = n^2+n+1;   % 1 + ACN(n, m=0)
     o_r = n^2+2*n+1; % 1 + ACN(n, m=+n)

     % m >= 0
     P_OA(o_m:o_r, :) = P_QA;
     if n > 0
         % m < 0
         m = -1:-1:-n;
         fac = repmat((-1).^m(:), 1, A); 
         P_OA([o_m-1:-1:o_l], :) = fac .* P_QA(2:end,:);
     end
   end