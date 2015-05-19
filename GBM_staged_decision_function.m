function [ output_args ] = GBM_staged_decision_function( inself, )
self=inself;
score = GBM__init_decision_function(self,X);

for i=1:1:Util_shape(self.estimators_,0)
%     predict_stage(self.estimators_, i, X, self.learning_rate, score)
%     yield score.copy()
end

end

