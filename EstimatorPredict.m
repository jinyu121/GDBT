function y = EstimatorPredict( inself,X )
self=inself;

switch self.name
    case 'ZeroEstimator'
        [size_x,size_y]=size(X);
        y=zeros(size_x,self.n_classes);
        
    case 'PriorProbabilityEstimator'
        [size_x,size_y]=size(X);
        y=ones(size_x,self.n_classes);
        y=y.*self.priors;
    case 'MeanEstimator'
        self.mean=mean(y.*sample_weight);
    case 'Estimator'
        [size_x,size_y]=size(X);
        y=ones(size_x,1);
        y=y.*self.prior;
    case 'QuantileEstimator'
        [size_x,size_y]=size(X);
        y=ones(size_x,1);
        y=y.*self.quantile;
end
end