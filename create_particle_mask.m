function [mask, positions] = create_particle_mask(diameter, allowed, particle_type)
random = rand([diameter diameter]);
%values = random < 0.3;

[xx, yy] = meshgrid(1:diameter, 1:diameter);
circle_mask = ((xx - diameter/2).^2 + (yy - diameter/2).^2) < (diameter/2) ^ 2;

paraboloid_vals = 0.5-((xx - diameter/2).^2 + (yy - diameter/2).^2) / (diameter^2 / 2);
values = random < paraboloid_vals;

base_mask = values .* circle_mask .* allowed;
xs = xx .* base_mask;
ys = yy .* base_mask;
positions = [xs(:) ys(:)];
positions(all(positions==0, 2), :) = [];

mask = base_mask .* particle_type;
end