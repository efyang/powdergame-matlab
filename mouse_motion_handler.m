function mouse_motion_handler(src, ~)
% handles the mouse
global mouse_coords diameter

axesHandle = src.CurrentAxes;
coordinates = get(axesHandle, 'CurrentPoint');
coordinates = floor(coordinates(1,1:2));
xLimits = floor(get(axesHandle, 'xlim'));
yLimits = floor(get(axesHandle, 'ylim'));
radius = diameter/2;
%coordinates
if (coordinates(1) - radius > min(xLimits) && coordinates(1) + radius < max(xLimits) &&...
        coordinates(2) - radius > min(yLimits) && coordinates(2) + radius < max(yLimits))
    mouse_coords = coordinates;
end

end

