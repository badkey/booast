        %% create observation grid (cartesian volume)
        x_A = linspace(0, 10, 60);
        y_B = linspace(0, 10, 30);
        z_C = linspace(0, 10, 40);
        g_ABC = vectorgrid(x_A, y_B, z_C, 'cartesian');
    
        %% slice some planes for visualisation
        g_AB1 = g_ABC(:,:,1);
        g_A1C = g_ABC(:,20,:);
        g_1BC = g_ABC(1,:,:);
    
        %% direction/wavenumbervector of planewave
        v = vector([1, 0.1, 0.1]', 'cartesian');
        p_AB1 = planewave(vector(g_AB1), v);
        p_A1C = planewave(vector(g_A1C), v);
        p_1BC = planewave(vector(g_1BC), v);
    
        %% visualise
        figure(1); clf; hold('on');
        surface(g_AB1, real(p_AB1)); 
        surface(g_A1C, real(p_A1C));
        surface(g_1BC, real(p_1BC));
        xlabel('x'); ylabel('y'); zlabel('z');
        view(30,40);
    S_file = 'img/exa_plane_wave_cartesian.png';
    saveas(1, S_file);
    ans = S_file;
