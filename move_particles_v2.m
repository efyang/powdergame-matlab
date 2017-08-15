function move_particles_v2
global particles particles_matrix
%MOVE_PARTICLES_V2 Summary of this function goes here
%   Detailed explanation goes here
new = ones(size(particles_matrix));
[height, width] = size(particles_matrix);
if ~isempty(particles)
    padded_particles = pad_matrix(particles_matrix, -30000);
    %[particles_x, particles_y] = meshgrid(1:width, 1:height);
    %particles_x = pad_matrix(particles_x, -100);
    %particles_y = pad_matrix(particles_y, -100);

    px = particles(:, 1);
    py = particles(:, 2);
    particle_type = particles(:, 3);
    
    is_water = particle_type == 2;
    is_oil = particle_type == 3;
    is_sand = particle_type == 4;

    % pad by one because the particles matrix is padded
    east_neighbors_values = padded_particles(sub2ind(size(padded_particles), py, px + 2));
    west_neighbors_values = padded_particles(sub2ind(size(padded_particles), py, px));
    southeast_neighbors_values = padded_particles(sub2ind(size(padded_particles), py + 1, px + 2));
    south_neighbors_values = padded_particles(sub2ind(size(padded_particles), py + 1, px + 1));
    southwest_neighbors_values = padded_particles(sub2ind(size(padded_particles), py + 1, px));

    bottom_free = (southeast_neighbors_values == 1) |...
        (south_neighbors_values == 1) |...
        (southwest_neighbors_values == 1);
    
    % if bottom is not free
    east_free = east_neighbors_values == 1;
    west_free = west_neighbors_values == 1;
    both_sides_free = east_free & west_free;
    only_east_free = east_free & ~west_free;
    only_west_free = west_free & ~east_free;
    rng = rand(size(particles, 1), 1);
    east_chance = rng < 1/3;
    west_chance = (~east_chance) .* (rng < 2/3);
    stay_chance = ~(west_chance | east_chance);

    side_chance = rng < 2/3;
    single_stay_chance = rng >= 2/3;
 
    new_x_both_sides_free = east_chance .* (px + 1) +...
        west_chance .* (px - 1) +...
        stay_chance .* px;
    new_x_east_free = side_chance .* (px + 1) +...
        single_stay_chance .* px;
    new_x_west_free = side_chance .* (px - 1) +...
        single_stay_chance .* px;
    new_x_bottom_not_free = both_sides_free .* new_x_both_sides_free +...
        only_east_free .* new_x_east_free +...
        only_west_free .* new_x_west_free;
    % make sure that we don't go out of bounds - replace any negative values
    % with the original
    incorrect_bottom_not_free_x = ((new_x_bottom_not_free <= 0) | (new_x_bottom_not_free > width));
    bottom_not_free_x = ~incorrect_bottom_not_free_x .* new_x_bottom_not_free + incorrect_bottom_not_free_x .* px;
    bottom_not_free_y = py;

    % if the bottom is free
    southeast_free = southeast_neighbors_values == 1;
    southwest_free = southwest_neighbors_values == 1;
    south_free = south_neighbors_values == 1;

    southeast_chance = rng < 1/3;
    southwest_chance = (~southeast_chance) .* (rng < 2/3);
    south_stay_chance = ~(west_chance | east_chance);
    south_side_chance = rng < 2/3;
    south_single_stay_chance = rng >= 2/3;

    all_south_free = southeast_free & south_free & southwest_free;
    south_and_southwest_free = southwest_free & south_free & ~southeast_free;
    south_and_southeast_free = southeast_free & south_free & ~southwest_free;
    southeast_and_southwest_free = southeast_free & southwest_free & ~south_free;
    only_southwest_free = southwest_free & ~southeast_free & ~south_free;
    only_southeast_free = southeast_free & ~southwest_free & ~south_free;
    only_south_free = south_free & ~southeast_free & ~southwest_free;
    new_x_all_south_free = southeast_chance .* (px + 1) +...
        southwest_chance .* (px - 1) + ...
        south_stay_chance .* px;
    new_x_south_sw_free = south_side_chance .* (px - 1) +...
        south_single_stay_chance .* px;
    new_x_south_se_free = south_side_chance .* (px + 1) +...
        south_single_stay_chance .* px;
    new_x_se_sw_free = (rng < 1/2) .* (px - 1) +...
        (rng >= 1/2) .* (px + 1);
    new_x_bottom_free = all_south_free .* new_x_all_south_free +...
        south_and_southwest_free .* new_x_south_sw_free +...
        south_and_southeast_free .* new_x_south_se_free +...
        southeast_and_southwest_free .* new_x_se_sw_free +...
        only_southwest_free .* (px - 1) +...
        only_southeast_free .* (px + 1) +...
        only_south_free .* px;
    new_y_bottom_free = py + 1;
    % make sure that we don't go out of bounds - replace any negative values
    % with the original
    incorrect_bottom_free_x = ((new_x_bottom_free <= 0) | (new_x_bottom_free > width));
    incorrect_bottom_free_y = ((new_y_bottom_free <= 0) | (new_y_bottom_free > height));
    bottom_free_x = ~incorrect_bottom_free_x .* new_x_bottom_free + incorrect_bottom_free_x .* px;
    bottom_free_y = ~incorrect_bottom_free_y .* new_y_bottom_free + incorrect_bottom_free_y .* py;
    new_x = bottom_free .* bottom_free_x + ~bottom_free .* bottom_not_free_x;
    new_y = bottom_free .* bottom_free_y + ~bottom_free .* bottom_not_free_y;
    % update the cache
    particles(:, 1) = new_x;
    particles(:, 2) = new_y;
    % now update the main matrix
    new(sub2ind(size(new), particles(:, 2), particles(:, 1))) = particle_type;
end
particles_matrix = new;
end

function padded = pad_matrix(matrix, pad_value)
[height, width] = size(matrix);
appendrow = ones(1, width + 2) .* pad_value;
appendcol = ones(height, 1) .* pad_value;
padded = [appendcol, matrix, appendcol;...
          appendrow];
end
