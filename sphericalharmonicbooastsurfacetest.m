S_file='img/sphereharmsurf.png';
%% spherical harmonics
N_order = 2;
A = 30; theta_A = linspace(0, pi, A);
B = 40; phi_B = linspace(0, 2*pi, B);
S_norm = 'norm';
S_type = 'real';
Y_OAB = sphericalharmonic(N_order, theta_A, phi_B, S_norm, S_type);

%% Vectorgrid for a unitsphere
vg = vectorgrid(1, theta_A, phi_B, 'spherical');

%% draw
figure(1); clf;
for n = 0:N_order
  for m = -n:n
    o = n^2+n+m+1;
    subplot(N_order + 1, 2*N_order + 1, (N_order+1)+n*(2*N_order+1)+m);
    Y_AB = Y_OAB(o, :, :);
    % surface(vg, abs(real(Y_AB)), sign(real(Y_AB)), 'dependendSurface');
    surface(vg, abs(real(Y_AB)), [], 'dependendSurface');
    % xlabel('x');
    % ylabel('y');
    % zlabel('z');
    title(sprintf('n = %i, m = %i', n, m));
    view([30 40]);
    grid('on');
    axis('equal');
    axis('nolabel');
  end
end
print(S_file);
ans = S_file;
