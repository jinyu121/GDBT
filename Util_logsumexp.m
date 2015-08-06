function [ res ] = Util_logsumexp( a,axis )

res=exp(a);
if isnan(axis) || isempty(axis)
    res=sum(Util_real(res));
else
    res=sum(res,axis+1);
end
res=Util_ravel(log(res));
end
