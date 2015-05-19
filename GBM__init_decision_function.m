function [ score ] = GBM__init_decision_function( inself,X )
self=inself;

%% """Check input and compute prediction of ``init``. """
if Util_is_none(self.estimators_)
    error('Estimator not fitted, call `fit` before making predictions`.')
end

if Util_shape(X,1) ~= self.n_features
    Util_shape(X,1)
    self.n_features
    error('Shape not match');
end
score = EstimatorPredict(self.init_,X);

end

