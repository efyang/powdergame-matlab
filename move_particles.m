function move_particles
global particles particles_matrix
%MOVE_PARTICLES Summary of this function goes here
%   Detailed explanation goes here
new = ones(size(particles_matrix));
[height, width] = size(particles_matrix);
tic
for ii = 1:size(particles, 1)
    particle = particles(ii, :);
    px = particle(1);
    py = particle(2);
    particle_type = particle(3);
    switch particle_type
        case 2
            % water: absolutely disgusting but should work
            % bottom edge case
            if py == height
                new_coordinate = pick_side_coordinate(px, py, width, height, new);
            else
                bottomx = max(1, px - 1):min(width, px + 1);
                bottom_values_new = new(py + 1, bottomx);
                bottom_values = particles_matrix(py + 1, bottomx);
                allowed_positions = bottom_values == 1 & bottom_values_new == 1;
                total_allowed = sum(allowed_positions);
                if total_allowed == 0
                    % the bottom is full - go to the side
                    new_coordinate = pick_side_coordinate(px, py, width, height, new);
                else
                    new_coordinate = pick_side_coordinate(px, py + 1, width, height, new);
                end
            end
        case 4
            if py < height && particles_matrix(py + 1, px) == 1
                new_coordinate = [px, py + 1];
            else
                new_coordinate = [px, py];
            end
    end
    new(new_coordinate(2), new_coordinate(1)) = particle_type;
    particles(ii, 1:2) = new_coordinate;
end
toc
particles_matrix = new;
end


function new_coordinate = pick_side_coordinate(px, py, width, height, new)
global particles_matrix
% check the side to the right
right_coord = [];
left_coord = [];
if px + 1 <= width && particles_matrix(py, px + 1) == 1 &&...
        new(py, px + 1) == 1
    left_coord = [px + 1, py];
end
% check the side to the right
if px - 1 >= 1 && particles_matrix(py, px - 1) == 1 &&...
        new(py, px - 1) == 1
    right_coord = [px - 1, py];
end

if ~isempty(right_coord) && ~isempty(left_coord)
    % both open
    rng = rand;
    if rng < 1/6
        % move right
        new_coordinate = right_coord;
    elseif rng < 2/6
        % move left
        new_coordinate = left_coord;
    else
        % stay in place
        new_coordinate = [px, py];
    end
elseif ~isempty(right_coord)
    % right open
    rng = rand;
    if rng < 1/5
        new_coordinate = right_coord;
    else
        new_coordinate = [px py];
    end
elseif ~isempty(left_coord)
    % left open
    rng = rand;
    if rng < 1/5
        new_coordinate = left_coord;
    else
        new_coordinate = [px py];
    end
else
    new_coordinate = [px py];
end
end