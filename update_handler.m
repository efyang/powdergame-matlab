function update_handler(src, ~)
%UPDATE_HANDLER Summary of this function goes here
%   Detailed explanation goes here
global program_continue mouse_down mouse_coords particles particles_matrix
global particle_choice
if ~program_continue
    stop(src);
else
    % Do stuff on each iteration
    % check for mouseclick/drag
    if mouse_down
        %particles_matrix(mouse_coords(2), mouse_coords(1)) = particle_choice;
        size(particles_matrix);
        diameter = 21;
        radius = floor(diameter/2);
        allowed = (particles_matrix(mouse_coords(2)-radius:mouse_coords(2)+radius,...
            mouse_coords(1)-radius:mouse_coords(1)+radius) == 1);
        [mask, positions] = create_particle_mask(21, allowed, particle_choice);

        particles_matrix(mouse_coords(2)-radius:mouse_coords(2)+radius,...
            mouse_coords(1)-radius:mouse_coords(1)+radius) = ...
            particles_matrix(mouse_coords(2)-radius:mouse_coords(2)+radius,...
            mouse_coords(1)-radius:mouse_coords(1)+radius) + mask;
        new_particles = [positions, ones(size(positions, 1), 1)*particle_choice];
        new_particles(:, 1) = new_particles(:, 1) + mouse_coords(1) - radius;
        new_particles(:, 2) = new_particles(:, 2) + mouse_coords(2) - radius;
        particles = [particles; new_particles];
    end
    
    move_particles();
end
end