% clear everything out
close all;
clear all;
clc;
warning('off', 'all');


global stop_sim
stop_sim = false;
addpath('gui');
[fig, canvas, canvas_size] = gui(500, 600, 'Powder Game');
global particles_matrix particles mouse_down mouse_coords program_continue
global particle_choice diameter
program_continue = true;
mouse_down = false;
mouse_coords = canvas_size ./ 2;
particles_matrix = ones(canvas_size);
particles = [];
particle_choice = 4;
diameter = 21;
% 1 is none
% 2 is water
% 3 is oil
% 4 is sand
global COLORS
COLORS = uint8([0 0 0;...
    0 0 255;...
    156 70 13;...
    194 178 128]);
global image_handle
image_handle = imshow(render(particles_matrix));

% setup mouse handlers
set(fig, 'WindowButtonDownFcn', @mouse_down_handler);
set(fig, 'WindowButtonUpFcn', @mouse_up_handler);
set(fig, 'WindowButtonMotionFcn', @mouse_motion_handler);

set(fig, 'DeleteFcn', @fig_delete_handler);

UPDATE_TIME = 1/60;
create_update_timer(@update_handler, UPDATE_TIME);