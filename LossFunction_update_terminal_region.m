function [ self,tree ] = LossFunction_update_terminal_region(inLossFunction, intree, terminal_regions, leaf, X, y,residual, pred, sample_weight )
self=inLossFunction;
tree=intree;

terminal_region = find(terminal_regions == leaf);
diff = (y(terminal_region,:)- pred(terminal_region,:));
sample_weight = sample_weight(terminal_region,:);
residual = residual(terminal_region,:);
y = y(terminal_region,:);
pred = pred(terminal_region,:);

switch self.name
    case 'LeastSquaresError'
        y_pred(:, k) =y_pred(:, k)+ learning_rate * Util_eval(TreePredict(tree,X));
    case 'LeastAbsoluteError'
        tree.value(leaf, 0, 0) = Stats_weighted_percentile(diff, sample_weight, 50);
    case 'HuberLossFunction'
        gamma = self.gamma
        median = Stats_weighted_percentile(diff, sample_weight, 50);
        diff_minus_median = diff - median;
        tree.value(leaf, 0) = median + mean(sign(diff_minus_median) .*min(abs(diff_minus_median), gamma));
    case 'QuantileLossFunction'
        val = Stats_weighted_percentile(diff, sample_weight, self.percentile);
        tree.value(leaf, 0) = val;
    case 'BinomialDeviance'
        numerator = sum(sample_weight .* residual);
        denominator = sum(sample_weight * (y - residual) * (1 - y + residual));
        
        if denominator == 0.0
            tree.value(leaf, 0, 0) = 0.0;
        else
            tree.value(leaf, 0, 0) = numerator ./ denominator;
        end
    case 'MultinomialDeviance'
        
        numerator = sum(sample_weight * residual);
        numerator = numerator.*((self.K - 1) ./ self.K);
        
        denominator = sum(sample_weight .* (y - residual) .*(1.0 - y + residual));
        
        if denominator == 0.
            tree.value(leaf, 0, 0)= 0.0;
        else
            tree.value(leaf, 0, 0) = numerator ./ denominator;
        end
    case 'ExponentialLoss'
        y_ = 2. * y - 1.;
        
        numerator = sum(y_ .* sample_weight .* exp(-y_ * pred));
        denominator = sum(sample_weight .* exp(-y_ * pred));
        
        if denominator == 0.0
            tree.value(leaf, 0, 0) = 0.0;
        else
            tree.value(leaf, 0, 0) = numerator ./ denominator;
        end
        
end
end

