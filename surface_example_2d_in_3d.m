S_file='img/2d_in_3d__spherical_surface_colored_booast.png';
    A = 20; B = 30; C = 2;
    g_ABC = vectorgrid(linspace(-3, 3, A), linspace(-2, 2, B), linspace(0, 1, C), 'cartesian');
  g_AB1 = g_ABC(:,:,1);
  r_xyz_AB = get(vector(g_AB1), 'cartesian');
  s_AB = squeeze(sum(r_xyz_AB(1:2, :, :).^2, 1));

  figure(1); clf;
  surface(g_AB1, s_AB);
  view([30, 40]);
  print(S_file);
  ans = S_file;
