function update_handler(src, ~)
%UPDATE_HANDLER Summary of this function goes here
%   Detailed explanation goes here
global program_continue mouse_down mouse_coords particles particles_matrix
global particle_choice temp_mask empty_mask
if ~program_continue
    stop(src);
else
    % Do stuff on each iteration
    % check for mouseclick/drag
    if mouse_down
        %particle = struct(particle_choice);
        %particles_matrix(mouse_coords(2), mouse_coords(1)) = particle;
        particles_matrix(mouse_coords(2) - 2:mouse_coords(2) + 2, mouse_coords(1) - 2:mouse_coords(1) + 2) = ...
            particles_matrix(mouse_coords(2) - 2:mouse_coords(2) + 2, mouse_coords(1) - 2:mouse_coords(1) + 2).plus(create_particle_mask(5, Particle.Oil));
        particles = [particles Particle.Water];
    end
end
end

