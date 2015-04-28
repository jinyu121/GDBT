function self=GBM_init_state(inself)
self=inself;
if isempty(self.init)
    self.init_ = LossFunction_init_estimator(self.loss);
elseif ischar(self.init)
    self.init_ = LossFunction('ZeroEstimator',nan,nan);
else
    self.init_=self.init;
end
self.estimators_=cell(self.n_estimators, self.loss_.K);
self.train_score_=zeros(1,self.n_estimators);
% do oob?
if self.subsample < 1.0
    self.oob_improvement_ = zeros(1,self.n_estimators);
end
end
