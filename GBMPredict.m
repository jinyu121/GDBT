function [ decision ] = GBMPredict( ingbm,X )
self=ingbm;
if strcmpi(self.name,'GradientBoostingClassifier')
    [self,score] = GBM_decision_function(self,X);
    decisions = LossFunction__score_to_decision(self.loss_,score);
    decision=self.classes_(:,decisions);
    return;
end

if strcmpi(self.name,'GradientBoostingRegressor')
    decision=Util_ravel(GBM_decision_function(self,X));
    return;
end

end
