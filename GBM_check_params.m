function self=GBM_check_params(inself)
self=inself;
%% Check validity of parameters and raise ValueError if not valid.
% I assert your input data is right
%%%%%%%%%% NOTICE: %%%%%%%%%%
% and the self.loss is a Cell

if self.n_estimators <= 0
    error('n_estimators must be greater than 0');
end

if self.learning_rate <= 0.0
    error('learning_rate must be greater than 0');
end

if strcmp(self.loss,'deviance')
    if length(self.classes_)>2
        self.loss_=LossFunction('MultinomialDeviance',self.n_classes_,NaN);
    else
        self.loss_=LossFunction('BinomialDeviance',self.n_classes_,NaN);
    end
else
    switch self.loss
        case 'ls'
            self.loss_=LossFunction('LeastSquaresError',self.n_classes_,NaN);
        case 'lad'
            self.loss_=LossFunction('LeastAbsoluteError',self.n_classes_,NaN);
        case 'huber'
            self.loss_.loss_=LossFunction('HuberLossFunction',self.n_classes_, self.alpha);
        case 'quantile'
            self.loss_=LossFunction('QuantileLossFunction',self.n_classes_, self.alpha);
        case 'exponential'
            self.loss_=LossFunction('ExponentialLoss',self.n_classes_,NaN);
    end
end

if ~(0.0 < self.subsample && self.subsample<= 1.0)
    error('subsample must be in (0,1]');
end

if ~(0.0 < self.alpha && self.alpha < 1.0)
    error('alpha must be in (0.0, 1.0)')
end

if isempty(self.max_features)
    max_features = self.n_features;
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
elseif isnan(self.max_features)
    max_features = self.n_features;
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
