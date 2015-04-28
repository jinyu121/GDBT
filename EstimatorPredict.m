function y = EstimatorPredict( inself,X )
self=inself;

size_x=Util_shape0(X);
y=ones(size_x,1);

switch self.name
    case 'QuantileEstimator'
        y=y.*self.quantile;
        
    case 'MeanEstimator'
        y=y.*self.mean;
        
    case 'Estimator'
        y=y.*self.prior;
        
    case 'ZeroEstimator'
        y=y.*0;
        
    case 'PriorProbabilityEstimator'
        %         可能不对
        y = ones(Util_shape0(X), Util_shape0(self.priors.shape)).*self.priors;
end
end