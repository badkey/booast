  %% create observation grid (cartesian volume)
  A = 30; B = 40; C = 50;
  r_A     = linspace(0, 10, A);
  theta_B = linspace(0, pi, B);
  phi_C   = linspace(0, 1.5*pi, C);
  g_ABC   = vectorgrid(r_A, theta_B, phi_C, 'spherical');

  %% slice some planes for visualisation
  g_AB1 = g_ABC(:,:,10);  % circle
  g_A1C = g_ABC(:,10,:);  % conus
  g_1BC = g_ABC(20,:,:);  % sphere

  %% direction/wavenumbervector of planewave
  v = vector([1, 1, 0.3]', 'cartesian');

  p_AB1 = real(planewave(vector(g_AB1), v));
  p_A1C = real(planewave(vector(g_A1C), v)); %% visualise
  p_1BC = real(planewave(vector(g_1BC), v));

  figure(1); clf;
  surface(g_AB1, p_AB1);
  surface(g_A1C, p_A1C);
  surface(g_1BC, p_1BC);
  xlabel('x'); ylabel('y'); zlabel('z');
  view(30,40); axis('equal');
