  function Dim_g = size(st)
  
  
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
