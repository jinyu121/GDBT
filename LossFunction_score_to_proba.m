function [ proba ] = LossFunction_score_to_proba( inLossFunction, score )
self=inLossFunction;

switch self.name
    case 'BinomialDeviance'
        proba = ones(Util_shape0(score), 2);
        proba(:, 2) = 1.0 / (1.0 + exp(Util_reval(-score)));
        proba(:, 1) = proba(:, 1)-proba(:, 2);
    case 'MultinomialDeviance'
        proba=Util_nan_to_num(exp(score - (Util_logsumexp(score, 1)(:, np.newaxis))));
    case 'ExponentialLoss'
        proba = ones(Util_shape0(score), 2);
        proba(:, 2) = 1.0 / (1.0 + exp(-2.0 * Util_reval(score)));
        proba(:, 1) = proba(:, 1)-proba(:, 2);
end
end

