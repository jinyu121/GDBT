function [ res ] = Util_logsumexp( a,axls,b )
if isempty(b)
    b=Util_ones_like(a(:,axls));
end

if isnan(axls)
    res=log(sum(b.*exp(a(:,axls))));
else
    axls=axls+1;
    res=log(sum(b.*exp(a(:,axls)),axls));
end



end

