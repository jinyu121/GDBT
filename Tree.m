function [ output_args ] = Tree( criterion, ...
    splitter, ...
    max_depth, ...
    min_samples_split, ...
    min_samples_leaf, ...
    min_weight_fraction_leaf, ...
    max_features, ...
    max_leaf_nodes, ...
    random_state, ...
    class_weight )
self.criterion = criterion;
self.splitter = splitter;
self.max_depth = max_depth;
self.min_samples_split = min_samples_split;
self.min_samples_leaf = min_samples_leaf;
self.min_weight_fraction_leaf = min_weight_fraction_leaf;
self.max_features = max_features;
self.random_state = random_state;
self.max_leaf_nodes = max_leaf_nodes;
self.class_weight = class_weight;

self.n_features_ = nan;
self.n_outputs_ = nan;
self.classes_ = nan;
self.n_classes_ = nan;

self.tree_ = nan;
self.max_features_ = nan;
end

