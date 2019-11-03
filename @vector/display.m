 function display(st)
 % DISPLAY display vector v
 %
 % ┌────
 % │ display(v)
 % └────
 % display content of vector `v' on stdout.
 % 
 % See also: whos

 
   fprintf('%s = ', inputname(1));
   fprintf('%f ', st.a);
   fprintf('\n');
 end
