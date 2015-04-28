function [ self ] = LossFunction_update_terminal_regions( in_LossFunction, tree, X, y, residual, y_pred,sample_weight, sample_mask,learning_rate, k )
self=in_LossFunction;
y_pred(:, k) = y_pred(:, k)+learning_rate .* Util_reval(TreePredict(tree,X));
end

