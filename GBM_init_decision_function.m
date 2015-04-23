function [ self,score ] = GBM_init_decision_function( inself,X )
self=inself;

%% """Check input and compute prediction of ``init``. """
if isempty(self.estimators_) || (length(self.estimators_)==0)
    error('Estimator not fitted, call `fit` before making predictions`.')
end
Xshape=size(X);
if Xshape(2) ~= self.n_features
    error('Shape not match');
end
score = EstimatorPredict(self.init_,X);

end

