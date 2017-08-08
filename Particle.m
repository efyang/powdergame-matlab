classdef Particle
    %PARTICLE 
    %   Detailed explanation goes here
    properties
        fall_velocity % pixels/second
        color % [8bit 8bit 8bit]
    end
    
    enumeration
        Oil     (1.5, uint8([156, 70, 13]))
        Water   (1.5, uint8([0, 0, 255]))
        None    (nan, uint8([0, 0, 0]))
    end

    methods
        % constructor
        function p = Particle(fall_vel, color)
            p.fall_velocity = fall_vel;
            p.color = color;
        end
        
        function is = is_none(obj)
            is = obj == Particle.None;
        end
        
        function interact_convolution()
        end
    end
    
end

