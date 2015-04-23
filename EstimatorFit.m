function self = EstimatorFit( inself ,X, y, sample_weight )

self=inself;

switch self.name
    case 'QuantileEstimator'
        self.quantile = Stats_Quantitle_weighted_percentile(self,y, sample_weight, self.alpha * 100.0);
    case 'MeanEstimator'
        self.mean=mean(y.*sample_weight);
    case 'Estimator'
        self.scale = 1.0;
        pos = sum(sample_weight * y);
        neg = sum(sample_weight * (1 - y));
        if neg == 0 || pos == 0
            error('y contains non binary labels.')
        end
        self.prior = self.scale * log(pos / neg);
        
    case 'ScaledLogOddsEstimator'
        self.scale = 0.5
    case 'PriorProbabilityEstimator'
        % Todo: T'm not sure if this is right...
        class_counts=histc(y.*sample_weight);
        self.priors = class_counts / sum(class_counts);
    case 'ZeroEstimator'
        if isint32(y(1))
            % classification
            self.n_classes=size(unique(y));
            self.n_classes=self.n_classes(2);
            if self.n_classes == 2
                self.n_classes = 1;
            end
        else
            % regression
            self.n_classes = 1;
        end
end
end


