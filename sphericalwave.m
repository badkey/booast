  function p_CABSF =  sphericalwave(vr_CAB, vs_S, k_F, Z0)

    %% detect input args
    if nargin < 4
      Z0 = 1;
    end
  
    %% allocate memory
    Dim_r = size(vr_CAB);
    Dim_s = size(vs_S);
    R = prod(Dim_r);
    S = prod(Dim_s);
    F = numel(k_F);
    p_RSF = zeros(R, S, F);

    %% Vectors in cart. coord.:
    r_xyz_R = get(vr_CAB, 'cartesian', [3, R]);
    s_xyz_S = get(vs_S,   'cartesian', [3, S]);

    %% Green
    for r = 1:R
      for s = 1:S
	%% rel. Abstand
	r_os = sqrt(sum((r_xyz_R(:,r) - s_xyz_S(:,s)).^2));
	for f = 1:F
	  %% Vorfaktor mal Green'sche Funktion
	  if r_os != 0
	    p_RSF(r,s,f) = -i * Z0 * k_F(f) * ...
			    exp(i * k_F(f) * r_os) / (4*pi * r_os);
	  else
	    p_RSF(r,s,f) = NaN; %-i * Z0 * k_F(f); % tdb: lies Williams
	  end
	end
      end
    end

    %% reshape output 
    p_CABSF = reshape(p_RSF, [Dim_r, Dim_s, F]);
