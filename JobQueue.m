classdef JobQueue < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    list;
    length;
    last_job;
    parallel;
    rate_model;
    %tasks per job is variable c
    c;
    end
    
    methods
        function queue=JobQueue(parallel,c,rate_model)
        if nargin~=3
        error('must input parallel parameter and task number')
        end
        queue.list=List();
        queue.length=queue.list.length;
        queue.last_job=0;
        queue.parallel=parallel;
        queue.rate_model=rate_model;
        queue.c=c;
        end
        
        function addJob(jobqueue,time)
        if (isscalar(jobqueue.rate_model) )
        addJob2(jobqueue,time);
        else
            addJob1(jobqueue,time);
            
        end
        end
        
        
        
        
        function addJob1(jobqueue,time)
       
        next_job=jobqueue.last_job+1;    
        
            for m=1:jobqueue.c
            rate_index=mod(m,jobqueue.rate_model.length);    
            if(rate_index==0)
            rate_index=jobqueue.rate_model.length;
            end
            rate=jobqueue.rate_model(rate_index);
            temp=Job(next_job,m,time,rate);
            temp=Node(temp);
            jobqueue.list.add(temp);
            end
        jobqueue.length=jobqueue.list.length;
        jobqueue.last_job=jobqueue.last_job+1;
        end
        
        
        function addJob2(jobqueue,time)
       
        next_job=jobqueue.last_job+1;    
        
            for m=1:jobqueue.c
            temp=Job(next_job,m,time,jobqueue.rate_model);
            temp=Node(temp);
            jobqueue.list.add(temp);
            end
        jobqueue.length=jobqueue.list.length;
        jobqueue.last_job=jobqueue.last_job+1;
        end
        
        function result=dequeue(jobqueue)
            result=List();
           if jobqueue.parallel 
           temp_n=1;
           else
           temp_n=jobqueue.c;
               
           end
           
           for i=1:temp_n
           temp=jobqueue.list.pop();
           result.add(temp);
           jobqueue.length=jobqueue.list.length;
           end
        
        
        end
        
        
        
        
        
    end
    
    
    
    
end

