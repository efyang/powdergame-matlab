function mouse_motion_handler(src, ~)
% handles mouse movement
global mouse_coords diameter

axesHandle = src.CurrentAxes;
coordinates = get(axesHandle, 'CurrentPoint');
coordinates = floor(coordinates(1,1:2));
% limits stuff so that we don't have to deal with edge cases
xLimits = floor(get(axesHandle, 'xlim'));
yLimits = floor(get(axesHandle, 'ylim'));
radius = diameter/2;
% update mouse coordinates
if (coordinates(1) - radius > min(xLimits) && coordinates(1) + radius < max(xLimits) &&...
        coordinates(2) - radius > min(yLimits) && coordinates(2) + radius < max(yLimits))
    mouse_coords = coordinates;
end

end

