function update_handler(src, ~)
%UPDATE_HANDLER Callback, defines the update loop
global program_continue mouse_down mouse_coords particles particles_matrix
global particle_choice diameter stop_sim speed density
if ~program_continue
    stop(src);
else
    % Do stuff on each iteration
    % check for mouseclick/drag
    if mouse_down
        radius = floor(diameter/2);
        if rem(diameter, 2) == 1
            xmin = mouse_coords(1) - radius;
            ymin = mouse_coords(2) - radius;
        else
            xmin = mouse_coords(1) - radius + 1;
            ymin = mouse_coords(2) - radius + 1;
        end
        xmax = mouse_coords(1) + radius;
        ymax = mouse_coords(2) + radius;
        
        allowed = (particles_matrix(ymin:ymax, xmin:xmax) == 1);
        
        [mask, positions] = create_particle_mask(diameter, allowed, particle_choice, density);
        % add on the particle mask
        particles_matrix(ymin:ymax, xmin:xmax) = ...
            particles_matrix(ymin:ymax, xmin:xmax) + mask;
        new_particles = [positions, ones(size(positions, 1), 1)*particle_choice];
        new_particles(:, 1) = new_particles(:, 1) + mouse_coords(1) - radius;
        new_particles(:, 2) = new_particles(:, 2) + mouse_coords(2) - radius;
        particles = [particles; new_particles];
    end
    % update the particles
    if ~stop_sim
        for ii = 1:speed
            move_particles_v2();
        end
    end
end
end