function self = GBMFit( ingbm,X,y,sample_weight )

self=ingbm;

y=Util_ravel(y);

%% if not warmstart - clear the estimator state
if ~self.warm_start
    self=GBM__clear_state(self);
end

%% Check input

[X,y]=Util_check_X_y(X,y);

[n_samples, self.n_features] = size(X);

if isempty(sample_weight)
    sample_weight=ones(1,n_samples);
else
    sample_weight=Util_column_or_1d(sample_weight);
end

[self,y]=GBM__validate_y(self,y);

self=GBM_check_params(self);

%% initialize
if ~GBM_is_initialized(self)
    % init state
    self=GBM__init_state(self);
    self.init_=EstimatorFit(self.init_,X,y,sample_weight);

    % init predictions
    y_pred=EstimatorPredict(self.init_,X);

    begin_at_stage = 1;
else
    if self.n_estimators < Util_shape(self.estimators_,0)
        error('n_estimators must be larger or equal to estimators_.shape')
    end
    begin_at_stage = Util_shape(self.estimators_,0);
    [self,y_pred] = GBM_decision_function(self,X); %可能在这里会有问题
    self=GBM_resize_state(self);
end

%% fit the boosting stages
[self,n_stages]=GBM__fit_stages(self, X, y, y_pred, sample_weight, begin_at_stage);

%% change shape of arrays after fit (early-stopping or additional ests)
if n_stages <= Util_shape(self.estimators_,0)
    self.estimators_ = self.estimators_(1:n_stages,:);
    self.train_score_ = self.train_score_(1:n_stages,:);
    if ~isempty(self.oob_improvement_)
        self.oob_improvement_ = self.oob_improvement_(1:n_stages,:);
    end
end

end
