function [ proba ] = LossFunction_score_to_proba( inLossFunction, score )
self=inLossFunction;

switch self.name
    case 'BinomialDeviance'
        proba = ones(Util_shape(score,0), 2);
        1.0 ./ (1.0 + exp(-score));
        proba(:, 2) = 1.0 ./ (1.0 + exp(Util_ravel(-score)));
        proba(:, 1) = proba(:, 1)-proba(:, 2);
    case 'MultinomialDeviance'
        lsc=Util_ravel(Util_logsumexp(score, 1));
        lsc=lsc';
        for i=2:1:Util_shape(score,1)
            lsc(:,i)=lsc(:,1);
        end
        proba=Util_nan_to_num( ...
            exp(score - lsc));
    case 'ExponentialLoss'
        proba = ones(Util_shape(score,0), 2);
        proba(:, 2) = 1.0 / (1.0 + exp(-2.0 * Util_ravel(score)));
        proba(:, 1) = proba(:, 1)-proba(:, 2);
end
end
