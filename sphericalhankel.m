% 1 Syntax
% ========
% 
%   ,----
%   | h_OCF = sphericalhankel(n, x_CF)
%   `----
% 
% 
% 2 Description
% =============
% 
%   According to the mathematical definition, Hankel function is obtained
%   be combining two linearly independent solutions of Bessel's
%   differential equation (Wikipedia). This is done by means of summation
%   spherical bessel function of the 1st kind with spherical bessel
%   function of the 2nd kind, multiplyed by the imaginary unit.
% 
%   This calculation is done for all elements of the matrix x_Cf
% 
% 
% 3 Input Arguments
% =================
% 
%   - n - Ambisonics order
%   - x_CF - matrix to return the result (should not have more than 2
%     dimensions)
% 
% 
% 4 Return Values
% ===============
% 
%   - h_OCF - multi-dimensional matrix of calculation results
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
%   sphericalbessel, sphericalneumann
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
function h_OCF = sphericalhankel(n, x_CF)

h_OCF = sphericalbessel(n, x_CF) + i*sphericalneumann(n, x_CF);
