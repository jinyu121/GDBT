function [ self , y_pred] = LossFunction_update_terminal_regions( in_LossFunction, intree, X, y, residual, iny_pred,sample_weight, sample_mask,learning_rate, k )
%         """Update the terminal regions (=leaves) of the given tree and
%         updates the current predictions of the model. Traverses tree
%         and invokes template method `_update_terminal_region`.
self=in_LossFunction;
tree=intree;
y_pred=iny_pred;

if strcmpi(self.name,'LeastSquaresError')
    y_pred(:, k) = y_pred(:, k)+learning_rate .* Util_ravel(TreePredict(tree,X));
else
    [foo,terminal_regions]=resubPredict(tree);
%     terminal_regions = Tree_apply(tree,X);

    masked_terminal_regions = terminal_regions;
    masked_terminal_regions(~sample_mask) = -1;
    
    leafLocation=find(tree.IsBranch==0);
    treevalue=tree.CutPoint;

    for leaf=1:1:length(leafLocation)
        [self,treevalue]=LossFunction__update_terminal_region(self,treevalue, masked_terminal_regions, ...
                leafLocation(leaf), X, y, residual, ...
                y_pred(:, k), sample_weight);
    end
    
    y_pred(:, k) = y_pred(:, k)+ (learning_rate .* treevalue(terminal_regions,:));

end
