function y = EstimatorPredict( inself,X )
self=inself;

[size_x,size_y]=size(X);
y=ones(size_x,1);

switch self.name
    case 'QuantileEstimator'
        
        y=y.*self.quantile;
    case 'MeanEstimator'
        
        y=y.*self.mean;
    case 'Estimator'
        
        y=y.*self.prior;
    case 'ZeroEstimator'
        y=y*0
        
    case 'PriorProbabilityEstimator'
        
        y=y.*self.priors;
        
        
        
end
end