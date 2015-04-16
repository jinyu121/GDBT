function self=GBM_check_params(inself)
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
