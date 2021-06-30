  function [n_dim_size, S_type] = get(st, shape)

  
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
    size_g = size(st);
    switch st.dims
      case 3
	n_dim_size = zeros(st.dims, size_g);
	for c = 1:size_g(1)
	  for a = 1:size_g(2)
	    for b = 1:size_g(3)
	      n_dim_size(: ,c, a, b) = [st.achse{1}(c);
					st.achse{2}(a);
					st.achse{3}(b)];
	    end
	  end
	end
      case 2
	n_dim_size = zeros(st.dims, size_g);
	for c = 1:size_g(1)
	  for a = 1:size_g(2)
	    n_dim_size(: ,c, a) = [st.achse{1}(c);
				   st.achse{2}(a)];
	  end
	end
      otherwise
	error('wrong dimension.');
    end
    if nargin == 2
      n_dim_size = reshape(n_dim_size, [3, shape]);
    end
    S_type = st.S_type;
  end
