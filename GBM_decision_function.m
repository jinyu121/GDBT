function [self,y]=GBM_decision_function(inself,X)
self=inself;
% I merged all the decision function to here
score=GBM__decision_function(self,X);
ScoreShape=size(score);
if (ScoreShape(2)==1)
    y=Util_reval(score);
else
    y=score;
end

end
