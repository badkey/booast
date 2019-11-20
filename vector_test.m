    x = linspace(1, 10, 100); y = x(1:3); z = x; S_type = 'cartesian';
    g = vectorgrid(x, y, z, S_type);
  ans = isa(g, 'vectorgrid');

    x = linspace(1, 10, 100); y = x(1:3); S_type = 'cartesian';
    g = vectorgrid(x, y, S_type);
  ans = isa(g, 'vectorgrid');
