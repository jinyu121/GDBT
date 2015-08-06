function y = EstimatorPredict( inEstimator,X )
self=inEstimator;

size_x=Util_shape(X,0);
y=ones(size_x,1);

switch self.name
    case 'QuantileEstimator'
        y=y.*self.quantile;

    case 'MeanEstimator'
        y=y.*self.mean;

    case 'LogOddsEstimator'
        y=y.*self.prior;

    case 'ScaledLogOddsEstimator'
        y=y.*self.prior;

    case 'PriorProbabilityEstimator'
        y = ones(Util_shape(X,0), Util_shape(self.priors,0))*self.priors;

    case 'ZeroEstimator'
        y=y.*0;

end

end
