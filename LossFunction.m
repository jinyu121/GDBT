function self = LossFunction( inname,n_classes , inalpha )
% Attributes
%     ----------
%     K : int
%         The number of regression trees to be induced;
%         1 for regression and binary classification;
%         ``n_classes`` for multi-class classification.
%     """

self.name=inname;
self.K=n_classes;
self.is_multi_class = false;

if strcmp(self.name,'LeastSquaresError') || ...
        strcmp(self.name,'LeastAbsoluteError') || ...
        strcmp(self.name,'HuberLossFunction') || ...
        strcmp(self.name,'QuantileLossFunction')
    if n_classes~=1
        error('n_classes must be 1 for regression');
    end
end

switch self.name
    case 'HuberLossFunction'
        self.alpha=inalpha;
        self.gamma=nan;
    case 'QuantileLossFunction'
        self.alpha=inalpha;
        if (self.alpha<0 || self.alpha>1)
            error('alpha error');
        end
        self.percentile = alpha * 100.0;
    case 'BinomialDeviance'
        if n_classes ~= 2
            error('BinomialDeviance requires 2 classes.');
        end
    case 'MultinomialDeviance'
        self.is_multi_class = true;
        if n_classes < 3
            error('MultinomialDeviance requires more than 2 classes.');
        end
    case 'ExponentialLoss'
        if n_classes ~= 2
            error('ExponentialLoss requires 2 classes.');
        end
end

end
