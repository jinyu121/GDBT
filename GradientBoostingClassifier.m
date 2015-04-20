function self=GradientBoostingClassifier( ...
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
    warm_start)
% """Gradient Boosting for regression.
% 
%     GB builds an additive model in a forward stage-wise fashion;
%     it allows for the optimization of arbitrary differentiable loss functions.
%     In each stage a regression tree is fit on the negative gradient of the
%     given loss function.
% 
%     Parameters
%     ----------
%     loss : {'ls', 'lad', 'huber', 'quantile'}, optional (default='ls')
%         loss function to be optimized. 'ls' refers to least squares
%         regression. 'lad' (least absolute deviation) is a highly robust
%         loss function solely based on order information of the input
%         variables. 'huber' is a combination of the two. 'quantile'
%         allows quantile regression (use `alpha` to specify the quantile).
% 
%     learning_rate : float, optional (default=0.1)
%         learning rate shrinks the contribution of each tree by `learning_rate`.
%         There is a trade-off between learning_rate and n_estimators.
% 
%     n_estimators : int (default=100)
%         The number of boosting stages to perform. Gradient boosting
%         is fairly robust to over-fitting so a large number usually
%         results in better performance.
% 
%     max_depth : integer, optional (default=3)
%         maximum depth of the individual regression estimators. The maximum
%         depth limits the number of nodes in the tree. Tune this parameter
%         for best performance; the best value depends on the interaction
%         of the input variables.
%         Ignored if ``max_leaf_nodes`` is not None.
% 
%     min_samples_split : integer, optional (default=2)
%         The minimum number of samples required to split an internal node.
% 
%     min_samples_leaf : integer, optional (default=1)
%         The minimum number of samples required to be at a leaf node.
% 
%     min_weight_fraction_leaf : float, optional (default=0.)
%         The minimum weighted fraction of the input samples required to be at a
%         leaf node.
% 
%     subsample : float, optional (default=1.0)
%         The fraction of samples to be used for fitting the individual base
%         learners. If smaller than 1.0 this results in Stochastic Gradient
%         Boosting. `subsample` interacts with the parameter `n_estimators`.
%         Choosing `subsample < 1.0` leads to a reduction of variance
%         and an increase in bias.
% 
%     max_features : int, float, string or None, optional (default=None)
%         The number of features to consider when looking for the best split:
%           - If int, then consider `max_features` features at each split.
%           - If float, then `max_features` is a percentage and
%             `int(max_features * n_features)` features are considered at each
%             split.
%           - If "auto", then `max_features=n_features`.
%           - If "sqrt", then `max_features=sqrt(n_features)`.
%           - If "log2", then `max_features=log2(n_features)`.
%           - If None, then `max_features=n_features`.
% 
%         Choosing `max_features < n_features` leads to a reduction of variance
%         and an increase in bias.
% 
%         Note: the search for a split does not stop until at least one
%         valid partition of the node samples is found, even if it requires to
%         effectively inspect more than ``max_features`` features.
% 
%     max_leaf_nodes : int or None, optional (default=None)
%         Grow trees with ``max_leaf_nodes`` in best-first fashion.
%         Best nodes are defined as relative reduction in impurity.
%         If None then unlimited number of leaf nodes.
% 
%     alpha : float (default=0.9)
%         The alpha-quantile of the huber loss function and the quantile
%         loss function. Only if ``loss='huber'`` or ``loss='quantile'``.
% 
%     init : BaseEstimator, None, optional (default=None)
%         An estimator object that is used to compute the initial
%         predictions. ``init`` has to provide ``fit`` and ``predict``.
%         If None it uses ``loss.init_estimator``.
% 
%     verbose : int, default: 0
%         Enable verbose output. If 1 then it prints progress and performance
%         once in a while (the more trees the lower the frequency). If greater
%         than 1 then it prints progress and performance for every tree.
% 
%     warm_start : bool, default: False
%         When set to ``True``, reuse the solution of the previous call to fit
%         and add more estimators to the ensemble, otherwise, just erase the
%         previous solution.
% 
% 
%     Attributes
%     ----------
%     feature_importances_ : array, shape = [n_features]
%         The feature importances (the higher, the more important the feature).
% 
%     oob_improvement_ : array, shape = [n_estimators]
%         The improvement in loss (= deviance) on the out-of-bag samples
%         relative to the previous iteration.
%         ``oob_improvement_[0]`` is the improvement in
%         loss of the first stage over the ``init`` estimator.
% 
%     train_score_ : array, shape = [n_estimators]
%         The i-th score ``train_score_[i]`` is the deviance (= loss) of the
%         model at iteration ``i`` on the in-bag sample.
%         If ``subsample == 1`` this is the deviance on the training data.
% 
%     loss_ : LossFunction
%         The concrete ``LossFunction`` object.
% 
%     `init` : BaseEstimator
%         The estimator that provides the initial predictions.
%         Set via the ``init`` argument or ``loss.init_estimator``.
% 
%     estimators_ : list of DecisionTreeRegressor
%         The collection of fitted sub-estimators.
% 
%     See also
%     --------
%     DecisionTreeRegressor, RandomForestRegressor
% 
%     References
%     ----------
%     J. Friedman, Greedy Function Approximation: A Gradient Boosting
%     Machine, The Annals of Statistics, Vol. 29, No. 5, 2001.
% 
%     J. Friedman, Stochastic Gradient Boosting, 1999
% 
%     T. Hastie, R. Tibshirani and J. Friedman.
%     Elements of Statistical Learning Ed. 2, Springer, 2009.
%     """
%构造函数
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