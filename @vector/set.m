    function st = set(st, a, S_type)

    
      if prod(size(a)) ~= prod(st.D_full)
	error('set: Number of vectors must no change.');
      else
	st.a = reshape(a, st.D_full);
	st.S_type = S_type;
      end
    end
