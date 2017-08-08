function update_handler(src, event)
%UPDATE_HANDLER Summary of this function goes here
%   Detailed explanation goes here
global program_continue mouse_down mouse_coords
if ~program_continue
    stop(src);
else
    % Do stuff on each iteration
    % check for mouseclick/drag
    if mouse_down
        disp(mouse_coords);
    end
end
end

