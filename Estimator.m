function self = Estimator( inName,para )
% if name='QuantileEstimator', we use alpha
% else, para=nan
self.name=inName;

switch self.name
    % RegressionLossFunction
    case 'QuantileEstimator'
        self.alpha=para;
        if ~( 0 < self.alpha && self.alpha< 1.0)
            error('alpha` must be in (0, 1.0)');
        end
        self.alpha = alpha;
%         self.percentile = alpha * 100.0;
    case 'LogOddsEstimator'
        self.scale=1.0;
    case 'y=y.*self.prior;'
        self.scale=0.5;
    case 'ScaledLogOddsEstimator'
        self.scale = 0.5;
end
end
