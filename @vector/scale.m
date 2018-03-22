function vc_AB = scale(a_A, vb_B)

  % Speicha
  A = length(a_A);
  B = numel(vb_B);
  c_xyz_AB = zeros([3, A, B]); 
  
  % save dimensions of vb_B
  C_dims = size(vb_B);

  % if C_dims = Bx1 then squeeze dim
  if (length(C_dims) == 2) && (C_dims(2) == 1)
    clear C_dims;
    C_dims = B;
  end
  
  % Vektoren aus vb durchmultiplizieren
  b_xyz_B = reshape(get(vb_B, 'cartesian'), 3, B);

  for a = 1:A
     c_xyz_AB(1:3, a, 1:B) = a_A(a) * b_xyz_B;
  end
  
  % squeeze if A == 1
  if A == 1
    c_AB = reshape(c_xyz_AB, [3, C_dims]);
  else
    c_AB = reshape(c_xyz_AB, [3, A, C_dims]);
  end

  % return
  vc_AB = vector(c_AB, 'cartesian');
