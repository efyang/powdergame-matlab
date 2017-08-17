function [ rgb_image ] = render( particles_matrix )
%RENDER takes in a particles_matrix and converts its to a 3d pixel matrix
global COLORS
rgb_image = reshape(COLORS(particles_matrix(:), :),...
                    size(particles_matrix, 1),...
                    size(particles_matrix, 2),...
                    3);
end

