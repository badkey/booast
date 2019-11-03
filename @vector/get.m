    function a = get(st, S_type, D_dim)
  
    
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
