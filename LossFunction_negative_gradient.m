function [ ouEstimator ] = Loss_negative_gradient( self, y, pred )
self=inLossFunction;
switch self.name
    case 'LeastSquaresError'
        ouEstimator=y - Util_reval(pred);
    case 'LeastAbsoluteError'
        %         """1.0 if y - pred > 0.0 else -1.0"""
        pred = Util_reval(pred);
        ouEstimator =2.0 * (y - pred > 0.0) - 1.0;
    case 'HuberLossFunction'
        pred = Util_reval(pred);
        diff = y - pred;
        if isempty(sample_weight)
            gamma = stats.scoreatpercentile(np.abs(diff), self.alpha * 100);
        else
            gamma = _weighted_percentile(np.abs(diff), sample_weight, self.alpha * 100);
        end
        gamma_mask = np.abs(diff) <= gamma;
        residual = np.zeros((y.shape[0],), dtype=np.float64);
        residual[gamma_mask] = diff[gamma_mask];
        residual[~gamma_mask] = gamma * np.sign(diff[~gamma_mask]);
        self.gamma = gamma;
        ouEstimator= residual;
    case 'QuantileLossFunction'
        ouEstimator=Estimeter('QuantileEstimator',self.alpha);
    case 'BinomialDeviance'
        ouEstimator=Estimeter('LogOddsEstimator',0);
    case 'MultinomialDeviance'
        ouEstimator=Estimeter('PriorProbabilityEstimator',0);
    case 'ExponentialLoss'
        ouEstimator=Estimeter('ScaledLogOddsEstimator',0);
end
end



