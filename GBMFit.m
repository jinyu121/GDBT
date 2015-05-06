function self = GBMFit( inself,X,y,sample_weight )

self=inself;

%% if not warmstart - clear the estimator state
if ~self.warm_start
    self=GBM__clear_state(self);
end

%% Check input
% I assert that your input is right

[n_samples, self.n_features] = size(X);


if isempty(sample_weight)
    sample_weight=ones(1,n_samples);
else
    sample_weight=Util_reval(sample_weight);
end

[self,y]=GBM__validate_y(self,y);

self=GBM_check_params(self);

%% initialize
if ~GBM_is_initialized(self)
    % init state
    self=GBM__init_state(self);
    [self.init_, self]=EstimatorFit(self.init_,self,X,y,simple_weight);
    
    % init predictions
    [self.init_, y_pred]=EstimatorPredict(self.init_,self,X);
    
    begin_at_stage = 0;
else
    if self.n_estimators < Util_shape0(self.estimators_)
        error('n_estimators must be larger or equal to estimators_.shape')
    end
    begin_at_stage = Util_shape0(self.estimators_);
    [self,y_pred] = GBM_decision_function(self,X);
    self=GBM_resize_state(self);
end

%% fit the boosting stages
[self,n_stages]=GBM__fit_stages(self, X, y, y_pred, sample_weight, begin_at_stage);

%% change shape of arrays after fit (early-stopping or additional ests)
if n_stages ~= Util_shape0(self.estimators_)
    self.estimators_ = self.estimators_(1:n_stages,:);
    self.train_score_ = self.train_score_(1:n_stages,:);
    if ~isempty(self.oob_improvement_)
        self.oob_improvement_ = self.oob_improvement_(1:n_stages,:);
    end
end

end


