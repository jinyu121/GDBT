function self = GDBTFit( inself,X,y,sample_weight )

self=inself;

%% if not warmstart - clear the estimator state
if ~self.warm_start
    self=inner_clear_state(self);
end

%% Check input
% I assert that your input is right
% [X,y]=inner_check_X_y(X, y)
[n_samples, self.n_features] = size(X)
if sample_weight==[]
    sample_weight=ones(1,n_samples);
end

self=inner_check_params(self);

if ~self.is_initialized
    % init state
    self=inner_init_state(self);
    % fit initial model - FIXME make sample_weight optional
    % init predictions
    
    begin_at_stage = 0
else
    
end


end

function self=inner_clear_state(inself)
%% Clear the state of the gradient boosting model.
self=inself;
self.estimators_=cell(1,1);
self.train_score_=[];
self.oob_improvement_=[];
self.init_=[];
end

function self,y=inner_validate_y(inself,inY)
%% Reformat y and calculate the number of the classes
y=inY;
self=inself;
[self.classes_,unuse,y]=unique(y);
self.n_classes_=length(self.classes_);
end

function self=inner_check_params(inself)
%% Check validity of parameters and raise ValueError if not valid.
% I assert your input data is right
self=inself;
%%%%%%%%%% NOTICE: %%%%%%%%%%
% self.loss are classes.
% these classes MUST be write!!!
% and the self.loss is a Cell

if strcmp(self.loss,'deviance')
    if length(self.classes_)>2
        % Todo
        self.loss='MultinomialDeviance';
    else
        % Todo
        self.loss='BinomialDeviance';
    end
else
end

if strcmp(self.loss,'huber') || strcmp(self.loss,'quantile')
    % Todo
    self.loss_='loss_class(self.n_classes_, self.alpha)';
else
    % Todo
    self.loss_='loss_class(self.n_classes_)';
end

if strcmp(self.max_features,'auto')
    if self.n_classes_ > 1
        max_features = max(1, int32(sqrt(self.n_features)));
    else
        max_features = self.n_features;
    end
elseif strcmp(self.max_features , 'sqrt')
    max_features = max(1, int32(sqrt(self.n_features)));
elseif strcmp(self.max_features , 'log2')
    max_features = max(1, int32(log2(self.n_features)));
elseif self.max_features>1
    max_features = self.max_features;
elseif 0<self.max_features && self.max_features <= 1
    max_features = max(int32(self.max_features * self.n_features), 1);
else
    error('max_features must be in (0, n_features]');
end
self.max_features_ = max_features;
end

function self=inner_init_state(inself)
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

