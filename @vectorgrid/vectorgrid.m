  function st = vectorgrid(s1, s2, varargin)

  
  switch nargin

    case 3
      st.dims = 2;

      if (isreal(s1) && isvector(s1))  
	st.achse{1} = s1;
      end
      if (isreal(s2) && isvector(s2))  
	st.achse{2} = s2;  
      end
      S_type = varargin{1};
      if (ischar(S_type))
	st.S_type = S_type;
      end

    case 4
      st.dims = 3;

      if (isreal(s1) && isvector(s1))  
	st.achse{1} = s1;
      end
      if (isreal(s2) && isvector(s2))  
	st.achse{2} = s2;  
      end
      s3 = varargin{1};
      if (isreal(s3) && isvector(s3))  
	st.achse{3} = s3;
      end
      S_type = varargin{2};
      if (ischar(S_type))
	st.S_type = S_type;
      end
    otherwise
      error('vectorgrid: need 3 or 4 input arguments.')
  end
  st = class(st, 'vectorgrid');
  superiorto ('vector');
