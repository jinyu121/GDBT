function [ proba ] = GBMPredictProba( inself,X )
self=inself;
if strcmp(self.name,'GradientBoostingClassifier')
    score=GBM_decision_function(self,X);
    try
        proba=LossFunction__score_to_proba(self.loss_,score);
    catch
        error('Some error happened');
    end
    
end
end

