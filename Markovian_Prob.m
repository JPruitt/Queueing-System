function index = Markovian_Prob( array )
%function takes 

U=rand(1);
cdf=0;
for i=1:length(array)

cdf=cdf+array(i);
    if U<(cdf/sum(array))
    index=i;
    break;
    end
end


end

