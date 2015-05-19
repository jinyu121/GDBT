function [ score ] = GBM__decision_function( inself,X )
self=inself;
score=GBM__init_decision_function(self,X);

GBM_predict_stages(self.estimators_, X, self.learning_rate, score);
end

