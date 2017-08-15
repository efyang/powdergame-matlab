function draw_handler(src, ~)
global program_continue particles_matrix image_handle
if ~program_continue
    stop(src);
else
    image_handle.CData = render(particles_matrix);
    drawnow;
end
end