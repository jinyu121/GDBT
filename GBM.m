function [ self ] = GBM( name, ...
    loss, ...
    learning_rate,   ...
    n_estimators, ...
    max_depth, ...
    min_samples_split, ...
    min_samples_leaf, ...
    min_weight_fraction_leaf,    ...
    subsample, ...
    max_leaf_nodes,  ...
    alpha, ...
    init, ...
    verbose, ...
    max_features,  ...
    warm_start )

%构造函数
self.name=name;
self.n_estimators = n_estimators;
self.learning_rate = learning_rate;
self.loss = loss;
self.min_samples_split = min_samples_split;
self.min_samples_leaf = min_samples_leaf;
self.min_weight_fraction_leaf = min_weight_fraction_leaf;
self.subsample = subsample;
self.max_features = max_features;
self.max_depth = max_depth;
self.init = init;
% self.random_state = random_state;
self.alpha = alpha;  % The default alpha is 0.9
self.verbose = verbose; % The default verbose is 0
self.max_leaf_nodes = max_leaf_nodes;   % The default max_leaf_nodes is null
self.warm_start = warm_start;   % The default warm_start is False
self.estimators_=cell(1,1);
self.is_initialized=false;

self.oob_improvement_=[];
self.train_score_=[];
self.loss_=cell(1,1);
end
