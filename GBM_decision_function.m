function [self,score]=GBM_decision_function(ingbm,X)
self=ingbm;

score=GBM__decision_function(self,X);
if (Util_shape(score,1)==1)
    score=Util_ravel(score);
end

end
