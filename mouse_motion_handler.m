function mouse_motion_handler(src, ~)
% handles the mouse
global mouse_coords

axesHandle = src.CurrentAxes;
coordinates = get(axesHandle, 'CurrentPoint');
coordinates = floor(coordinates(1,1:2));
xLimits = floor(get(axesHandle, 'xlim'));
yLimits = floor(get(axesHandle, 'ylim'));
%coordinates
if (coordinates(1) > min(xLimits) && coordinates(1) < max(xLimits) &&...
        coordinates(2) > min(yLimits) && coordinates(2) < max(yLimits))
    mouse_coords = coordinates;
end

end

