function y = digamma(x)

% DIGAMA Compute the digamma function based on the description given in Bernardo.

% GCA

% This ismplementation is by Thomas Minka for MATLAB based on the
% implementations below.
% Reference:
%
%    J Bernardo,
%    Psi ( Digamma ) Function,
%    Algorithm AS 103,
%    Applied Statistics,
%    Volume 25, Number 3, pages 315-317, 1976.
%
% From http://www.psc.edu/~burkardt/src/dirichlet/dirichlet.f

large = 9.5;
d1 = -0.5772156649015328606065121;  % digamma(1)
d2 = pi^2/6;
small = 1e-6;
s3 = 1/12;
s4 = 1/120;
s5 = 1/252;
s6 = 1/240;
s7 = 1/132;
s8 = 691/32760;
s9 = 1/12;
s10 = 3617/8160;

% Initialize
y = zeros(size(x));

% illegal arguments
i = find(x == -Inf | isnan(x));
if ~isempty(i)
  x(i) = NaN;
  y(i) = NaN;
end

% Negative values
i = find(x < 0);
if ~isempty(i)
  % Use the reflection formula (Jeffrey 11.1.6):
  % digamma(-x) = digamma(x+1) + pi*cot(pi*x)
  y(i) = digamma(-x(i)+1) + pi*cot(-pi*x(i));
end
  
i = find(x == 0);
if ~isempty(i)
  y(i) = -Inf;
end

%  Use approximation if argument <= small.
i = find(x > 0 & x <= small);
if ~isempty(i)
  y(i) = y(i) + d1 - 1 ./ x(i) + d2*x(i);
end

%  Reduce to digamma(X + N) where (X + N) >= large.
while(1)
  i = find(x > small & x < large);
  if isempty(i)
    break
  end
  y(i) = y(i) - 1 ./ x(i);
  x(i) = x(i) + 1;
end

%  Use de Moivre's expansion if argument >= large.
% In maple: asympt(Psi(x), x);
i = find(x >= large);
if ~isempty(i)
  r = 1 ./ x(i);
  y(i) = y(i) + log(x(i)) - 0.5 * r;
  r = r .* r;
  y(i) = y(i) - r .* ( s3 - r .* ( s4 - r .* (s5 - r .* (s6 - r .* s7))));
end
