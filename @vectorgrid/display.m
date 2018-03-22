function display(st)
  %% display class name
  fprintf('Vectorgrid %s contains', inputname(1));
  fprintf(' %i axes.\n', st.dims);
  fprintf('The coordinate type is %s.\n', st.S_type);
  disp('The size is');
  disp(size(st));
end
