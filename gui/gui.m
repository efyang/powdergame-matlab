function [fig, canvas, canvas_size] = gui(width, height, name)
global particle_disp speed_disp diameter_disp
DRAW_AREA_RATIO_Y = 0.9;
DRAW_AREA_RATIO_X = 0.7;
SELECTION_BUTTONGROUP_RATIO = 0.8;

%  Create and then hide the UI as it is being constructed.
f = figure('Visible', 'off',...
            'NumberTitle', 'off',...
            'Position',[0, 0, width, height],...
            'resize', 'off',...
            'MenuBar', 'none');

% Initialize the UI.
draw_area = axes(f, 'Position', [0, (1 - DRAW_AREA_RATIO_Y) DRAW_AREA_RATIO_X DRAW_AREA_RATIO_Y],...
    'Color', [0 0 0],...
    'XTick', [],...
    'YTick', []);
main_buttongroup = uibuttongroup(f, 'Position', [0 0 1 (1 - DRAW_AREA_RATIO_Y)]);

% used for selecting particle type
selection_buttongroup = uibuttongroup(main_buttongroup, 'Position',...
    [0, 0, SELECTION_BUTTONGROUP_RATIO, 1]);

uicontrol(selection_buttongroup, 'string', 'Water', 'style', 'pushbutton', 'callback', @pb1_cb, 'units', 'normalized', 'position', [0 0 1/2 1]);
uicontrol(selection_buttongroup, 'string', 'Sand', 'style', 'pushbutton', 'callback', @pb2_cb, 'units', 'normalized', 'position', [1/2 0 1/2 1]);
%uicontrol(selection_buttongroup, 'string', 'Oil', 'style', 'pushbutton', 'callback', @pb3_cb, 'units', 'normalized', 'position', [2/3 0 1/3 1]);

action_buttongroup = uibuttongroup(main_buttongroup, 'Position',...
    [SELECTION_BUTTONGROUP_RATIO, 0, (1 - SELECTION_BUTTONGROUP_RATIO), 1]);

uicontrol(action_buttongroup, 'string', 'Reset', 'style', 'pushbutton', 'callback', @reset_cb, 'units', 'normalized', 'position', [0 1/2 1 1/2]);

uicontrol(action_buttongroup, 'string', 'Stop', 'style', 'togglebutton', 'callback', @stop_cb, 'units', 'normalized', 'position', [0 0 1 1/2]);

other_buttons = uibuttongroup(f, 'Position', [DRAW_AREA_RATIO_X (1 - DRAW_AREA_RATIO_Y) (1 - DRAW_AREA_RATIO_X) DRAW_AREA_RATIO_Y]);

button_ratio_w = 0.8;
button_ratio_h = 1/10;
base_offset_h = 1/8;
particle_group = uibuttongroup(other_buttons, 'position', [(1 - button_ratio_w)/2, 2/3 + base_offset_h, button_ratio_w, button_ratio_h]);
speed_group = uibuttongroup(other_buttons, 'position', [(1 - button_ratio_w)/2, 1/3 + base_offset_h, button_ratio_w, button_ratio_h]);
diameter_group = uibuttongroup(other_buttons, 'position', [(1 - button_ratio_w)/2, base_offset_h, button_ratio_w, button_ratio_h]);

uicontrol(particle_group, 'string', 'Particles: ', 'style', 'pushbutton', 'units', 'normalized', 'position', [0 0 1/2 1]);
particle_disp = uicontrol(particle_group, 'string', '0', 'style', 'edit', 'units', 'normalized', 'position', [1/2 0 1/2 1]);

uicontrol(speed_group, 'string', 'Speed', 'style', 'pushbutton', 'callback', @speed_cb, 'units', 'normalized', 'position', [0 0 1/2 1]);
speed_disp = uicontrol(speed_group, 'string', '4', 'style', 'edit', 'units', 'normalized', 'position', [1/2 0 1/2 1]);

uicontrol(diameter_group, 'string', 'Diameter', 'style', 'pushbutton', 'callback', @diameter_cb, 'units', 'normalized', 'position', [0 0 1/2 1]);
diameter_disp = uicontrol(diameter_group, 'string', '21', 'style', 'edit', 'units', 'normalized', 'position', [1/2 0 1/2 1]);


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
canvas_size = fliplr(round([width height] ./ 2 .* [DRAW_AREA_RATIO_X DRAW_AREA_RATIO_Y]));
end

% button callbacks
function pb1_cb(~, ~, ~)
global particle_choice
particle_choice = 2;
end

function pb2_cb(~, ~, ~)
global particle_choice
particle_choice = 4;
end

%function pb3_cb(~, ~, ~)
%global particle_choice
%particle_choice = 3;
%end

function reset_cb(~, ~, ~)
global particles particles_matrix
particles = [];
particles_matrix = ones(size(particles_matrix));
end

function stop_cb(h, ~, ~)
global stop_sim
stop_sim = ~stop_sim;
if stop_sim
    h.String = 'Continue';
else
    h.String = 'Stop';
end
end

function speed_cb(~, ~, ~)
global speed
if speed < 32
    speed = speed * 2;
else
    speed = 1;
end
end

function diameter_cb(~, ~, ~)
end