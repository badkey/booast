    function a = get(st, S_type, D_dim)
  
    
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
      if nargin < 3
	D_dim = st.D_full;
      end

      %% Daten in Form 3xL bringen
      b = reshape(st.a, st.dims, numel(st));

      switch st.dims
	case 2
       
	  %% Koordinatentransformation
	  if strcmp(st.S_type, S_type)

	    a = b;
  
	  elseif (strcmp(st.S_type, 'cartesian') && strcmp(S_type, 'polar'))
	 
	    [t, r] = cart2pol(b(1, :), b(2, :));
	    a = [r; t]; 
   
	  elseif (strcmp(st.S_type, 'polar') && strcmp(S_type, 'cartesian'))

	    [x, y] = pol2cart(b(2, :), b(1, :));
	    a = [x; y]; 
  
	  else
	    error(sprintf('Unknown type %s - cannot convert.'), S_type);
	  end
       
	case 3
	  %% Koordinatentransformation
	  if strcmp(st.S_type, S_type)

	    a = b;
  
	  elseif (strcmp(st.S_type, 'cartesian') && strcmp(S_type, 'spherical'))
	 
	    [p, t, r] = cart2sph(b(1, :), b(2, :), b(3, :));
	    a = [r; pi/2-t; p]; 
  
	  elseif (strcmp(st.S_type, 'cartesian') && strcmp(S_type, 'polar'))
	 
	    [t, r, z] = cart2pol(b(1, :), b(2, :), b(3, :));
	    a = [r; t; z]; 
   
	  elseif (strcmp(st.S_type, 'polar') && strcmp(S_type, 'cartesian'))

	    [x, y, z] = pol2cart(b(2, :), b(1, :), b(3, :));
	    a = [x; y; z]; 
  
	  elseif (strcmp(st.S_type, 'polar') && strcmp(S_type, 'spherical'))
  
	    [x, y, z] = pol2cart(b(2, :), b(1, :), b(3, :));
	    [p, t, r] = cart2sph(x, y, z);
	    a = [r; pi/2-t; p]; 
  
	  elseif (strcmp(st.S_type, 'spherical') && strcmp(S_type, 'polar'))
  
	    [x, y, z] = sph2cart(b(3, :), pi/2-b(2, :), b(1, :));
	    [p, r, z] = cart2pol(x, y, z);
	    a = [r; p; z];
  
	  elseif (strcmp(st.S_type, 'spherical') && strcmp(S_type, 'cartesian'))
	 
	    [x, y, z] = sph2cart(b(3, :), pi/2-b(2, :), b(1, :));
	    a = [x; y; z]; 
  
	  else
	    error(sprintf('Unknown type %s - cannot convert.'), S_type);
	  end
	otherwise
	  error('dimension error');
      end
  
      %% recreate variable dimemsions 
      a = reshape(a, D_dim);
    end
