function [vm, varargout] = positions(S_setup, varargin)
  switch S_setup

    case 'soundfieldmic'

      Tilt_mic = atan(1/sqrt(2))/pi*180; % Farrar
      Theta_L = (90 + [-1, 1, 1, -1] * Tilt_mic)* pi/180; % U  D  D  U
      Phi_L  =  (0 + [45 -45 135 -135]) * pi/180; % FL FR BL BR
      R_mic  = 0.0147; % Gerzon 1975
      vm = vector(R_mic*ones(1,4), Theta_L, Phi_L, 'spherical');
      varargout{1} = pi*ones(4, 1); % gain pi is applied to adapt the soundfields amplitude to HOA theory

    case 'octomic'
      Tilt_up = -36;
      Tilt_down = 36;
      Theta_L = [(90 + [1, 1, 1, 1] * Tilt_up), (90 + [1, 1, 1, 1] * Tilt_down)];
      Phi_L  =  [90 * linspace(0, 3, 4) , (90 * linspace(0, 3, 4) + 45)];
      R_mic  = 0.0147; %????
      vm = vector(R_mic*ones(1,8), Theta_L * pi/180, Phi_L  * pi/180, 'spherical');
      varargout{1} = ones(8, 1); % gain 1

   case 'circle'
      % param #1: number of loudspeakers
      % param #2: radius
        L_pos = varargin{1};
        R_pos = varargin{2};
   

      r_L = R_pos * ones(1, L_pos);
      p_L = 2*pi*([1:L_pos]-1)/L_pos;
      t_L = pi/2 * ones(1, L_pos);
      vm = vector(r_L, t_L, p_L, 'spherical');

   case 'sphere'
     L_pos = varargin{1};
     S_filename = sprintf('%i.txt', L_pos);
     if exist(S_filename, 'file')
       nodes = load(S_filename);
     else
       error(sprintf('Cannot load nodes file %s. Does not exist.',...
                     S_filename));
     end
     vm = vector(nodes(:,1:3).', 'cartesian'); % cart. Koord.
     varargout{1} = nodes(:,4);

case 'hexagon'

  X_num = varargin{1};
  Y_num = varargin{2};
  if length(varargin) == 2
    Z_num = 1;
  else
    Z_num = varargin{3};
  end
      
  x = [0:1:X_num-1];
  y = [0:1:Y_num-1] * sqrt(3);
  z = [0:1:Z_num-1] * sqrt(6)/3;
  if length(x)>1 
    u = x(1:end-1) + 1/2;
  else 
    u=0;
  end
  if length(y)>1
    v = y(1:end-1) + sqrt(3)/2;
  else
    v =0;
  end
  gg = vectorgrid(x, y, 0, 'cartesian');
  gf = vectorgrid(u, v, 0, 'cartesian');
  
				% Grid-Punkte in Ebene erzeugen:
  g_xy0_XY = get(vector(gg), 'cartesian');
  f_xy0_UV = get(vector(gf), 'cartesian');
  h_xy0_M = [reshape(g_xy0_XY, 3, X_num*Y_num), ...
	     reshape(f_xy0_UV, 3,size(f_xy0_UV,2)*size(f_xy0_UV,3))];
  M = size(h_xy0_M, 2);
  
  for l = 1:length(z)
    if mod(l,2)
      h_xyz_L(1:2,[1:M]+ (l-1)*M) = h_xy0_M(1:2,:);
    else
      h_xyz_L(1,[1:M]+ (l-1)*M) = h_xy0_M(1,:) + 1/2;
      h_xyz_L(2,[1:M]+ (l-1)*M) = h_xy0_M(2,:) + sqrt(3)/4;
    end
    h_xyz_L(3,[1:M]+ (l-1)*M) = z(l);
  end
  
  vm = vector(h_xyz_L, 'cartesian');

case 'hexagon_square'
      
  R_length = varargin{1};
  H_length = varargin{2};

  %% bestimme Anzahl benötigter Punkte
  X_num = ceil(R_length/H_length);
  Y_num = ceil(R_length/(sqrt(3)*H_length));
  vm_L = positions('hexagon', X_num, Y_num);
      
  %% Punkte um den Ursprung verteilen und skalieren
  m_xyz_L = get(vm_L, 'cartesian');
  m_xyz_L = H_length * ...
            (m_xyz_L - ...
             ([(X_num-1)/2, (Y_num-1)*sqrt(3)/2, 0].' * ...
              ones(1, numel(vm_L))));
  vm = vector(m_xyz_L, 'cartesian');
    
case 'hexagon_cube'
      
  R_length = varargin{1};
  H_length = varargin{2};

  %% bestimme Anzahl benötigter Punkte
  X_num = ceil(R_length/H_length);
  Y_num = ceil(R_length/(sqrt(3)*H_length));
  Z_num = ceil(R_length/(sqrt(6)/3*H_length));

  vm_L = positions('hexagon', X_num, Y_num, Z_num);
      
  %% Punkte um den Ursprung verteilen und skalieren
  m_xyz_L = get(vm_L, 'cartesian');
  m_xyz_L = H_length * ...
            (m_xyz_L - ...
             ([(X_num-1)/2, (Y_num-1)*sqrt(3)/2, (Z_num-1)*sqrt(6)/6].' * ...
              ones(1, numel(vm_L))));
  vm = vector(m_xyz_L, 'cartesian');
    
case 'hexagon_circle'
      
  R_circle = varargin{1};
  H_length = varargin{2};

  vm_L = positions('hexagon_square', 2*R_circle, H_length);

  %% Kreis ausschneiden
  m_rtp_L = get(vm_L, 'spherical');
  idx_R = (m_rtp_L(1,:) <= R_circle);
  vm = vector(m_rtp_L(:,idx_R), 'spherical');
      
case 'hexagon_sphere'
      
  R_circle = varargin{1};
  H_length = varargin{2};
  
  vm_L = positions('hexagon_cube', 2*R_circle, H_length);

  %% Kreis ausschneiden
  m_rtp_L = get(vm_L, 'spherical');
  idx_R = (m_rtp_L(1,:) <= R_circle);
  vm = vector(m_rtp_L(:,idx_R), 'spherical');

    otherwise
      error(sprintf('unknown position: %s.', S_setup));
end
