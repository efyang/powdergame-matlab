function draw_handler(src, ~)
global program_continue particles particles_matrix image_handle particle_disp speed_disp speed
if ~program_continue
    stop(src);
else
    image_handle.CData = render(particles_matrix);
    drawnow;
    particle_disp.String = num2str(size(particles, 1));
    speed_disp.String = num2str(speed);
end
end