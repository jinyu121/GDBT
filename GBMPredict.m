function [ decision ] = GBMPredict( inself,X )
self=inself;
if strcmp(self.name,'GradientBoostingClassifier')
    score = GBM_decision_function(self,X);
    decisions = LossFunction_score_to_decision(self.loss_,score);
    decision=self.classes_(decisions,:);
end
if strcmp(self.name,'GradientBoostingClassifier')
    decision=GBM_decision_function(self,X);
    decision=Util_reval(decision);
end
end

