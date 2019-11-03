   function D_dim = size(st)

   
   if isa(st, 'vector')
     %% verwerfe Dimension 1 mit Wert 3
     if numel(st.D_full) == 2
       D_dim = [st.D_full(2), 1];
     else
       D_dim = st.D_full(2:end);
     end
   else
     disp('its size time: return empty size');
     D_dim = [0,0];
   end
