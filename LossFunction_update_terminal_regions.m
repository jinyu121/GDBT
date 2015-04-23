function [ self ] = LossFunction_update_terminal_regions( in_LossFunction, tree, X, y, residual, y_pred,sample_weight, sample_mask,learning_rate, k )
self=in_LossFunction;

% TODO
% I can't read them at all!

% # compute leaf for each sample in ``X``.
% terminal_regions = tree.apply(X)

% # mask all which are not in sample mask.
masked_terminal_regions = terminal_regions
masked_terminal_regions(~sample_mask) = -1

% # update each leaf (= perform line search)
% for leaf in np.where(tree.children_left == TREE_LEAF)[0]:
%     self._update_terminal_region(tree, masked_terminal_regions,
%     leaf, X, y, residual,
%     y_pred[:, k], sample_weight)
%     
% %     # update predictions (both in-bag and out-of-bag)
%     y_pred[:, k] += (learning_rate* tree.value[:, 0, 0].take(terminal_regions, axis=0))
end

