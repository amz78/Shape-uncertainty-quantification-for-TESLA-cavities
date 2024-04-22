function [crv_mu, crv_t] = basic_deformations (mu, T, tesla_knots, z)

% Choose a set of knots for interpolation from the TESLA knots
tesla_knots = tesla_knots(4:end-3); % eliminate zeros and ones...

n_first = 8;
tmp_idx = floor (linspace (1, numel(tesla_knots), n_first+2));
tmp = tesla_knots(tmp_idx(2:end-1));
first_knots = [0 0 0 tmp 1 1 1];
other_knots = tesla_knots(setdiff (1:numel(tesla_knots), tmp_idx(2:end-1)));

% Interpolate mean value curv
mu_points = [0, mu(1:9), 0;
             0, mu(10:end), 0;
             z];
crv_mu = bspinterpcrv_custom_knots (mu_points, 2, 'custom', first_knots);
crv_mu = nrbkntins (crv_mu, other_knots);

% Interpolate columns of T
for imode = 1:size (T, 2)
  t_points = [0, T(1:9,imode)', 0;
              0, T(10:end,imode)', 0;
              z];
  crv_t(imode) = bspinterpcrv_custom_knots (t_points, 2, 'custom', first_knots);
  crv_t(imode) = nrbkntins (crv_t(imode), other_knots);
end