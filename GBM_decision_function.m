function [self,y]=GBM_decision_function(inself,X)
self=inself;
% I merged all the decision function to here
score=EstimatorPredict(X);
y=score;
end
