classdef List < handle
    %basic LinkedList implementation
    
    properties
    head;
    last;
    length;
    end
    
    methods
        function list=List()
        list.head=[];
        list.last=[];
        list.length=0;
        end
        
        function add(list,node)
        if list.length==0
        list.head=node;
        list.last=node;
        else
        list.last.next=node;
        list.last=node;
        end
        list.length=list.length+1;
        end
        
        function node=pop(list)
            if list.length==0
            error('popped empty list');
            else
            node=list.head;
            list.head=node.next;
            node.next=[];
            list.length=list.length-1;
            end
            if (list.length==0)
            list.last=[];
            end
        end
        
        function addList(list,nlist)
        
        if isempty(nlist)
        error('adding empty list');
        elseif(list.length==0)
        list.head=nlist.head;
        list.last=nlist.last;
        list.length=nlist.length;
        else    
        list.last.next=nlist.head;
        list.last=nlist.last;
        list.length=list.length+nlist.length;
        end
        end
    
    
end
end
