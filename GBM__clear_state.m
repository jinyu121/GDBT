function self=GBM__clear_state(ingbm)
self=ingbm;
%% Clear the state of the gradient boosting model.
self.estimators_=cell(0,0);
self.train_score_=[];
self.oob_improvement_=[];
self.init_=[];
end
