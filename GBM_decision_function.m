function [self,score]=GBM_decision_function(inself,X)
self=inself;
% I merged all the decision function to here
score=GBM__decision_function(self,X);
if (Util_shape(score,1)==1)
    score=Util_reval(score);
end

end
