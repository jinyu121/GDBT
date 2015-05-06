function [ self ] = LossFunction_update_terminal_regions( in_LossFunction, tree, X, y, residual, y_pred,sample_weight, sample_mask,learning_rate, k )
self=in_LossFunction;
if strcmp(self.name,'LeastSquaresError')
    y_pred(:, k) = y_pred(:, k)+learning_rate .* Util_reval(TreePredict(tree,X));
else
    % Todo: What's this?
    %     terminal_regions = tree.apply(X);
    
    masked_terminal_regions = terminal_regions;
    masked_terminal_regions(~sample_mask) = -1;
    
    % Todo: And There???
    for leaf=1:1:length(tree.Children)
        LossFunction__update_terminal_region(self,tree, masked_terminal_regions, ...
                tree.Children(leaf), X, y, residual, ...
                y_pred(:, k), sample_weight);
        
        treevaluetake=tree.value(:, 0, 0);
        y_pred(:, k) = y_pred(:, k)+ (learning_rate .* treevaluetake(terminal_regions,:));
    end
    
end

