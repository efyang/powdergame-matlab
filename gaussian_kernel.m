function [ kernel ] = gaussian_kernel( diameter )
%GAUSSIAN_KERNEL Summary of this function goes here
%   Detailed explanation goes here
kernel = gausswin(diameter) * gausswin(diameter)';
end

