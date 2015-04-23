function self=GBM_check_params(inself)
self=inself;
%% Check validity of parameters and raise ValueError if not valid.
% I assert your input data is right
%%%%%%%%%% NOTICE: %%%%%%%%%%
% self.loss are classes. So, merge them like Estimaor?
% and the self.loss is a Cell

if strcmp(self.loss,'deviance')
    %     if len(self.classes_) > 2
    if length(self.classes_)>2
        % Todo
        self.loss='MultinomialDeviance';
    else
        % Todo
        self.loss='BinomialDeviance';
    end
else
    switch self.loss
        case 'ls'
            self.loss='LeastSquaresError';
        case 'lad'
            self.loss='LeastAbsoluteError';
        case 'huber'
            self.loss='HuberLossFunction';
        case 'quantile'
            self.loss='QuantileLossFunction';
        case 'exponential'
            self.loss='ExponentialLoss';
    end
end

if strcmp(self.loss,'HuberLossFunction') || strcmp(self.loss,'QuantileLossFunction')
    % Todo
    self.loss_=Loss(self.loss,self.n_classes_, self.alpha);
else
    % Todo
    self.loss_=Loss(self.loss,self.n_classes_,NaN);
end

if isempty(self.max_features)
    max_features = self.n_features
elseif strcmp(self.max_features,'auto')
    if self.n_classes_ > 1
        % # if is_classification
        max_features = max(1, int32(sqrt(self.n_features)));
    else
        % # is regression
        max_features = self.n_features;
    end
elseif strcmp(self.max_features , 'sqrt')
    max_features = max(1, int32(sqrt(self.n_features)));
elseif strcmp(self.max_features , 'log2')
    max_features = max(1, int32(log2(self.n_features)));
elseif self.max_features>1
    max_features = self.max_features;
else
    if 0<self.max_features && self.max_features <= 1
        max_features = max(int32(self.max_features * self.n_features), 1);
    else
        error('max_features must be in (0, n_features]');
    end
    
end

self.max_features_ = max_features;
end
