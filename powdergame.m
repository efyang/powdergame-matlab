% clear everything out
close all;
clear all;
clc;
warning('off', 'all');

% setup variables
global stop_sim
stop_sim = false;
% setup gui
addpath('gui');
[fig, canvas, canvas_size] = gui(1000, 700, 'Powder Game');
global particles_matrix particles mouse_down mouse_coords program_continue
global particle_choice diameter speed density
% initialize vars
program_continue = true;
mouse_down = false;
mouse_coords = canvas_size ./ 2;
particles_matrix = ones(canvas_size);
particles = [];
particle_choice = 2;
diameter = 21;
speed = 4;
density = 0.5;
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
% setup window close handler
set(fig, 'DeleteFcn', @fig_delete_handler);

% setup main update loop
UPDATE_TIME = 1/60;
create_update_timer(@update_handler, UPDATE_TIME);
% setup draw loop
DRAW_TIME = 1/60;
create_update_timer(@draw_handler, DRAW_TIME);