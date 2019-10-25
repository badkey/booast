  function st = vectorgrid(s1, s2, varargin)

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
