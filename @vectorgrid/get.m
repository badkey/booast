function [n_dim_size, S_type] = get(st, shape)
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
