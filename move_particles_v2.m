function move_particles_v2
global particles particles_matrix
%MOVE_PARTICLES_V2 Summary of this function goes here
%   Detailed explanation goes here
new = ones(size(particles_matrix));
[height, width] = size(particles_matrix);
padded_particles = pad_matrix(particles_matrix, 0);
[particles_x, particles_y] = meshgrid(1:width, 1:height);
particles_x = pad_matrix(particles_x, 0);
particles_y = pad_matrix(particles_y, 0);

% pad by one because the particles matrix is padded
px = particles(:, 1) + 1;
py = particles(:, 2);
particle_type = particles(:, 3);

east_neighbors_values = padded_particles(py, px + 1);
west_neighbors_values = padded_particles(py, px - 1);
southeast_neighbors_values = padded_particles(py + 1, px + 1);
south_neighbors_valuse = padded_particles(py + 1, px);
southwest_neighbors_values = padded_particles(py + 1, px - 1);

bottom_free = (southeast_neighbors_values == 1) | (south_neighbors_valuse == 1) | (southwest_neighbors_values == 1);

% if bottom is not free
east_free = east_neighbors_values == 1;
west_free = west_neighbors_values == 1;
both_sides_free = east_free & west_free;
only_east_free = east_free & ~west_free;
only_west_free = west_free & ~east_free;
east_chance = rand([height + 1, width + 2]) < 1/3;
west_chance = rand([height + 1, width + 2]) < 1/3;

%~bottom_free .* ()
end

function padded = pad_matrix(matrix, pad_value)
[height, width] = size(matrix);
appendrow = ones(1, width + 2) .* pad_value;
appendcol = ones(height, 1) .* pad_value;

padded = [appendcol, matrix, appendcol;...
          appendrow];
end
