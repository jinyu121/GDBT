function [ res ] = Util_logsumexp( a,axls,b )

if isnan(axls)
    res=log(sum(b*exp(a)));
else
    res=log(sum(b*exp(a(:,axls))));
end
end

