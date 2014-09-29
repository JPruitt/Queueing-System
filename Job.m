classdef Job<handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    number;
    task;
    time;
    rate;
        
    end
    
    methods
        function result=Job(number,task,time,rate)
        result.number=number;
        result.time=time;
        result.task=task;
        result.rate=rate;
        
        
        end
    end
    
end

