function [ ouEstimator ] = LossFunction_negative_gradient( inLossFunction, y, pred,k,sample_weight )
self=inLossFunction;

switch self.name
    case 'LeastSquaresError'
        ouEstimator=y - Util_ravel(pred);
    case 'LeastAbsoluteError'
        pred = Util_ravel(pred);
        ouEstimator =2.0 * (y - pred .* (pred > 0.0)) - 1.0;
    case 'HuberLossFunction'
        pred = Util_ravel(pred);
        diff = y - pred;
        if isempty(sample_weight)
            gamma = Stats_scoreatpercentile(abs(diff), self.alpha*100);
        else
            gamma = Stats_weighted_percentile(abs(diff), sample_weight, self.alpha );
        end
        gamma_mask = abs(diff) <= gamma;
        residual = zeros(1,Util_shape(y,0));
        residual(gamma_mask) = diff(gamma_mask);
        residual(~gamma_mask) = gamma .* sign(diff(~gamma_mask));
        self.gamma = gamma;
        ouEstimator= residual;
    case 'QuantileLossFunction'
        alpha = self.alpha;
        pred = Util_ravel(pred);
        mask = y > pred;
        ouEstimator=(alpha .* mask) - ((1.0 - alpha) .* ~mask);
    case 'BinomialDeviance'
        ouEstimator=y-Util_expit(Util_ravel(pred));
    case 'MultinomialDeviance'
        ouEstimator=y-Util_nan_to_num(exp(Util_ravel(pred(:,k))-Util_ravel(Util_logsumexp(pred,1))));
    case 'ExponentialLoss'
        y_ = -(2 .* y - 1);
        ouEstimator=y_ .*exp(y_ .* Util_ravel(pred));
end
end
