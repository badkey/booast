function st = set(st, a, S_type)
% set - modifies the vector object 
% 
% st = set(st, a, S_type)
%
% INPUTS 
% st - existing vector object
% a - matrix with 3 rows and coordinate values
% S_type - type of coordinate system 'cartesian'|'spherical'|'polar'
%
% OUTPUTS
% st - modified vector object
%
% DESCRIPTION
% set - modifies the input vector object by replacing its values by  values from the matrix a 
% taken coloumn-wise. 
% Obtained vector object has a type according to the input value of S_type   
%              
% See also: vector, reshape
  if prod(size(a)) ~= prod(st.D_full)
    error('set: Number of vectors must no change.');
  else
    st.a = reshape(a, st.D_full);
    st.S_type = S_type;
  end
end
