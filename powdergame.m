% clear everything out
close all;
clear all;
clc;

addpath('gui');
[fig, canvas, canvas_size] = gui(500, 700, 'Powder Game', []);
global particles_matrix particles mouse_down mouse_coords program_continue
program_continue = true;
mouse_down = false;
mouse_coords = [0 0]
particles_matrix = repmat(struct(Particle.None), canvas_size);
particles = [];

image_handle = imshow(render(particles_matrix));

% setup mouse handlers
set(fig, 'WindowButtonDownFcn', @mouse_down_handler);
set(fig, 'WindowButtonUpFcn', @mouse_up_handler);
set(fig, 'WindowButtonMotionFcn', @mouse_motion_handler);

set(fig, 'DeleteFcn', @fig_delete_handler);

MOUSEDRAG_TIMER_UPDATE_TIME = 0.03;
create_update_timer(@update_handler, MOUSEDRAG_TIMER_UPDATE_TIME);

