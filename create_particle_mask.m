function [mask, positions] = create_particle_mask(diameter, allowed, particle_type)
random = rand([diameter diameter]);
%values = random < 0.3;

radius = diameter/2;

[xx, yy] = meshgrid(1:diameter, 1:diameter);
circle_mask = ((xx - radius).^2 + (yy - radius).^2) < radius ^ 2;

paraboloid_vals = 0.5-((xx - radius).^2 + (yy - radius).^2) / (diameter^2 / 2);
values = random < paraboloid_vals;

base_mask = values .* circle_mask .* allowed;

xs = xx .* base_mask;
ys = yy .* base_mask;

positions = [xs(:) ys(:)];

positions(all(positions==0, 2), :) = [];

mask = base_mask .* (particle_type - 1);

end