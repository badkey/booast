function a = get(st, S_type, D_dim)
% vector_get - returns the content of a vector object 
%
% a = vector_get(st, S_type, D_dim)
% 
% INPUTS 
% st - vector object 
% S_type - string with ('cartesian'|'polar'|'spherical')
% D_dim - vector with dimensions of va (optional)
%
% OUTPUTS
% a - matrix with 3 rows and elements according to S_type and D_dim dimensions. 
%

  if nargin < 3
    D_dim = st.D_full;
  end
    
  % Daten in Form 3xL bringen
  b = reshape(st.a, 3, numel(st));
  
  % Koordinatentransformation
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
  
  % Dimemsionen wiederherstellen
  a = reshape(a, D_dim);
end
