function self = EstimatorFit( inEstimator ,X, y, sample_weight )

self=inEstimator;

switch self.name
    case 'QuantileEstimator'
        if isempty(sample_weight)
            self.quantile = Stats_scoreatpercentile(y, self.alpha*100.0);
        else
            self.quantile = Stats_weighted_percentile(self,y, sample_weight, self.alpha * 100.0);
        end

    case 'MeanEstimator'
        if isempty(sample_weight)
            self.mean = mean(y);
        else
            self.mean=mean(y.*sample_weight);
        end

    case 'LogOddsEstimator'
        % For fixing the difference between Matlab and Python
        if max(y)==2
            y=y-1;
        end
        if isempty(sample_weight)
            pos = sum(y);
            neg =Util_shape(y,0)- pos;
        else
            pos = sum(sample_weight .* y);
            neg = sum(sample_weight .* (1-y));
        end
        if neg == 0 || pos == 0
            error('y contains non binary labels.')
        end
        self.prior = self.scale * log(pos / neg);

    case 'ScaledLogOddsEstimator'
        % For fixing the difference between Matlab and Python
        if max(y)==2
            y=y-1;
        end
        if isempty(sample_weight)
            pos = sum(y);
            neg =Util_shape( y,0)- pos;
        else
            pos = sum(sample_weight .* y);
            neg = sum(sample_weight .* (1 - y));
        end
        if neg == 0 || pos == 0
            error('y contains non binary labels.')
        end
        self.prior = self.scale * log(pos / neg);

    case 'PriorProbabilityEstimator'
        if isempty(sample_weight)
            sample_weight = Util_ones_like(y);
        end
        class_counts=histc(y.*sample_weight,1:1:max(y.*sample_weight));
        self.priors = class_counts / sum(class_counts);

    case 'ZeroEstimator'
        if isint32(y(1))
            % classification
            self.n_classes=Util_shape(unique(y),0);
            if self.n_classes == 2
                self.n_classes = 1;
            end
        else
            % regression
            self.n_classes = 1;
        end
end
end
