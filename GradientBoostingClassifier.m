function [ self ] =GradientBoostingClassifier( ...
    loss, ...
    learning_rate, ...
    n_estimators, ...
    min_samples_split,...
    min_samples_leaf, ...
    min_weight_fraction_leaf, ...
    max_depth, ...
    init, ...
    subsample, ...
    max_features, ...
    alpha, ...
    verbose, ...
    max_leaf_nodes, ...
    warm_start)
self=GBM(...
    'GradientBoostingClassifier',...
    loss, ...
    learning_rate, ...
    n_estimators, ...
    min_samples_split,...
    min_samples_leaf, ...
    min_weight_fraction_leaf, ...
    max_depth, ...
    init, ...
    subsample, ...
    max_features, ...
    alpha, ...
    verbose, ...
    max_leaf_nodes, ...
    warm_start);
end
