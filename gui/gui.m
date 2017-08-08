function [fig, canvas, canvas_size] = gui(width, height, name, selection_buttons)

DRAW_AREA_RATIO = 0.7;
SELECTION_BUTTONGROUP_RATIO = 0.8;

%  Create and then hide the UI as it is being constructed.
f = figure('Visible', 'off',...
            'NumberTitle', 'off',...
            'Position',[0, 0, width, height],...
            'resize', 'off',...
            'MenuBar', 'none');

% Initialize the UI.
draw_area = axes(f, 'Position', [0, (1 - DRAW_AREA_RATIO) 1 DRAW_AREA_RATIO],...
    'Color', [0 0 0],...
    'XTick', [],...
    'YTick', []);
main_buttongroup = uibuttongroup(f, 'Position', [0 0 1 (1 - DRAW_AREA_RATIO)]);
% used for selecting particle type
selection_buttongroup = uibuttongroup(main_buttongroup, 'Position',...
    [0, 0,SELECTION_BUTTONGROUP_RATIO, 1]);
action_buttongroup = uibuttongroup(main_buttongroup, 'Position',...
    [SELECTION_BUTTONGROUP_RATIO, 0, (1 - SELECTION_BUTTONGROUP_RATIO), 1]);

% Change units to normalized so components resize automatically.
f.Units = 'normalized';
draw_area.Units = 'normalized';
main_buttongroup.Units = 'normalized';
selection_buttongroup.Units = 'normalized';
action_buttongroup.Units = 'normalized';

% Assign the a name to appear in the window title.
f.Name = name;
% Move the window to the center of the screen.
movegui(f,'center');
% Make the window visible.
f.Visible = 'on';

% function x_callback(source, eventdata)
%   body
% end
fig = f;
canvas = draw_area;
canvas_size = fliplr(round([width height] ./ 2 .* [1 DRAW_AREA_RATIO]));
end