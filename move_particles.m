function move_particles
%MOVE_PARTICLES updates the positions of the particles in both particles
%and particles_matrix
global particles particles_matrix
new = ones(size(particles_matrix));
[height, width] = size(particles_matrix);
if size(particles, 2) > 1
    particles = sortrows(particles, 1);
end

for ii = 1:size(particles, 1)
    particle = particles(ii, :);
    px = particle(1);
    py = particle(2);
    particle_type = particle(3);
    switch particle_type
        case 2
            % water: absolutely disgusting but should work
            if py > 1 && particles_matrix(py - 1, px) == 4
                % swap positions with the sand particle - the same
                % thing is done for a sand particle above a water
                % particle, so that both are properly swapped
                new_coordinate = [px, py - 1];
            % bottom edge case
            elseif py == height
                new_coordinate = pick_side_coordinate(px, py, width, new);
            else
                bottomx = max(1, px - 1):min(width, px + 1);
                bottom_values_new = new(py + 1, bottomx);
                bottom_values = particles_matrix(py + 1, bottomx);
                allowed_positions = bottom_values == 1 & bottom_values_new == 1;
                total_allowed = sum(allowed_positions);
                % do a check for sand particles above
                if total_allowed == 0
                    % the bottom is full - go to the side
                    new_coordinate = pick_side_coordinate(px, py, width, new);
                elseif py < width && particles_matrix(py + 1, px) == 3
                    new_coordinate = [px, py + 1];
                else
                    % pick from the bottom
                    new_coordinate = pick_bottom_coordinate(px, py + 1, width, new);
                end
            end
        case 3
            % oil
            % bottom edge case
            if py > 1 && (particles_matrix(py - 1, px) == 4 || particles_matrix(py - 1, px) == 2)
                % swap positions with the sand particle - the same
                % thing is done for a sand particle above a water
                % particle, so that both are properly swapped
                new_coordinate = [px, py - 1];
            elseif py == height
                new_coordinate = pick_side_coordinate(px, py, width, new);
            else
                bottomx = max(1, px - 1):min(width, px + 1);
                bottom_values_new = new(py + 1, bottomx);
                bottom_values = particles_matrix(py + 1, bottomx);
                allowed_positions = bottom_values == 1 & bottom_values_new == 1;
                total_allowed = sum(allowed_positions);
                % do a check for sand particles above
                if total_allowed == 0
                    % the bottom is full - go to the side
                    new_coordinate = pick_side_coordinate(px, py, width, new);
                else
                    % pick from the bottom
                    new_coordinate = pick_bottom_coordinate(px, py + 1, width, new);
                end
            end
        case 4
            % sand
            if py < height && (particles_matrix(py + 1, px) == 1 ||...
                    particles_matrix(py + 1, px) == 2 ||...
                    particles_matrix(py + 1, px) == 3)
                new_coordinate = [px, py + 1];
            else
                new_coordinate = [px, py];
            end
    end
    % update the values
    new(new_coordinate(2), new_coordinate(1)) = particle_type;
    particles(ii, 1:2) = new_coordinate;
end

particles_matrix = new;
end


function new_coordinate = pick_side_coordinate(px, py, width, new)
global particles_matrix
% check the side to the right
right_coord = [];
left_coord = [];
if px + 1 <= width && particles_matrix(py, px + 1) == 1
    left_coord = [px + 1, py];
end
% check the side to the right
if px - 1 >= 1 && particles_matrix(py, px - 1) == 1
    right_coord = [px - 1, py];
end

if ~isempty(right_coord) && ~isempty(left_coord)
    % both open
    rng = rand;
    if rng < 3/7
        % move right
        new_coordinate = right_coord;
    elseif rng < 2 * (3/7)
        % move left
        new_coordinate = left_coord;
    else
        % stay in place
        new_coordinate = [px, py];
    end
elseif ~isempty(right_coord)
    % right open
    rng = rand;
    if rng < 5/6
        new_coordinate = right_coord;
    else
        new_coordinate = [px py];
    end
elseif ~isempty(left_coord)
    % left open
    rng = rand;
    if rng < 5/6
        new_coordinate = left_coord;
    else
        new_coordinate = [px py];
    end
else
    % check if there is sand on top
    % if there is, swap with it
    
    new_coordinate = [px py];
end
end

function new_coordinate = pick_bottom_coordinate(px, py, width, new)
global particles_matrix
% check the side to the right
right_coord = [];
left_coord = [];
center_coord = [];
if px + 1 <= width && particles_matrix(py, px + 1) == 1 
    left_coord = [px + 1, py];
end
% check the side to the right
if px - 1 >= 1 && particles_matrix(py, px - 1) == 1
    right_coord = [px - 1, py];
end
if particles_matrix(py, px) == 1
    center_coord = [px, py];
end

if ~isempty(right_coord) && ~isempty(left_coord) && ~isempty(center_coord)
    % all open
    rng = rand;
    if rng < 3/7
        % move right
        new_coordinate = right_coord;
    elseif rng < 2 * (3/7)
        % move left
        new_coordinate = left_coord;
    else
        % stay in place
        new_coordinate = center_coord;
    end
elseif ~isempty(right_coord) && ~isempty(center_coord)
    % right open
    rng = rand;
    if rng < 5/6
        new_coordinate = right_coord;
    else
        new_coordinate = [px py];
    end
elseif ~isempty(left_coord) && ~isempty(center_coord)
    % left open
    rng = rand;
    if rng < 5/6
        new_coordinate = left_coord;
    else
        new_coordinate = [px py];
    end
elseif ~isempty(right_coord) && ~isempty(left_coord)
    % both open but not south
    rng = rand;
    if rng < 1/6
        new_coordinate = left_coord;
    else
        new_coordinate = right_coord;
    end
elseif ~isempty(right_coord)
    new_coordinate = right_coord;
elseif ~isempty(left_coord)
    new_coordinate = left_coord;
elseif ~isempty(center_coord)
    new_coordinate = center_coord;
end
end