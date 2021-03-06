function [ ouEstimator ] = LossFunction__call__( inLossFunction, y, pred, sample_weight )

self=inLossFunction;

switch self.name
    case 'LeastSquaresError'
        if isempty(sample_weight)
            ouEstimator= mean((y - Util_ravel(pred)) .^ 2.0);
        else
            ouEstimator=(1.0 ./ sum(sample_weight) .*sum(sample_weight .* ((y - Util_ravel(pred)) .^ 2.0)));
        end
    case 'LeastAbsoluteError'
        if isempty(sample_weight)
            ouEstimator=mean(abs(y - Util_ravel(pred)));
        else
            ouEstimator=(1.0 ./ sum(sample_weight) .*sum(sample_weight .* abs(y - Util_ravel(pred))));
        end
    case 'HuberLossFunction'
        pred = Util_ravel(pred);
        diff = y - pred;
        gamma = self.gamma;
        if isnan(self.gamma)
            if isempty(sample_weight )
                % gamma = stats.scoreatpercentile(np.abs(diff), self.alpha * 100)
                gamma = quantile(abs(diff), self.alpha);
            else
                gamma = Stats_weighted_percentile(abs(diff), sample_weight, self.alpha);
            end
        end
        gamma_mask = abs(diff) <= gamma;
        if isempty(sample_weight )
            sq_loss = sum(0.5 .* (diff(gamma_mask)) .^ 2.0);
            lin_loss = sum(gamma .* (abs(diff(~gamma_mask)) - gamma ./ 2.0));
            yshape=Util_shape(y,0);
            ouEstimator = (sq_loss + lin_loss) ./ yshape;
        else
            sq_loss = sum(0.5 .* sample_weight(gamma_mask) .* diff(gamma_mask) .^ 2.0);
            lin_loss = sum(gamma * sample_weight(~gamma_mask) .* (abs(diff(~gamma_mask)) - gamma ./ 2.0));
            ouEstimator = (sq_loss + lin_loss) / sum(sample_weight);
        end
    case 'QuantileLossFunction'
        pred = Util_ravel(pred);
        diff = y - pred;
        alpha = self.alpha;

        mask = y > pred;
        if isempty( sample_weight)
            ouEstimator = ((alpha * sum(diff(mask)) + ...
                (1.0 - alpha) * sum(diff(~mask)))) / Util_shape(y,0);
        else
            ouEstimator = ((alpha * sum(sample_weight(mask) .* diff(mask)) + ...
                (1.0 - alpha) .* sum(sample_weight(~mask) .* diff(~mask))) / ...
                sum(sample_weight));
        end
    case 'BinomialDeviance'
        %         """Compute the deviance (= 2 * negative log-likelihood). """
        %         # logaddexp(0, v) == log(1.0 + exp(v))
        pred = Util_ravel(pred);
        if isempty(sample_weight)
            ouEstimator= -2.0 .* mean((y .* pred) - Util_logaddexp(0.0, pred));
        else
            ouEstimator= (-2.0 / sum(sample_weight) .* ...
                    sum(sample_weight .* ((y .* pred) - Util_logaddexp(0.0, pred))));
        end
    case 'MultinomialDeviance'
        %         # create one-hot label encoding
        Y = zeros(Util_shape(y,1), self.K);
        for k =1:1:self.K
            Y(:,k) = (y == k)';
        end
        if isempty(sample_weight )
            ouEstimator= sum(-1 .* sum((Y .* pred),2) + Util_logsumexp(pred, 1)');
        else
            ouEstimator= sum(-1 .* sample_weight' .* sum((Y .* pred),2) + Util_logsumexp(pred, 1)');
        end
    case 'ExponentialLoss'
        pred = Util_ravel(pred);
        if isempty(sample_weight)
            ouEstimator= mean(exp(-(2. * y - 1.) * pred));
        else
            ouEstimator= (1.0 ./ sum(sample_weight)) * ...
                            sum(sample_weight .* exp(-(2 * y - 1) .* pred));
        end
end

end
