function z=xlogy(x, y)

% XLOGY z= x*log(y) returns zero if x=y=0

% GCA

% If there is only one input argument x is assumed to equal y.
if nargin == 1
  y=x;
end
if any(x==0)
  z = zeros(size(x));
  indx = find(x);
  z(indx)= x(indx).*log(y(indx));
else
  z= x.*log(y);
end