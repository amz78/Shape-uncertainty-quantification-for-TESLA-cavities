function [crv, u] = bspinterpcrv_custom_knots (Q, p, method, knots)
%
% BSPINTERPCRV: B-Spline interpolation of a 3d curve.
%
% Calling Sequence:
%
%   crv = bspinterpcrv (Q, p);
%   crv = bspinterpcrv (Q, p, method);
%   [crv, u] = bspinterpcrv (Q, p);
%   [crv, u] = bspinterpcrv (Q, p, method);
%
%    INPUT:
%
%      Q      - points to be interpolated in the form [x_coord; y_coord; z_coord].
%      p      - degree of the interpolating curve.
%      method - parametrization method. The available choices are:
%               'equally_spaced'
%               'chord_length'
%               'centripetal' (Default)
%
%    OUTPUT:
%
%      crv - the B-Spline curve.
%      u   - the parametric points corresponding to the interpolation ones.
%
%    See The NURBS book pag. 364 for more information.
%
%
% Copyright (C) 2015 Jacopo Corno
%

  if (nargin < 3 || isempty (method))
    method = 'centripetal';
  end

  n = size (Q, 2);
  if (strcmpi (method, 'equally_spaced'))
    u = linspace (0, 1, n);
  elseif (strcmpi (method, 'chord_length'))
    d = sum (sqrt (sum (diff (Q')'.^2,1)));
    u = zeros (1, n);
    u(2:n) = cumsum (sqrt (sum (diff(Q, [], 2).^2, 1)))/d;
%    for ii = 2:n-1
%      u(ii) = u(ii-1) + norm (Q(:,ii) - Q(:,ii-1)) / d;
%    end
    u(end) = 1;
  elseif (strcmpi (method, 'centripetal'))
    d = sum (sqrt (sqrt (sum (diff (Q')'.^2,1))));
    u = zeros (1, n);
    u(2:n) = cumsum (sqrt (sqrt (sum (diff(Q, [], 2).^2, 1))))/d;
%    for ii = 2:n-1
%      u(ii) = u(ii-1) + sqrt (norm (Q(:,ii) - Q(:,ii-1))) / d;
%    end
    u(end) = 1;
  elseif (strcmpi (method, 'custom'))
    u = linspace (0, 1, n);
  else
    error ('BSPINTERPCRV: unrecognized parametrization method.')
  end

  if (~strcmpi (method, 'custom'))
    knts = zeros (1, n+p+1);
    for jj = 2:n-p
      knts(jj+p) = 1/p * sum (u(jj:jj+p-1));
    end
    knts(end-p:end) = ones(1,p+1);
  else
    knts = knots;
  end

  A = zeros (n, n);
  A(1,1) = 1;
  A(n,n) = 1;
  for ii=2:n-1
    span = findspan (n, p, u(ii), knts);
    A(ii,span-p+1:span+1) = basisfun (span, u(ii), p, knts);
  end

  x = A \ Q(1,:)';
  y = A \ Q(2,:)';
  z = A \ Q(3,:)';
  pnts = [x'; y'; z'; ones(size(x'))];
  crv = nrbmak (pnts, knts);

end

%!demo
%! Q = [1 0 -1 -1 -2 -3;
%!      0 1  0 -1 -1 0;
%!      0 0  0  0  0 0];
%! p = 2;
%! crv = bspinterpcrv (Q, p);
%! 
%! plot (Q(1,:), Q(2,:), 'xk');
%! hold on; grid on;
%! nrbkntplot (crv);