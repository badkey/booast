function display(st)
% display content of a vectorgrid g.



  fprintf('Vectorgrid %s contains', inputname(1));
  fprintf(' %i axes.\n', st.dims);
  fprintf('The coordinate type is %s.\n', st.S_type);
  disp('The size is');
  disp(size(st));
end
