function self = EstimatorFit( inself ,X, y, sample_weight )

self=inself;

switch self.name
    case 'QuantileEstimator'
        if isempty(sample_weight)
            self.quantile = Stats_scoreatpercentile(y, self.alpha)
        else
            self.quantile = Stats_weighted_percentile(self,y, sample_weight, self.alpha * 100.0);
        end
    case 'MeanEstimator'
        if isempty(sample_weight)
            self.mean = mean(y);
        else
            self.mean=mean(y.*sample_weight);
        end
    case 'Estimator'
        if isempty(sample_weight)
            pos = sum(y);
            neg =Util_shape0( y)- pos;
        else
        pos = sum(sample_weight * y);
        neg = sum(sample_weight * (1 - y));
        end
        if neg == 0 || pos == 0
            error('y contains non binary labels.')
        end
        self.prior = self.scale * log(pos / neg);
        
    case 'ScaledLogOddsEstimator'
        self.scale = 0.5
    case 'PriorProbabilityEstimator'
        if isempty(sample_weight)
            sample_weight = np.ones_like(y, dtype=np.float64);
        end
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


