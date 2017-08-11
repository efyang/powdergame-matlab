function update_handler(src, ~)
%UPDATE_HANDLER Summary of this function goes here
%   Detailed explanation goes here
global program_continue mouse_down mouse_coords particles particles_matrix
global particle_choice diameter image_handle
if ~program_continue
    stop(src);
else
    % Do stuff on each iteration
    % check for mouseclick/drag
    if mouse_down
        %particles_matrix(mouse_coords(2), mouse_coords(1)) = particle_choice;
        diameter = 21;
        radius = floor(diameter/2);
        xmin = mouse_coords(1) - radius;
        xmax = mouse_coords(1) + radius;
        ymin = mouse_coords(2) - radius;
        ymax = mouse_coords(2) + radius;
        
        allowed = (particles_matrix(ymin:ymax, xmin:xmax) == 1);
        
        [mask, positions] = create_particle_mask(diameter, allowed, particle_choice);

        particles_matrix(ymin:ymax, xmin:xmax) = ...
            particles_matrix(ymin:ymax, xmin:xmax) + mask;
        new_particles = [positions, ones(size(positions, 1), 1)*particle_choice];
        new_particles(:, 1) = new_particles(:, 1) + mouse_coords(1) - radius;
        new_particles(:, 2) = new_particles(:, 2) + mouse_coords(2) - radius;
        particles = [particles; new_particles];
    end
    
    for ii = 1:5
    move_particles();
    end
    image_handle.CData = render(particles_matrix);
    drawnow;
end
end