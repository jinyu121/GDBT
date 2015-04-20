function self=GBM_clear_state(inself)
self=inself;
%% Clear the state of the gradient boosting model.
self.estimators_=cell(1,1);
self.train_score_=[];
self.oob_improvement_=[];
self.init_=[];
end