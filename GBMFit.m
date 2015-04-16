function self = GDBTFit( inself,X,y,sample_weight )

self=inself;

%% if not warmstart - clear the estimator state
if ~self.warm_start
    self=GBM_clear_state(self);
end

%% Check input
% I assert that your input is right
% [X,y]=GBM_check_X_y(X, y)
[n_samples, self.n_features] = size(X)
if sample_weight==[]
    sample_weight=ones(1,n_samples);
end

self=inner_check_params(self);

if ~self.is_initialized
    % init state
    self=GBM_init_state(self);
    % fit initial model - FIXME make sample_weight optional
    %     Todo:
    %self=EstimatorFit(X,,y,simple_weight);
    
    % init predictions
    y_pred=EstimatorPredict(X);
    
    begin_at_stage = 0
else
    begin_at_stage = length(self.estimators_.shape)
    [self,y_pred] = inner_decision_function(self,X)
    self=GBM_resize_state(self)
end

% fit the boosting stages
n_stages=GBM_fit_stages(self,X, y, y_pred, sample_weight, random_state,begin_at_stage);

% change shape of arrays after fit (early-stopping or additional ests)
if n_stages ~= length(self.estimators_.shape)
    self.estimators_ = self.estimators_(:n_stages);
    self.train_score_ = self.train_score_(:n_stages);
    try
        self.oob_improvement_ = self.oob_improvement_(:n_stages);
    catch
    end
end

end


