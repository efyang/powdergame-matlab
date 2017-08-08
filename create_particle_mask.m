function mask = create_particle_mask(diameter, particle_type)
random = rand([diameter diameter]);
kernel = gaussian_kernel(diameter);
values = random < kernel;
mask = cell2mat(arrayfun(@(x) ret_if(x, particle_type), values, 'UniformOutput', false));
end

function particle = ret_if(value, yes_particle)
if value
    particle = struct(yes_particle);
else
    particle = struct(Particle.None);
end
end