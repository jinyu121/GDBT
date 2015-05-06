function [ self,y_pred ] = GBM__fit_stage( inself, i, X, y, y_pred, sample_weight, sample_mask,criterion, splitter, random_state )
self=inself;
loss = self.loss_;
original_y = y;

for k=1:1:loss.K
    if loss.is_multi_class
        y=(original_y == k);
    end
    residual = LossFunction_negative_gradient(loss,y, y_pred, k,sample_weight);
    if self.subsample < 1.0
        sample_weight = sample_weight .* sample_mask;
    end
    % Todo: generate this tree!!!
    %     tree=fitrtree();
    
    % # update tree leaves
    [loss,tree]=LossFunction_update_terminal_regions(loss,tree.tree_, X, y, residual, y_pred,sample_weight, sample_mask,self.learning_rate, k);
    % #add tree to ensemble
    self.estimators_(i, k) = tree;
end

end
