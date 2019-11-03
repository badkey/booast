   function D_dim = numel(st)

   
   if isa(st, 'vector')
     D_dim = prod(size(st));
   else
     error('Not a vector - cannot happen.')
   end
