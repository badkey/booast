  function st = vector(s1, s2,  s3, S_type)

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

  if nargin == 4

    %% Vektor aus 3 Komponenten zusammengesetzt
    st.a = [s1; s2; s3]; % in jeder Spalte ein Vektor mit 3 Elementen
    st.S_type = S_type;
  
  elseif nargin == 2

    %% Vektor als Matrix übergeben (Dimension 1 muss 3 sein, alle
    %% weiteren sind beliebig und werden in D_full abgelegt)
    assert(size(s1, 1) == 3, ...
	     'vector: 1st arg - matrix with 3 lines expected.');
    assert(ischar(s2), ...
	     'vector: 2nd arg - string with coordinate system expected.');

    st.a = s1;
    st.S_type = s2;
  elseif nargin == 1
    assert(isa(s1, 'vectorgrid'), ...
	     'vector: vectorgrid expected for single argument call');

    %% Daten aus Vectorgrid in Vektor umwandeln
    [st.a, st.S_type] = get(s1);
  else
    error('Wrong number of input arguments.');
  end

  %% Bestimme vector-Dimensionen (wobei Dimension 1 = 3 oder 2...)
  st.D_full = size(st.a); 

  %% bestimme Dimensionalität
  st.dims = st.D_full(1);

  %% Objekt erzeugt
  st = class(st, 'vector');
  end
