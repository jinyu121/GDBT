function self=GBM_init_state(inself)
self=inself;
if length(self.init)==0
    % Todo
    % self.init_ = self.loss_.init_estimator();
else
    % Todo
    % self.init_ = 'ZeroEstimator';
end
self.estimators_=cell(self.n_estimators, self.loss_.K);
self.train_score_=zeros(1,self.n_estimators);
% do oob?
if self.subsample < 1.0
    self.oob_improvement_ = zeros(1,self.n_estimators)
end
end
