 function st = normalize(va_A)
   v_rtp = get(va_A, 'spherical');
   v_rtp(1, :) = 1; % set radius to 1
   st = set(va_A, v_rtp, 'spherical');
