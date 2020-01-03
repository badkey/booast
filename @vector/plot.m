% 1 Syntax
% ========
% 
%   ,----
%   | plot(v, '*')
%   `----
% 
% 
% 2 Description
% =============
% 
%   plots position of v in 3D space
% 
% 
% 3 Input Arguments
% =================
% 
%   v
%         vector
%   s
%         string like "*"
% 
% 
% 4 Return Values
% ===============
% 
%   none
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
%   plot, plot3, ezplot
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

function plot(vpos, varargin)
r_xyz_L = get(vpos, 'cartesian');
plot3(r_xyz_L(1, :), ...
      r_xyz_L(2, :), ...
      r_xyz_L(3, :), ...
	  varargin{1});
