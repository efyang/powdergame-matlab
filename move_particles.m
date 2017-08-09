function move_particles
global particles particles_matrix
%MOVE_PARTICLES Summary of this function goes here
%   Detailed explanation goes here
new = ones(size(particles_matrix));
max_fall = size(particles_matrix, 1);
for ii = 1:size(particles, 1)
    particle = particles(ii, :);
    px = particle(1);
    py = particle(2);
    particle_type = particle(3);
    
    if py < max_fall && particles_matrix(py + 1, px) == 1
        new(py + 1, px) = particle_type;
        particles(ii, 2) = py + 1;
    else
        new(py, px) = particle_type;
    end
end

particles_matrix = new;
end

