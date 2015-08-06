function [ score ] = GBM__decision_function( ingbm,X )
self=ingbm;

score=GBM__init_decision_function(self,X);
score=GBM_predict_stages(self,self.estimators_, X, self.learning_rate, score);

end
