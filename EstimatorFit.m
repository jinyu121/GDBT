function self = EstimatorFit( self, X, y, sample_weight )
switch self.name
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
    case 'PriorProbabilityEstimator'
        sample_weight=ones(1,length(y));
        % Todo: T'm not sure if this is right...
        class_counts=histc(y.*sample_weight);
        self.priors = class_counts / sum(class_counts);
    case 'MeanEstimator'
        self.mean=mean(y.*sample_weight);
    case 'Estimator'
        scale = 1.0;
        pos = sum(sample_weight * y);
        neg = sum(sample_weight * (1 - y));
        self.prior = self.scale * log(pos / neg);
    case 'QuantileEstimator'
        self.quantile = QuantileEstimator_weighted_percentile(y, sample_weight, self.alpha * 100.0);
end
end
function ans=QuantileEstimator_weighted_percentile(array, sample_weight, percentile)
% The default value of percentile is 50

% 改写这里了
%     """Compute the weighted ``percentile`` of ``array`` with ``sample_weight``. """
%     sorted_idx = np.argsort(array)
% 
%     # Find index of median prediction for each sample
%     weight_cdf = sample_weight[sorted_idx].cumsum()
%     percentile_idx = np.searchsorted(
%         weight_cdf, (percentile / 100.) * weight_cdf[-1])
%     return array[sorted_idx[percentile_idx]]



end

