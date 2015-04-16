function self=GBM_clear_state(inself)
%% Clear the state of the gradient boosting model.
self=inself;
self.estimators_=cell(1,1);
self.train_score_=[];
self.oob_improvement_=[];
self.init_=[];
end