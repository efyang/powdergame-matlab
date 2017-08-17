function [mask, positions] = create_particle_mask(diameter, allowed, particle_type, density)
% density from 0 to 1
random = rand([diameter diameter]);
%values = random < 0.3;

radius = diameter/2;

% limit particles to a circular spot to reduce squareness
[xx, yy] = meshgrid(1:diameter, 1:diameter);
circle_mask = ((xx - radius - 1).^2 + (yy - radius - 1).^2) < radius ^ 2;

% parabolic distribution
paraboloid_vals = density -((xx - radius).^2 + (yy - radius).^2) / (diameter^2 / (density * 2));
values = random < paraboloid_vals;

base_mask = values .* circle_mask .* allowed;

xs = xx .* base_mask;
ys = yy .* base_mask;

positions = [xs(:) ys(:)];

% remove anything that is not allowed
positions(all(positions==0, 2), :) = [];

mask = base_mask .* (particle_type - 1);

end