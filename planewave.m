  function p_CABFD =  planewave(vr_CAB, vk_FD)
    %% allocate memory
    Dim_r = size(vr_CAB);
    Dim_k = size(vk_FD);
    R = prod(Dim_r);
    K = prod(Dim_k);
    p_RK = zeros(R, K);

    %% Vectors in cart. coord.:
    r_xyz_R = get(vr_CAB, 'cartesian', [3, R]);
    k_xyz_K = get(vk_FD, 'cartesian', [3, K]);

    %% pressure:
    for r = 1:R
      for k = 1:K
	p_RK(r,k) = exp(i*(k_xyz_K(:, k).' * r_xyz_R(:, r)));
      end
    end
    p_CABFD = reshape(p_RK, [Dim_r, Dim_k]);
  end
