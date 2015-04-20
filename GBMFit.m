function self = GDBTFit( inself,X,y,sample_weight )

self=inself;

%% if not warmstart - clear the estimator state
if ~self.warm_start
    self=GBM_clear_state(self);
end

%% Check input
% I assert that your input is right
% So i deleted the followig
% [X,y]=GBM_check_X_y(X, y)

% n_samples, self.n_features = X.shape
[n_samples, self.n_features] = size(X)


% if sample_weight is None:
%    sample_weight = np.ones(n_samples, dtype=np.float32)
% else:
%    sample_weight = column_or_1d(sample_weight, warn=True)
if length(sample_weight)==0
    sample_weight=ones(1,n_samples);
end

self=GBM_check_params(self);

%% initialize
if ~self.is_initialized
    % init state
    self=GBM_init_state(self);
    % fit initial model - FIXME make sample_weight optional
    %     self.init_.fit(X, y, sample_weight)
    % for self.init_ is a class and it is sample, I merged them all
    % and put them into the EstimatorFit
    [self.init_, self]=EstimatorFit(self.init_,self,X,y,simple_weight);
    
    % init predictions
    [self.init_, y_pred]=EstimatorPredict(self.init_,self,X);
    
    begin_at_stage = 0
else
    % # add more estimators to fitted model
    % # invariant: warm_start = True
    
    %     begin_at_stage = self.estimators_.shape[0]
    begin_at_stage = length(self.estimators_.shape)
    [self,y_pred] = GBM_decision_function(self,X)
    self=GBM_resize_state(self)
end

%% fit the boosting stages
[self,n_stages]=GBM_fit_stages(self,X, y, y_pred, sample_weight, begin_at_stage);

%% change shape of arrays after fit (early-stopping or additional ests)
if n_stages ~= length(self.estimators_.shape)
%     if n_stages != self.estimators_.shape[0]:
    self.estimators_ = self.estimators_(1:n_stages);
    self.train_score_ = self.train_score_(1:n_stages);
    if ~isempty(self.oob_improvement_)
        self.oob_improvement_ = self.oob_improvement_(1:n_stages);
    end
end

end


