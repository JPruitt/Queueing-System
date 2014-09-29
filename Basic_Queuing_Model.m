%Chaitanya Kanitkar
%Columbia University
%Simple Model for stochastic queuing system
%9/1/2014


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameters


%number of Servers
K=20;


%job arrival rate
r=1;


%splitting queue = true
splitting=true;


%number of tasks per job
tasks=6;


%task rate model is a multiplying vector that represents rate distribution of
%tasks in job

t_v=5;



%trials
trials=1;

%SETUP
%%%setup jobqueue
jobqueue=JobQueue(splitting,tasks,t_v);

%%% setup empty jobs list
empty_servers=List();
for p=1:K

empty_servers.add(Node(p));
end

%array of lists for each server
servers(1,K)=List();



for i=1:trials

  
%SETUP%



%completed jobs map
completed_jobs=containers.Map('KeyType','double','ValueType','double');

%next_event rate
next_event=r;

%current time
t=0;
jobs_completed=0;
total_time=0;
%next event array
next_event_array=horzcat(r,zeros(1,K));

t=t+exp_gen(next_event);

next_event_index=Markovian_Prob(next_event_array);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

while (true)

    if (next_event_index==1)
        jobqueue.addJob(t);
        while(empty_servers.length~=0&&jobqueue.length~=0)
            server_index=empty_servers.pop().data;
            temp=jobqueue.dequeue();
            servers(server_index).addList(temp);
            next_event_array(server_index+1)=temp.head.data.rate;
        end    
    else
        server_index=next_event_index-1;
    
        completed_job_node=servers(server_index).pop();
        if(isKey(completed_jobs,completed_job_node.data.number))
            completed_jobs(completed_job_node.data.number)= completed_jobs(completed_job_node.data.number)+1;
        else
            completed_jobs(completed_job_node.data.number)=1;
        end
        
        if(completed_jobs(completed_job_node.data.number)==tasks)
        remove(completed_jobs,completed_job_node.data.number);
        jobs_completed=jobs_completed+1;
        total_time=total_time+t-completed_job_node.data.time;
        end
        
        
    
        if(servers(server_index).length==0)
            if(jobqueue.length~=0)
            temp=jobqueue.dequeue();
            servers(server_index).addList(temp);
            next_event_array(server_index+1)=temp.head.data.rate;
            else
            next_event_array(server_index+1)=0;
            empty_servers.add(Node(server_index));
            end
        else
        next_event_array(server_index+1)=servers(server_index).head.data.rate;    
        end
    
    end
    
    
    if(jobqueue.length==0&&empty_servers.length==K)
    break;
    end
    
    
    next_event=sum(next_event_array);
    t=t+exp_gen(next_event);
    next_event_index=Markovian_Prob(next_event_array);
    
    
    
end





end
