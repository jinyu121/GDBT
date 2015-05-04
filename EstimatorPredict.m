function y = EstimatorPredict( inself,X )
self=inself;

size_x=Util_shape0(X);
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
        y = ones(Util_shape0(X), Util_shape0(self.priors)).*self.priors;
        
    case 'ZeroEstimator'
        y=y.*0;
        
end

end