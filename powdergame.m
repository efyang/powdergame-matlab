% clear everything out
close all;
clear all;
clc;
warning('off', 'all');

addpath('gui');
[fig, canvas, canvas_size] = gui(700, 900, 'Powder Game', []);
global particles_matrix particles mouse_down mouse_coords program_continue
global particle_choice
program_continue = true;
mouse_down = false;
mouse_coords = [1 1];
particles_matrix = ones(canvas_size);
particles = [];
particle_choice = 2;

% 1 is none
% 2 is water
% 3 is oil
% 4 is sand
global COLORS
COLORS = uint8([0 0 0;...
    0 0 255;...
    156 70 13;...
    194 178 128]);

image_handle = imshow(render(particles_matrix));

% setup mouse handlers
set(fig, 'WindowButtonDownFcn', @mouse_down_handler);
set(fig, 'WindowButtonUpFcn', @mouse_up_handler);
set(fig, 'WindowButtonMotionFcn', @mouse_motion_handler);

set(fig, 'DeleteFcn', @fig_delete_handler);

MOUSEDRAG_TIMER_UPDATE_TIME = 1/60;
create_update_timer(@update_handler, MOUSEDRAG_TIMER_UPDATE_TIME);

DRAW_TIMER_UPDATE_TIME = 1/120;
while program_continue
    image_handle.CData = render(particles_matrix);
    drawnow;
    pause(DRAW_TIMER_UPDATE_TIME);
end