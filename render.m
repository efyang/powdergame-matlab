function [ rgb_image ] = render( particles_matrix )
%RENDER Summary of this function goes here
%   Detailed explanation goes here
global COLORS
rgb_image = reshape(COLORS(particles_matrix(:), :),...
                    size(particles_matrix, 1),...
                    size(particles_matrix, 2),...
                    3);
end

