function [ self ] = TreeFit( inTree, X, y, sample_weight)
self=inTree;
        
        n_samples, self.n_features_ = size(X);
        is_classification = false;

        expanded_class_weight = [];

        if y.ndim == 1
            y = Utill_reval(a)';
        end

        self.n_outputs_ = Util_shape(y,1);

        
            self.classes_ = zeros(1,self.n_outputs_);
            self.n_classes_ = ones(1, self.n_outputs_);
        
        if isnan(self.max_depth)
            max_depth=2^31-1;
        else
            max_depth=self.max_depth;
        end
        if isnan(self.max_leaf_nodes)
            max_leaf_nodes=-1;
        else
            max_leaf_nodes=self.max_leaf_nodes;
        end
if isnan(self.max_features )
            max_features = self.n_features_;
elseif strcmp(self.max_features,'auto')
            if is_classification
                    max_features = max(1, floor(sqrt(self.n_features_)));
            else
                    max_features = self.n_features_;
            end
        elseif strcmp(self.max_features,'sqrt')
        
                max_features = max(1, floor(sqrt(self.n_features_)));
            elseif strcmp(self.max_features , 'log2')
                max_features = max(1, int(np.log2(self.n_features_)));
            
        elseif self.max_features>1
            max_features = self.max_features;
elseif self.max_features > 0.0
                max_features = max(1, floor(self.max_features * self.n_features_));
else
                max_features = 0;
            end
        end

        self.max_features_ = max_features;

        if length(y) ~= n_samples
            error('Number of labels does not match number of samples');
        end
        if self.min_samples_split <= 0
            error('min_samples_split must be greater than zero.');
        end
        if self.min_samples_leaf <= 0
            error('min_samples_leaf must be greater than zero.');
        end
        if ~( (0 <= self.min_weight_fraction_leaf)&&(self.min_weight_fraction_leaf <= 0.5))
            error('min_weight_fraction_leaf must in [0, 0.5]');
        end
        if max_depth <= 0
            error('max_depth must be greater than zero. ');
        end
        if ~ ((0 < max_features)&&(max_features <= self.n_features_))
            error('max_features must be in (0, n_features]');
        end
        if ((-1 < max_leaf_nodes)&&(max_leaf_nodes < 2))
            error('max_leaf_nodes must be either smaller than 0 or larger than 1');
        end
        if ~isnan(sample_weight)
            if length(sample_weight) ~= n_samples
                eError('Number of weights does not match number of samples')
            end
        end
        if ~isnan(expanded_class_weight)
            if ~isnan(sample_weight)
                sample_weight = sample_weight * expanded_class_weight;
            else
                sample_weight = expanded_class_weight;
            end
        end
        if self.min_weight_fraction_leaf ~= 0 && ~isnan(sample_weight)
            min_weight_leaf = (self.min_weight_fraction_leaf .*sum(sample_weight));
        else
            min_weight_leaf = 0;
        end
        min_samples_split = max(self.min_samples_split,2 * self.min_samples_leaf);

        
%         ??????????????????????????????????????????????????????????
        
        
        criterion = self.criterion;
        if not isinstance(criterion, Criterion):
            if is_classification:
                criterion = CRITERIA_CLF[self.criterion](self.n_outputs_,
                                                         self.n_classes_)
            else:
                criterion = CRITERIA_REG[self.criterion](self.n_outputs_)
            end
        end
        SPLITTERS = SPARSE_SPLITTERS if issparse(X) else DENSE_SPLITTERS

        splitter = self.splitter
        if not isinstance(self.splitter, Splitter):
            splitter = SPLITTERS[self.splitter](criterion,
                                                self.max_features_,
                                                self.min_samples_leaf,
                                                min_weight_leaf,
                                                random_state)
        end
        self.tree_ = Tree(self.n_features_, self.n_classes_, self.n_outputs_)
        if max_leaf_nodes < 0:
            builder = DepthFirstTreeBuilder(splitter, min_samples_split,
                                            self.min_samples_leaf,
                                            min_weight_leaf,
                                            max_depth)
        else:
            builder = BestFirstTreeBuilder(splitter, min_samples_split,
                                           self.min_samples_leaf,
                                           min_weight_leaf,
                                           max_depth,
                                           max_leaf_nodes)
        end
        builder.build(self.tree_, X, y, sample_weight)

        if self.n_outputs_ == 1:
            self.n_classes_ = self.n_classes_[0]
            self.classes_ = self.classes_[0]
        end

end

