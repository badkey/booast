function st = subsref(st, s)

  %% s is a struct containing type and subs, see doc for subsref
  switch (s(1).type)
    case '()' 
      for dim  = 1:length(s(1).subs)
	st.achse{dim} = st.achse{dim}(s(1).subs{dim});
      end
    case '{}'
      error('@vectorgrid/subsref: cell arrays are no implemented yet.');
    otherwise
      error('@vectorgrid/subsref: invalid property %s', s(1).type);
  endswitch
end
