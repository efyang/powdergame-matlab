function draw_handler(src, ~)
% draws the particles and updates the gu
global program_continue particles particles_matrix image_handle diameter_disp diameter
global particle_disp speed_disp speed density density_disp
if ~program_continue
    stop(src);
else
    % hacky way to update screen data quickly
    image_handle.CData = render(particles_matrix);
    drawnow;
    particle_disp.String = num2str(size(particles, 1));
    speed_disp.String = num2str(speed);
    diameter_disp.String = num2str(diameter);
    density_disp.String = num2str(density);
end
end