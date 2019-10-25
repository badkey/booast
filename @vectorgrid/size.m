  function Dim_g = size(st)
  
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
    if isa(st, 'vectorgrid')
      switch st.dims
	case 2
	  c = numel(st.achse{1});
	  a = numel(st.achse{2});
	  Dim_g = [c, a];
	case 3
	  c = numel(st.achse{1});
	  a = numel(st.achse{2});
	  b = numel(st.achse{3});
	  Dim_g = [c, a, b];
	otherwise
	  error('unknown number for dims.');
      end
    else
      disp('This is not a vectorgrid - cannot happen error.');
      Dim_g = [0];
    end
