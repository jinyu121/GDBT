function self = Estimator( inName,inAlpha )
% if name='Quantile', we use alpha
self.name=inName;
self.alpha=inAlpha;
switch self.name
    % RegressionLossFunction
    case 'HuberLossFunction'
        self.gamma = NaN;
        
    case 'QuantileLossFunction'
        assert( 0 < self.alpha && self.alpha< 1.0);
        self.alpha = alpha;
        self.percentile = alpha * 100.0;
        
    % ClassificationLossFunction
    case 'BinomialDeviance'
        if n_classes ~= 2
            error('BinomialDeviance requires 2 classes');
        end
    case 'MultinomialDeviance'
        if n_classes < 3
            error('MultinomialDeviance requires more than classes');
        end
    case 'ExponentialLoss'
        if n_classes ~= 2
            error('ExponentialLoss requires 2 classes');
        end
end
end

