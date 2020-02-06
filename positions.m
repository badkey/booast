function [vm, varargout] = positions(S_setup, varargin)
  switch S_setup
    case 'soundfieldmic'

      Tilt_mic = atan(1/sqrt(2))/pi*180; % Farrar
      Theta_L = (90 + [-1, 1, 1, -1] * Tilt_mic)* pi/180; % U  D  D  U
      Phi_L  =  (0 + [45 -45 135 -135]) * pi/180; % FL FR BL BR
      R_mic  = 0.0147; % Gerzon 1975
      vm = vector(R_mic*ones(1,4), Theta_L, Phi_L, 'spherical');
      varargout{1} = pi*ones(4, 1); % gain pi is applied to adapt the soundfields amplitude to HOA theory

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

    otherwise
      error(sprintf('unknown position: %s.', S_setup));
end
