function surface(g_slice, s_slice, c_slice, S_flag)

  %% proc input arguments  
  if nargin < 4
    S_flag = 'independendSurface';
  end
  if nargin < 3
    c_slice = [];
  end
  if nargin < 2 
    s_slice = [];
  end

  %% test g_slice for dims
  assert(numel(size(g_slice))==3, 'g_slice is expected to have 3 dimensions.');

  %% get matlab meshgrid from vectorgrid; this is the surface we plot
  [x, y, z] = meshgrid(g_slice);

  %% as we operate on a matlab meshgrid, we can savely squeeze them
  x = squeeze(x);
  y = squeeze(y);
  z = squeeze(z);

  if ~isempty(s_slice)

    %% preserve dims
    s_slice_size = size(s_slice);

    if numel(s_slice_size) == 2
      %% meshgrid reshapes accordingly to matlab meshgrid; do the same for
      %function s_slice
      s_slice = s_slice.';
    else
      %% ensure dims for s_slice
      s_slice = squeeze(s_slice);
    end
  end

  %% create new surface if surface is dependend on grid
  if ~isempty(s_slice) && strcmp(S_flag, 'dependendSurface')

    %% for surface creation we need to determine which dimension is singular
    slice_size = size(g_slice);

    switch g_slice.S_type

       case 'cartesian'

	  if slice_size(1) == 1
	    %% g_ABC -> g_BC
	    x = x + s_slice;
	  elseif slice_size(2) == 1
	    %% g_ABC -> g_AC
	    y = y + s_slice;
	  elseif slice_size(3) == 1
	    %% g_AB -> g_AB
	    z = z + s_slice;
	  end

	case 'spherical'
	  
	  %% get surface of grid
	  %% create surface as defnd. by s_slice
	  if slice_size(1) == 1
	    x = x .* s_slice;
	    y = y .* s_slice;
	    z = z .* s_slice;
	  elseif slice_size(2) == 1
	    disp('not implemented yet.');
	  elseif slice_size(3) == 1
	    disp('not implemented yet.');
	  end
	otherwise
	  error('Unknown coordinate type.');
    end
  end

  %% draw the surface finally
  if isempty(c_slice)
    if isempty(s_slice)
	surface(x, y, z);
    else
	surface(x, y, z, s_slice);
    end
  else
    surface(x, y, z, c_slice.');
  end
