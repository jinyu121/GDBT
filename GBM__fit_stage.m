function [ self,y_pred ] = GBM__fit_stage( ingbm, i, X, y, y_pred, sample_weight, sample_mask,criterion, splitter )
self=ingbm;
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
    
%             tree = DecisionTreeRegressor(
%                 criterion=criterion,
%                 splitter=splitter,
%                 max_depth=self.max_depth,
%                 min_samples_split=self.min_samples_split,
%                 min_samples_leaf=self.min_samples_leaf,
%                 min_weight_fraction_leaf=self.min_weight_fraction_leaf,
%                 max_features=self.max_features,
%                 max_leaf_nodes=self.max_leaf_nodes,
%                 random_state=random_state)

%       AlgCat            - Algorithm to find categorical splits for classification.
%       MaxCat            - Use inexact search if a categorical predictor has more than MaxCat levels.
%       MergeLeaves       - Flag for merging leaves after tree is grown
%       MinParent         - Minimal size of parent node in tree
%       MinLeaf           - Minimal size of leaf node in tree
%       NSurrogate        - Number of surrogate splits to find
%       NVarToSample      - Number of predictors to select at random for decision split
%       Prune             - Flag for computing the optimal pruning sequence
%       PruneCriterion    - 'error' or 'impurity' for classification and 'mse' for regression
%       QEToler           - Tolerance on mean squared error per tree node (regression only)
%       SplitCriterion    - 'gdi', 'twoing' or 'deviance' for classification and 'mse' for regression
%       Stream            - Random stream for random selection of predictors

    tree=fitrtree(X,residual, ...
         'Weights',         sample_weight, ...
         'SplitCriterion',  'mse', ...
         'MinParent',       self.min_samples_split, ...
         'MinLeaf',         self.min_samples_leaf ...
        );
    
    % # update tree leaves
    [loss,y_pred]=LossFunction_update_terminal_regions(loss,tree, X, y, residual, y_pred,sample_weight, sample_mask,self.learning_rate, k);

    % #add tree to ensemble
    self.estimators_{i, k} = tree;
end

end
